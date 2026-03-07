#include "vnr_state.hpp"

#include <algorithm>
#include <numeric>
#include <stdexcept>

namespace azsfc {

namespace {
constexpr double kEpsilon = 1e-8;

double safe_lookup(const std::unordered_map<std::string, double>& table, const std::string& key) {
    auto it = table.find(key);
    if (it == table.end()) {
        return 0.0;
    }
    return it->second;
}

std::vector<std::pair<int, int>> path_to_links(const std::vector<int>& nodes) {
    std::vector<std::pair<int, int>> links;
    if (nodes.size() < 2) {
        return links;
    }
    links.reserve(nodes.size() - 1);
    for (std::size_t i = 1; i < nodes.size(); ++i) {
        links.emplace_back(nodes[i - 1], nodes[i]);
    }
    return links;
}
}  // namespace

VNRState::VNRState(std::shared_ptr<const Network> physical,
                   std::shared_ptr<const Network> virtual_net,
                   VNRConfig config)
    : p_net_(std::move(physical)),
      v_net_(std::move(virtual_net)),
      config_(std::move(config)),
      allocation_deltas_(std::make_shared<AllocationDelta>()) {
    if (!p_net_) {
        throw std::invalid_argument("VNRState requires a valid physical network reference.");
    }
    if (!v_net_) {
        throw std::invalid_argument("VNRState requires a valid virtual network reference.");
    }

    std::size_t mask_words = static_cast<std::size_t>((p_net_->num_nodes + 63) / 64);
    if (mask_words == 0) {
        mask_words = 1;
    }
    selected_p_mask_.assign(mask_words, std::uint64_t{0});

    reject_action_id_ = p_net_->num_nodes;
    p_node_id_ = reject_action_id_;

    initialise_virtual_order();
}

void VNRState::initialise_virtual_order() {
    int v_nodes = v_net_->num_nodes;
    std::vector<std::pair<int, double>> scores;
    scores.reserve(v_nodes);

    for (int v = 0; v < v_nodes; ++v) {
        double node_sum = 0.0;
        const auto& node_attrs = v_net_->node_attrs[v];
        for (const auto& attr_name : config_.node_resource_names) {
            node_sum += safe_lookup(node_attrs, attr_name);
        }

        double edge_sum = 0.0;
        for (const auto& [neighbor, edge_id] : v_net_->adjacency[v]) {
            const auto& edge_attrs = v_net_->edge_attrs[edge_id];
            for (const auto& attr_name : config_.link_resource_names) {
                edge_sum += safe_lookup(edge_attrs, attr_name);
            }
        }

        scores.emplace_back(v, node_sum + edge_sum);
    }

    std::stable_sort(scores.begin(), scores.end(), [](const auto& a, const auto& b) {
        return a.second > b.second;
    });

    v_order_.clear();
    v_order_.reserve(scores.size());
    for (const auto& [node_id, _] : scores) {
        v_order_.push_back(node_id);
    }

    if (v_order_.empty()) {
        v_order_.resize(v_nodes);
        std::iota(v_order_.begin(), v_order_.end(), 0);
    }

    v_pos_.assign(v_nodes, 0);
    for (std::size_t idx = 0; idx < v_order_.size(); ++idx) {
        v_pos_[v_order_[idx]] = static_cast<int>(idx);
    }

    total_node_demand_ = 0.0;
    for (int v = 0; v < v_nodes; ++v) {
        const auto& node_attrs = v_net_->node_attrs[v];
        for (const auto& attr_name : config_.node_resource_names) {
            total_node_demand_ += safe_lookup(node_attrs, attr_name);
        }
    }

    double total_link_demand = 0.0;
    for (int e = 0; e < v_net_->num_edges; ++e) {
        const auto& edge_attrs = v_net_->edge_attrs[e];
        for (const auto& attr_name : config_.link_resource_names) {
            total_link_demand += safe_lookup(edge_attrs, attr_name);
        }
    }
    total_v_revenue_ = total_node_demand_ + total_link_demand;
}

bool VNRState::selected_mask_contains(const std::vector<std::uint64_t>& mask, int node_id) noexcept {
    if (node_id < 0) {
        return false;
    }
    const std::size_t idx = static_cast<std::size_t>(node_id);
    const std::size_t word = idx >> 6U;
    if (word >= mask.size()) {
        return false;
    }
    const std::size_t bit = idx & 63U;
    return (mask[word] & (std::uint64_t{1} << bit)) != 0U;
}

void VNRState::selected_mask_set(std::vector<std::uint64_t>& mask, int node_id) noexcept {
    if (node_id < 0) {
        return;
    }
    const std::size_t idx = static_cast<std::size_t>(node_id);
    const std::size_t word = idx >> 6U;
    if (word >= mask.size()) {
        return;
    }
    const std::size_t bit = idx & 63U;
    mask[word] |= (std::uint64_t{1} << bit);
}

bool VNRState::is_physical_selected(int p_node_id) const noexcept {
    return selected_mask_contains(selected_p_mask_, p_node_id);
}

void VNRState::mark_physical_selected(int p_node_id) {
    selected_mask_set(selected_p_mask_, p_node_id);
}

int VNRState::lookup_placement(int v_node_id) const {
    auto cursor = placement_deltas_;
    while (cursor) {
        if (cursor->v_node_id == v_node_id) {
            return cursor->p_node_id;
        }
        cursor = cursor->parent;
    }
    return -1;
}

void VNRState::add_allocation_delta(AllocationDelta::SparseAllocations& allocations,
                                    int item_id,
                                    const std::string& attr,
                                    double value) {
    if (value <= 0.0) {
        return;
    }
    allocations[item_id][attr] += value;
}

double VNRState::lookup_allocation_delta(const std::shared_ptr<const AllocationDelta>& delta_root,
                                         int item_id,
                                         const std::string& attr,
                                         bool node_resource) {
    double total = 0.0;
    auto cursor = delta_root;
    while (cursor) {
        const auto& allocations = node_resource ? cursor->node_allocations : cursor->link_allocations;
        auto item_it = allocations.find(item_id);
        if (item_it != allocations.end()) {
            auto value_it = item_it->second.find(attr);
            if (value_it != item_it->second.end()) {
                total += value_it->second;
            }
        }
        cursor = cursor->parent;
    }
    return total;
}

void VNRState::rebuild_allocation_totals_cache() const {
    node_allocation_totals_cache_.clear();
    link_allocation_totals_cache_.clear();

    auto cursor = allocation_deltas_;
    while (cursor) {
        for (const auto& [node_id, resources] : cursor->node_allocations) {
            auto& out = node_allocation_totals_cache_[node_id];
            for (const auto& [attr, value] : resources) {
                if (value <= 0.0) {
                    continue;
                }
                out[attr] += value;
            }
        }
        for (const auto& [edge_id, resources] : cursor->link_allocations) {
            auto& out = link_allocation_totals_cache_[edge_id];
            for (const auto& [attr, value] : resources) {
                if (value <= 0.0) {
                    continue;
                }
                out[attr] += value;
            }
        }
        cursor = cursor->parent;
    }
    allocation_totals_cache_valid_ = true;
}

double VNRState::get_allocated_node_resource(int node_id, const std::string& attr) const {
    if (!allocation_totals_cache_valid_) {
        rebuild_allocation_totals_cache();
    }
    auto node_it = node_allocation_totals_cache_.find(node_id);
    if (node_it == node_allocation_totals_cache_.end()) {
        return 0.0;
    }
    auto attr_it = node_it->second.find(attr);
    if (attr_it == node_it->second.end()) {
        return 0.0;
    }
    return attr_it->second;
}

double VNRState::get_allocated_link_resource(int edge_id, const std::string& attr) const {
    if (!allocation_totals_cache_valid_) {
        rebuild_allocation_totals_cache();
    }
    auto edge_it = link_allocation_totals_cache_.find(edge_id);
    if (edge_it == link_allocation_totals_cache_.end()) {
        return 0.0;
    }
    auto attr_it = edge_it->second.find(attr);
    if (attr_it == edge_it->second.end()) {
        return 0.0;
    }
    return attr_it->second;
}

std::vector<int> VNRState::get_candidate_nodes() const {
    std::vector<int> candidates;
    int next_index = v_node_index_ + 1;
    if (next_index >= static_cast<int>(v_order_.size())) {
        if (config_.allow_rejection) {
            candidates.push_back(reject_action_id_);
        }
        return candidates;
    }

    int v_target = v_order_[next_index];

    struct LinkRequirement {
        int p_neighbor;
        ResourceMap demands;
    };
    std::vector<LinkRequirement> link_requirements;
    if (!config_.link_resource_names.empty()) {
        const auto& v_adj = v_net_->adjacency[v_target];
        for (const auto& [neighbor, edge_id] : v_adj) {
            int neighbor_pos = v_pos_[neighbor];
            if (neighbor_pos > v_node_index_) {
                continue;
            }
            int mapped_neighbor = lookup_placement(neighbor);
            if (mapped_neighbor < 0) {
                continue;
            }
            LinkRequirement req;
            req.p_neighbor = mapped_neighbor;
            const auto& edge_attrs = v_net_->edge_attrs[edge_id];
            req.demands.reserve(config_.link_resource_names.size());
            for (const auto& attr_name : config_.link_resource_names) {
                double demand = safe_lookup(edge_attrs, attr_name);
                if (demand > 0.0) {
                    req.demands[attr_name] = demand;
                }
            }
            if (!req.demands.empty()) {
                link_requirements.push_back(std::move(req));
            }
        }
    }

    for (int p = 0; p < p_net_->num_nodes; ++p) {
        if (is_physical_selected(p)) {
            continue;
        }
        if (check_node_constraints_feasible(v_target, p)) {
            bool reachable = true;
            for (const auto& req : link_requirements) {
                if (!has_reachable_path(p, req.p_neighbor, req.demands)) {
                    reachable = false;
                    break;
                }
            }
            if (reachable) {
                candidates.push_back(p);
            }
        }
    }

    if (config_.allow_rejection) {
        candidates.push_back(reject_action_id_);
    }

    if (candidates.empty()) {
        candidates.push_back(-1);
    }

    return candidates;
}

bool VNRState::has_reachable_path(int p_src, int p_dst, const ResourceMap& demands) const {
    if (!p_net_) {
        return false;
    }
    if (p_src == p_dst) {
        return true;
    }
    if (p_src < 0 || p_src >= p_net_->num_nodes || p_dst < 0 || p_dst >= p_net_->num_nodes) {
        return false;
    }
    if (demands.empty()) {
        return true;
    }

    std::vector<char> visited(static_cast<std::size_t>(p_net_->num_nodes), 0);
    std::vector<int> queue;
    queue.reserve(static_cast<std::size_t>(p_net_->num_nodes));
    visited[static_cast<std::size_t>(p_src)] = 1;
    queue.push_back(p_src);
    std::size_t head = 0;

    while (head < queue.size()) {
        int u = queue[head++];
        const auto& neighbors = p_net_->adjacency[u];
        for (const auto& [neighbor, edge_id] : neighbors) {
            if (visited[static_cast<std::size_t>(neighbor)]) {
                continue;
            }
            bool ok = true;
            for (const auto& [attr, demand] : demands) {
                if (demand <= 0.0) {
                    continue;
                }
                double available = get_available_link_resource(edge_id, attr);
                if (available + kEpsilon < demand) {
                    ok = false;
                    break;
                }
            }
            if (!ok) {
                continue;
            }
            if (neighbor == p_dst) {
                return true;
            }
            visited[static_cast<std::size_t>(neighbor)] = 1;
            queue.push_back(neighbor);
        }
    }
    return false;
}

bool VNRState::is_terminal() const {
    if (rejected_) {
        return true;
    }
    if (p_node_id_ == -1) {
        return true;
    }
    return v_node_index_ == (v_net_->num_nodes - 1);
}

const std::vector<int>& VNRState::selected_physical_nodes() const {
    if (selected_p_nodes_cache_valid_) {
        return selected_p_nodes_cache_;
    }

    selected_p_nodes_cache_.clear();
    if (selected_count_ > 0) {
        selected_p_nodes_cache_.reserve(static_cast<std::size_t>(selected_count_));
    }
    auto cursor = selection_deltas_;
    while (cursor) {
        selected_p_nodes_cache_.push_back(cursor->p_node_id);
        cursor = cursor->parent;
    }
    std::reverse(selected_p_nodes_cache_.begin(), selected_p_nodes_cache_.end());
    selected_p_nodes_cache_valid_ = true;
    return selected_p_nodes_cache_;
}

std::vector<int> VNRState::node_slots() const {
    if (node_slots_cache_valid_) {
        return node_slots_cache_;
    }
    int v_nodes = v_net_ ? v_net_->num_nodes : 0;
    node_slots_cache_.assign(static_cast<std::size_t>(v_nodes), -1);
    auto cursor = placement_deltas_;
    while (cursor) {
        if (cursor->v_node_id >= 0 && cursor->v_node_id < v_nodes) {
            node_slots_cache_[static_cast<std::size_t>(cursor->v_node_id)] = cursor->p_node_id;
        }
        cursor = cursor->parent;
    }
    node_slots_cache_valid_ = true;
    return node_slots_cache_;
}

float VNRState::compute_final_reward() const {
    if (rejected_) {
        return static_cast<float>(-config_.reject_penalty);
    }
    if (p_node_id_ == -1) {
        return -1000.0f;
    }
    if (selected_count_ != v_net_->num_nodes) {
        return -1000.0f;
    }

    double link_cost = sum_link_allocations();
    double total_cost = total_node_demand_ + link_cost;
    double reward = 1000.0 + total_v_revenue_ - total_cost;
    return static_cast<float>(reward);
}

double VNRState::sum_link_allocations() const {
    return total_link_allocation_;
}

VNRState VNRState::create_child(int p_node_id) const {
    return create_child_internal(p_node_id, nullptr);
}

VNRState VNRState::create_child_with_info(int p_node_id, PlacementInfo* info) const {
    return create_child_internal(p_node_id, info);
}

VNRState VNRState::create_child_internal(int p_node_id, PlacementInfo* info) const {
    VNRState child(*this);
    child.selected_p_nodes_cache_valid_ = false;
    child.node_slots_cache_valid_ = false;
    child.node_slots_cache_.clear();
    child.allocation_totals_cache_valid_ = false;
    child.node_allocation_totals_cache_.clear();
    child.link_allocation_totals_cache_.clear();
    child.v_node_index_ = v_node_index_ + 1;
    child.p_node_id_ = p_node_id;
    child.last_place_info_ = PlacementInfo{};
    if (info) {
        *info = child.last_place_info_;
    }

    if (p_node_id == reject_action_id_) {
        if (config_.allow_rejection) {
            child.rejected_ = true;
        } else {
            child.p_node_id_ = -1;
        }
        return child;
    }

    if (p_node_id == -1) {
        child.p_node_id_ = -1;
        return child;
    }

    auto step_delta = std::make_shared<AllocationDelta>();
    step_delta->parent = allocation_deltas_;
    child.allocation_deltas_ = step_delta;

    auto selection_delta = std::make_shared<SelectionDelta>();
    selection_delta->parent = selection_deltas_;
    selection_delta->p_node_id = p_node_id;
    child.selection_deltas_ = std::move(selection_delta);
    child.selected_count_ = selected_count_ + 1;
    child.mark_physical_selected(p_node_id);

    if (child.v_node_index_ < static_cast<int>(child.v_order_.size())) {
        int v_target = child.v_order_[child.v_node_index_];
        bool feasible = false;
        if (info) {
            PlacementInfo place_info = child.check_node_constraints(v_target, p_node_id);
            child.last_place_info_ = place_info;
            child.total_hard_constraint_violation_ = total_hard_constraint_violation_ + place_info.max_hard_violation;
            *info = place_info;
            feasible = place_info.feasible;
        } else {
            feasible = child.check_node_constraints_feasible(v_target, p_node_id);
            child.total_hard_constraint_violation_ = total_hard_constraint_violation_;
        }
        if (!feasible) {
            child.p_node_id_ = -1;
            return child;
        }
        if (!child.reserve_link_resources(v_target, p_node_id, child, *step_delta)) {
            child.p_node_id_ = -1;
            return child;
        }
        child.update_node_allocations(p_node_id, v_target, *step_delta);
        auto placement_delta = std::make_shared<PlacementDelta>();
        placement_delta->parent = placement_deltas_;
        placement_delta->v_node_id = v_target;
        placement_delta->p_node_id = p_node_id;
        child.placement_deltas_ = std::move(placement_delta);
    }
    child.total_link_allocation_ = total_link_allocation_ + step_delta->link_allocation_total;

    return child;
}

void VNRState::update_node_allocations(int p_node_id, int v_node_id, AllocationDelta& delta) const {
    const auto& v_attrs = v_net_->node_attrs[v_node_id];
    for (const auto& attr_name : config_.node_resource_names) {
        double demand = safe_lookup(v_attrs, attr_name);
        if (demand <= 0.0) {
            continue;
        }
        add_allocation_delta(delta.node_allocations, p_node_id, attr_name, demand);
    }
}

bool VNRState::check_node_constraints_feasible(int v_node_id, int p_node_id) const {
    if (!p_net_ || !v_net_) {
        return false;
    }
    if (p_node_id < 0 || p_node_id >= p_net_->num_nodes) {
        return false;
    }
    if (v_node_id < 0 || v_node_id >= v_net_->num_nodes) {
        return false;
    }
    const auto& constraints = config_.node_constraint_names.empty()
                                  ? config_.node_resource_names
                                  : config_.node_constraint_names;
    if (constraints.empty()) {
        return true;
    }
    bool has_hard_list = !config_.hard_constraint_names.empty();
    const auto& v_attrs = v_net_->node_attrs[v_node_id];
    for (const auto& attr_name : constraints) {
        double demand = safe_lookup(v_attrs, attr_name);
        if (demand <= 0.0) {
            continue;
        }
        double available = get_available_node_resource(p_node_id, attr_name);
        bool is_hard = true;
        if (has_hard_list) {
            is_hard = std::find(config_.hard_constraint_names.begin(),
                                config_.hard_constraint_names.end(),
                                attr_name) != config_.hard_constraint_names.end();
        }
        if (is_hard && available + kEpsilon < demand) {
            return false;
        }
    }
    return true;
}

VNRState::PlacementInfo VNRState::check_node_constraints(int v_node_id, int p_node_id) const {
    PlacementInfo info;
    info.v_node_id = v_node_id;
    info.p_node_id = p_node_id;
    if (!p_net_ || !v_net_) {
        info.feasible = false;
        return info;
    }
    if (p_node_id < 0 || p_node_id >= p_net_->num_nodes) {
        info.feasible = false;
        return info;
    }
    if (v_node_id < 0 || v_node_id >= v_net_->num_nodes) {
        info.feasible = false;
        return info;
    }
    const auto& constraints = config_.node_constraint_names.empty()
                                  ? config_.node_resource_names
                                  : config_.node_constraint_names;
    if (constraints.empty()) {
        return info;
    }
    bool has_hard_list = !config_.hard_constraint_names.empty();
    const auto& v_attrs = v_net_->node_attrs[v_node_id];
    for (const auto& attr_name : constraints) {
        double demand = safe_lookup(v_attrs, attr_name);
        double available = get_available_node_resource(p_node_id, attr_name);
        double offset = demand - available;
        info.offsets[attr_name] = offset;

        bool is_hard = true;
        if (has_hard_list) {
            is_hard = std::find(config_.hard_constraint_names.begin(),
                                config_.hard_constraint_names.end(),
                                attr_name) != config_.hard_constraint_names.end();
        }
        if (is_hard) {
            if (offset > info.max_hard_violation) {
                info.max_hard_violation = offset;
            }
            if (offset > kEpsilon) {
                info.feasible = false;
            }
        }
    }
    if (info.max_hard_violation < 0.0) {
        info.max_hard_violation = 0.0;
    }
    return info;
}

bool VNRState::reserve_link_resources(int new_virtual_node,
                                      int new_physical_node,
                                      VNRState& target,
                                      AllocationDelta& delta) const {
    for (const auto& [neighbor, edge_id] : v_net_->adjacency[new_virtual_node]) {
        (void)edge_id;
        int neighbor_pos = target.v_pos_[neighbor];
        if (neighbor_pos > target.v_node_index_) {
            continue;
        }
        int mapped_neighbor = target.lookup_placement(neighbor);
        if (mapped_neighbor < 0) {
            continue;
        }
        if (!reserve_path_for_virtual_edge(new_virtual_node, neighbor, new_physical_node, mapped_neighbor, target, delta)) {
            return false;
        }
    }
    return true;
}

bool VNRState::reserve_path_for_virtual_edge(int v_src,
                                             int v_dst,
                                             int p_src,
                                             int p_dst,
                                             VNRState& target,
                                             AllocationDelta& delta) const {
    auto it = v_net_->edge_index.find({v_src, v_dst});
    if (it == v_net_->edge_index.end()) {
        it = v_net_->edge_index.find({v_dst, v_src});
    }
    if (it == v_net_->edge_index.end()) {
        return false;
    }
    int v_edge_id = it->second;
    ResourceMap demands;
    demands.reserve(config_.link_resource_names.size());
    const auto& edge_attrs = v_net_->edge_attrs[v_edge_id];
    for (const auto& attr_name : config_.link_resource_names) {
        demands[attr_name] = safe_lookup(edge_attrs, attr_name);
    }

    int k = std::max(1, config_.k_shortest);
    std::string method = config_.shortest_method.empty() ? "bfs_shortest" : config_.shortest_method;
    if (method == "bfs_shortest" || method == "first_shortest" || method == "available_shortest") {
        k = 1;
    }
    auto capacity_fn = [&target](int edge_id, const std::string& attr) {
        return target.get_available_link_resource(edge_id, attr);
    };
    auto paths = path_finder_.find_paths(*p_net_, p_src, p_dst, k, demands, method, capacity_fn);
    if (paths.empty()) {
        return false;
    }

    const std::vector<int>* selected_path = nullptr;
    for (const auto& candidate : paths) {
        if (candidate.nodes.size() < 2) {
            continue;
        }
        bool feasible = true;
        auto links = path_to_links(candidate.nodes);
        for (const auto& [u, v] : links) {
            auto edge_lookup = p_net_->edge_index.find({u, v});
            if (edge_lookup == p_net_->edge_index.end()) {
                feasible = false;
                break;
            }
            int edge_id = edge_lookup->second;
            for (const auto& [attr, demand] : demands) {
                if (demand <= 0.0) {
                    continue;
                }
                double available = target.get_available_link_resource(edge_id, attr);
                if (available + kEpsilon < demand) {
                    feasible = false;
                    break;
                }
            }
            if (!feasible) {
                break;
            }
        }
        if (feasible) {
            selected_path = &candidate.nodes;
            break;
        }
    }

    // Fallback: if k-shortest produced no feasible path, try capacity-aware search
    std::vector<int> fallback_path_storage;
    if (selected_path == nullptr && method != "available_shortest") {
        auto fallback_paths = path_finder_.find_paths(
            *p_net_, p_src, p_dst, 1, demands, "available_shortest", capacity_fn);
        if (!fallback_paths.empty() && fallback_paths[0].nodes.size() >= 2) {
            fallback_path_storage = std::move(fallback_paths[0].nodes);
            selected_path = &fallback_path_storage;
        }
    }

    if (selected_path == nullptr) {
        return false;
    }

    auto links = path_to_links(*selected_path);
    for (const auto& [u, v] : links) {
        auto edge_lookup = p_net_->edge_index.find({u, v});
        if (edge_lookup == p_net_->edge_index.end()) {
            return false;
        }
        int edge_id = edge_lookup->second;
        for (const auto& [attr, demand] : demands) {
            if (demand <= 0.0) {
                continue;
            }
            add_allocation_delta(delta.link_allocations, edge_id, attr, demand);
            delta.link_allocation_total += demand;
        }
    }

    return true;
}

double VNRState::get_available_node_resource(int node_id, const std::string& attr) const {
    if (node_id < 0 || node_id >= p_net_->num_nodes) {
        return 0.0;
    }
    double capacity = safe_lookup(p_net_->node_attrs[node_id], attr);
    double used = get_allocated_node_resource(node_id, attr);
    return capacity - used;
}

double VNRState::get_available_link_resource(int edge_id, const std::string& attr) const {
    if (edge_id < 0 || edge_id >= p_net_->num_edges) {
        return 0.0;
    }
    double capacity = safe_lookup(p_net_->edge_attrs[edge_id], attr);
    double used = get_allocated_link_resource(edge_id, attr);
    return capacity - used;
}

double VNRState::get_available_link_resource(int u, int v, const std::string& attr) const {
    auto it = p_net_->edge_index.find({u, v});
    if (it == p_net_->edge_index.end()) {
        return 0.0;
    }
    return get_available_link_resource(it->second, attr);
}

VNRState::LinkMappingResult VNRState::link_mapping(const std::vector<int>& node_slots) const {
    LinkMappingResult result;
    if (!p_net_ || !v_net_) {
        return result;
    }
    if (static_cast<int>(node_slots.size()) < v_net_->num_nodes) {
        return result;
    }
    if (v_net_->num_edges == 0) {
        result.success = true;
        return result;
    }

    const auto& resource_names = config_.link_resource_names;
    std::unordered_map<std::string, std::size_t> resource_index;
    resource_index.reserve(resource_names.size());
    for (std::size_t i = 0; i < resource_names.size(); ++i) {
        resource_index.emplace(resource_names[i], i);
    }

    std::vector<std::vector<double>> used;
    used.assign(static_cast<std::size_t>(p_net_->num_edges),
                std::vector<double>(resource_names.size(), 0.0));

    auto capacity_fn = [&](int edge_id, const std::string& attr) -> double {
        auto idx_it = resource_index.find(attr);
        if (idx_it == resource_index.end()) {
            return 0.0;
        }
        if (edge_id < 0 || edge_id >= p_net_->num_edges) {
            return 0.0;
        }
        std::size_t idx = idx_it->second;
        double capacity = safe_lookup(p_net_->edge_attrs[edge_id], attr);
        return capacity - used[static_cast<std::size_t>(edge_id)][idx];
    };

    std::string method = config_.shortest_method.empty() ? "bfs_shortest" : config_.shortest_method;
    int k = std::max(1, config_.k_shortest);
    if (method == "bfs_shortest" || method == "first_shortest" || method == "available_shortest") {
        k = 1;
    }

    result.success = true;
    result.records.reserve(static_cast<std::size_t>(v_net_->num_edges));

    for (const auto& v_edge : v_net_->edges) {
        int v_src = v_edge.first;
        int v_dst = v_edge.second;
        if (v_src < 0 || v_dst < 0 || v_src >= static_cast<int>(node_slots.size())
            || v_dst >= static_cast<int>(node_slots.size())) {
            result.success = false;
            break;
        }

        int p_src = node_slots[static_cast<std::size_t>(v_src)];
        int p_dst = node_slots[static_cast<std::size_t>(v_dst)];
        if (p_src < 0 || p_dst < 0) {
            result.success = false;
            break;
        }
        if (p_src == p_dst) {
            result.success = false;
            break;
        }

        auto edge_it = v_net_->edge_index.find({v_src, v_dst});
        if (edge_it == v_net_->edge_index.end()) {
            edge_it = v_net_->edge_index.find({v_dst, v_src});
        }
        if (edge_it == v_net_->edge_index.end()) {
            result.success = false;
            break;
        }
        int v_edge_id = edge_it->second;

        ResourceMap demands;
        demands.reserve(resource_names.size());
        const auto& v_edge_attrs = v_net_->edge_attrs[v_edge_id];
        for (const auto& name : resource_names) {
            demands[name] = safe_lookup(v_edge_attrs, name);
        }

        auto paths = path_finder_.find_paths(*p_net_, p_src, p_dst, k, demands, method, capacity_fn);
        if (paths.empty()) {
            result.success = false;
            break;
        }

        bool selected = false;
        for (const auto& candidate : paths) {
            if (candidate.nodes.size() < 2) {
                continue;
            }
            auto links = path_to_links(candidate.nodes);
            bool feasible = true;
            for (const auto& [u, v] : links) {
                auto p_edge_it = p_net_->edge_index.find({u, v});
                if (p_edge_it == p_net_->edge_index.end()) {
                    feasible = false;
                    break;
                }
                int edge_id = p_edge_it->second;
                for (const auto& name : resource_names) {
                    double demand = demands[name];
                    if (demand <= 0.0) {
                        continue;
                    }
                    if (capacity_fn(edge_id, name) + kEpsilon < demand) {
                        feasible = false;
                        break;
                    }
                }
                if (!feasible) {
                    break;
                }
            }

            if (!feasible) {
                continue;
            }

            LinkPathRecord record;
            record.v_src = v_src;
            record.v_dst = v_dst;
            record.p_links = links;
            record.p_link_resources.reserve(links.size());

            for (const auto& [u, v] : links) {
                auto p_edge_it = p_net_->edge_index.find({u, v});
                if (p_edge_it == p_net_->edge_index.end()) {
                    feasible = false;
                    break;
                }
                int edge_id = p_edge_it->second;
                ResourceMap used_map;
                used_map.reserve(resource_names.size());
                for (const auto& name : resource_names) {
                    double demand = demands[name];
                    used_map[name] = demand;
                    if (demand > 0.0) {
                        auto idx_it = resource_index.find(name);
                        if (idx_it != resource_index.end()) {
                            used[static_cast<std::size_t>(edge_id)][idx_it->second] += demand;
                        }
                        result.total_link_cost += demand;
                    }
                }
                record.p_link_resources.push_back(std::move(used_map));
            }
            if (!feasible) {
                continue;
            }

            result.records.push_back(std::move(record));
            selected = true;
            break;
        }

        // Fallback: if k-shortest produced no feasible path, try capacity-aware search
        if (!selected && method != "available_shortest") {
            auto fallback_paths = path_finder_.find_paths(
                *p_net_, p_src, p_dst, 1, demands, "available_shortest", capacity_fn);
            for (const auto& candidate : fallback_paths) {
                if (candidate.nodes.size() < 2) {
                    continue;
                }
                auto links = path_to_links(candidate.nodes);
                bool feasible = true;
                for (const auto& [u, v] : links) {
                    auto p_edge_it = p_net_->edge_index.find({u, v});
                    if (p_edge_it == p_net_->edge_index.end()) {
                        feasible = false;
                        break;
                    }
                    int edge_id = p_edge_it->second;
                    for (const auto& name : resource_names) {
                        double demand = demands[name];
                        if (demand <= 0.0) {
                            continue;
                        }
                        if (capacity_fn(edge_id, name) + kEpsilon < demand) {
                            feasible = false;
                            break;
                        }
                    }
                    if (!feasible) {
                        break;
                    }
                }

                if (!feasible) {
                    continue;
                }

                LinkPathRecord record;
                record.v_src = v_src;
                record.v_dst = v_dst;
                record.p_links = links;
                record.p_link_resources.reserve(links.size());

                for (const auto& [u, v] : links) {
                    auto p_edge_it = p_net_->edge_index.find({u, v});
                    if (p_edge_it == p_net_->edge_index.end()) {
                        feasible = false;
                        break;
                    }
                    int edge_id = p_edge_it->second;
                    ResourceMap used_map;
                    used_map.reserve(resource_names.size());
                    for (const auto& name : resource_names) {
                        double demand = demands[name];
                        used_map[name] = demand;
                        if (demand > 0.0) {
                            auto idx_it = resource_index.find(name);
                            if (idx_it != resource_index.end()) {
                                used[static_cast<std::size_t>(edge_id)][idx_it->second] += demand;
                            }
                            result.total_link_cost += demand;
                        }
                    }
                    record.p_link_resources.push_back(std::move(used_map));
                }
                if (!feasible) {
                    continue;
                }

                result.records.push_back(std::move(record));
                selected = true;
                break;
            }
        }

        if (!selected) {
            result.success = false;
            break;
        }
    }

    return result;
}

VNRState::SparseResourceAllocations VNRState::get_allocated_node_resources() const {
    if (!allocation_totals_cache_valid_) {
        rebuild_allocation_totals_cache();
    }
    auto merged = node_allocation_totals_cache_;

    for (auto it = merged.begin(); it != merged.end();) {
        auto& resources = it->second;
        for (auto attr_it = resources.begin(); attr_it != resources.end();) {
            if (attr_it->second <= kEpsilon) {
                attr_it = resources.erase(attr_it);
            } else {
                ++attr_it;
            }
        }
        if (resources.empty()) {
            it = merged.erase(it);
        } else {
            ++it;
        }
    }
    return merged;
}

VNRState::SparseResourceAllocations VNRState::get_allocated_link_resources() const {
    if (!allocation_totals_cache_valid_) {
        rebuild_allocation_totals_cache();
    }
    auto merged = link_allocation_totals_cache_;

    for (auto it = merged.begin(); it != merged.end();) {
        auto& resources = it->second;
        for (auto attr_it = resources.begin(); attr_it != resources.end();) {
            if (attr_it->second <= kEpsilon) {
                attr_it = resources.erase(attr_it);
            } else {
                ++attr_it;
            }
        }
        if (resources.empty()) {
            it = merged.erase(it);
        } else {
            ++it;
        }
    }
    return merged;
}

float VNRState::run_random_rollout(std::mt19937& rng, int depth_limit) const {
    // Start from current state
    VNRState current_state = *this;
    int depth = 0;

    // Loop until terminal or depth limit reached
    while (!current_state.is_terminal() && depth < depth_limit) {
        // Get all valid candidate actions
        std::vector<int> candidates = current_state.get_candidate_nodes();

        // Filter out invalid candidates (-1 means no valid placement)
        std::vector<int> valid_candidates;
        valid_candidates.reserve(candidates.size());
        for (int candidate : candidates) {
            if (candidate != -1) {
                valid_candidates.push_back(candidate);
            }
        }

        // If no valid candidates, create a failure state
        if (valid_candidates.empty()) {
            current_state = current_state.create_child(-1);
            break;
        }

        // Randomly select one candidate
        std::uniform_int_distribution<int> dist(0, static_cast<int>(valid_candidates.size()) - 1);
        int random_index = dist(rng);
        int selected_action = valid_candidates[random_index];

        // Advance to the next state
        current_state = current_state.create_child(selected_action);
        ++depth;
    }

    // Return the final reward from the terminal state
    return current_state.compute_final_reward();
}

}  // namespace azsfc
