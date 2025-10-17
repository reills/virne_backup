#pragma once

#include "network.hpp"
#include "shortest_path.hpp"

#include <memory>
#include <optional>
#include <random>
#include <string>
#include <unordered_map>
#include <vector>

namespace azsfc {

struct VNRConfig {
    std::vector<std::string> node_resource_names;
    std::vector<std::string> link_resource_names;
    bool allow_rejection{false};
    double reject_penalty{50.0};
    std::string shortest_method{"bfs_shortest"};
    int k_shortest{1};
};

class VNRState {
public:
    VNRState(std::shared_ptr<const Network> physical,
             std::shared_ptr<const Network> virtual_net,
             VNRConfig config);

    VNRState(const VNRState&) = default;
    VNRState& operator=(const VNRState&) = default;

    std::vector<int> get_candidate_nodes() const;
    bool is_terminal() const;
    float compute_final_reward() const;
    VNRState create_child(int p_node_id) const;

    // Plain MCTS: Random rollout simulation for vanilla MCTS value estimation
    float run_random_rollout(std::mt19937& rng, int depth_limit = 100) const;

    double get_available_node_resource(int node_id, const std::string& attr) const;
    double get_available_link_resource(int edge_id, const std::string& attr) const;
    double get_available_link_resource(int u, int v, const std::string& attr) const;

    int current_virtual_index() const noexcept { return v_node_index_; }
    int last_physical_node() const noexcept { return p_node_id_; }
    bool rejected() const noexcept { return rejected_; }
    const std::vector<int>& selected_physical_nodes() const noexcept { return selected_p_nodes_; }
    const std::vector<int>& virtual_order() const noexcept { return v_order_; }

private:
    std::shared_ptr<const Network> p_net_;
    std::shared_ptr<const Network> v_net_;
    VNRConfig config_;

    std::vector<std::unordered_map<std::string, double>> node_allocations_;
    std::vector<std::unordered_map<std::string, double>> link_allocations_;

    std::vector<int> selected_p_nodes_;
    std::vector<int> placement_map_;
    std::vector<int> v_order_;
    std::vector<int> v_pos_;
    int v_node_index_{-1};
    int p_node_id_{-1};
    bool rejected_{false};
    int reject_action_id_{-1};

    double total_node_demand_{0.0};
    double total_v_revenue_{0.0};

    ShortestPathFinder path_finder_;

    void initialise_virtual_order();
    void update_node_allocations(int p_node_id, int v_node_id, VNRState& target) const;
    bool reserve_link_resources(int new_virtual_node, int new_physical_node, VNRState& target) const;
    bool reserve_path_for_virtual_edge(int v_src, int v_dst, int p_src, int p_dst, VNRState& target) const;
    double sum_link_allocations() const;
};

}  // namespace azsfc
