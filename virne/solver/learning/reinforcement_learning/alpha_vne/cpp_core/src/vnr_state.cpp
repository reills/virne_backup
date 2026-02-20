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
    const auto& v_attrs = v_net_->node_attrs[v_target];

    for (int p = 0; p < p_net_->num_nodes; ++p) {
        if (is_physical_selected(p)) {
            continue;
        }

        bool feasible = true;
        for (const auto& attr_name : config_.node_resource_names) {
            double demand = safe_lookup(v_attrs, attr_name);
            if (demand <= 0.0) {
                continue;
            }
            double available = get_available_node_resource(p, attr_name);
            if (available + kEpsilon < demand) {
                feasible = false;
                break;
            }
        }

        if (feasible) {
            candidates.push_back(p);
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
    VNRState child(*this);
    child.selected_p_nodes_cache_valid_ = false;
    child.allocation_totals_cache_valid_ = false;
    child.node_allocation_totals_cache_.clear();
    child.link_allocation_totals_cache_.clear();
    child.v_node_index_ = v_node_index_ + 1;
    child.p_node_id_ = p_node_id;

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
        auto placement_delta = std::make_shared<PlacementDelta>();
        placement_delta->parent = placement_deltas_;
        placement_delta->v_node_id = v_target;
        placement_delta->p_node_id = p_node_id;
        child.placement_deltas_ = std::move(placement_delta);
        child.update_node_allocations(p_node_id, v_target, *step_delta);
        if (!child.reserve_link_resources(v_target, p_node_id, child, *step_delta)) {
            child.p_node_id_ = -1;
        }
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
    const auto& demands = v_net_->edge_attrs[v_edge_id];

    int k = std::max(1, config_.k_shortest);
    std::string method = config_.shortest_method.empty() ? "bfs_shortest" : config_.shortest_method;
    if (method == "bfs_shortest" || method == "first_shortest" || method == "available_shortest") {
        k = 1;
    }
    auto paths = path_finder_.find_paths(*p_net_, target, p_src, p_dst, k, demands, method);
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
