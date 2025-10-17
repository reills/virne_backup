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
      config_(std::move(config)) {
    if (!p_net_) {
        throw std::invalid_argument("VNRState requires a valid physical network reference.");
    }
    if (!v_net_) {
        throw std::invalid_argument("VNRState requires a valid virtual network reference.");
    }

    node_allocations_.assign(p_net_->num_nodes, {});
    link_allocations_.assign(p_net_->num_edges, {});
    placement_map_.assign(v_net_->num_nodes, -1);

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

    std::sort(scores.begin(), scores.end(), [](const auto& a, const auto& b) {
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
        if (std::find(selected_p_nodes_.begin(), selected_p_nodes_.end(), p) != selected_p_nodes_.end()) {
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

float VNRState::compute_final_reward() const {
    if (rejected_) {
        return static_cast<float>(-config_.reject_penalty);
    }
    if (p_node_id_ == -1) {
        return -1000.0f;
    }
    if (static_cast<int>(selected_p_nodes_.size()) != v_net_->num_nodes) {
        return -1000.0f;
    }

    double link_cost = sum_link_allocations();
    double total_cost = total_node_demand_ + link_cost;
    double reward = 1000.0 + total_v_revenue_ - total_cost;
    return static_cast<float>(reward);
}

double VNRState::sum_link_allocations() const {
    double total = 0.0;
    for (const auto& edge_map : link_allocations_) {
        for (const auto& [_, value] : edge_map) {
            total += value;
        }
    }
    return total;
}

VNRState VNRState::create_child(int p_node_id) const {
    VNRState child(*this);
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

    child.selected_p_nodes_.push_back(p_node_id);
    if (child.v_node_index_ < static_cast<int>(child.v_order_.size())) {
        int v_target = child.v_order_[child.v_node_index_];
        child.placement_map_[v_target] = p_node_id;
        child.update_node_allocations(p_node_id, v_target, child);
        if (!child.reserve_link_resources(v_target, p_node_id, child)) {
            child.p_node_id_ = -1;
        }
    }

    return child;
}

void VNRState::update_node_allocations(int p_node_id, int v_node_id, VNRState& target) const {
    const auto& v_attrs = v_net_->node_attrs[v_node_id];
    for (const auto& attr_name : config_.node_resource_names) {
        double demand = safe_lookup(v_attrs, attr_name);
        if (demand <= 0.0) {
            continue;
        }
        target.node_allocations_[p_node_id][attr_name] += demand;
    }
}

bool VNRState::reserve_link_resources(int new_virtual_node, int new_physical_node, VNRState& target) const {
    for (const auto& [neighbor, edge_id] : v_net_->adjacency[new_virtual_node]) {
        int neighbor_pos = target.v_pos_[neighbor];
        if (neighbor_pos > target.v_node_index_) {
            continue;
        }
        int mapped_neighbor = target.placement_map_[neighbor];
        if (mapped_neighbor < 0) {
            continue;
        }
        if (!reserve_path_for_virtual_edge(new_virtual_node, neighbor, new_physical_node, mapped_neighbor, target)) {
            return false;
        }
    }
    return true;
}

bool VNRState::reserve_path_for_virtual_edge(int v_src,
                                             int v_dst,
                                             int p_src,
                                             int p_dst,
                                             VNRState& target) const {
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

    const auto& best_path = paths.front().nodes;
    if (best_path.size() < 2) {
        return false;
    }

    auto links = path_to_links(best_path);
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
            target.link_allocations_[edge_id][attr] += demand;
        }
    }

    return true;
}

double VNRState::get_available_node_resource(int node_id, const std::string& attr) const {
    if (node_id < 0 || node_id >= p_net_->num_nodes) {
        return 0.0;
    }
    double capacity = safe_lookup(p_net_->node_attrs[node_id], attr);
    double used = safe_lookup(node_allocations_[node_id], attr);
    return capacity - used;
}

double VNRState::get_available_link_resource(int edge_id, const std::string& attr) const {
    if (edge_id < 0 || edge_id >= p_net_->num_edges) {
        return 0.0;
    }
    double capacity = safe_lookup(p_net_->edge_attrs[edge_id], attr);
    double used = safe_lookup(link_allocations_[edge_id], attr);
    return capacity - used;
}

double VNRState::get_available_link_resource(int u, int v, const std::string& attr) const {
    auto it = p_net_->edge_index.find({u, v});
    if (it == p_net_->edge_index.end()) {
        return 0.0;
    }
    return get_available_link_resource(it->second, attr);
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
