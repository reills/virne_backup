#pragma once

#include "network.hpp"
#include "shortest_path.hpp"

#include <cstdint>
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
    using ResourceMap = std::unordered_map<std::string, double>;
    using SparseResourceAllocations = std::unordered_map<int, ResourceMap>;

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
    SparseResourceAllocations get_allocated_node_resources() const;
    SparseResourceAllocations get_allocated_link_resources() const;

    int current_virtual_index() const noexcept { return v_node_index_; }
    int last_physical_node() const noexcept { return p_node_id_; }
    bool rejected() const noexcept { return rejected_; }
    const std::vector<int>& selected_physical_nodes() const;
    const std::vector<int>& virtual_order() const noexcept { return v_order_; }
    int action_space_size() const noexcept {
        if (!p_net_) {
            return 0;
        }
        int size = p_net_->num_nodes;
        if (config_.allow_rejection) {
            size += 1;
        }
        return size;
    }

private:
    struct AllocationDelta {
        using ResourceMap = std::unordered_map<std::string, double>;
        using SparseAllocations = std::unordered_map<int, ResourceMap>;

        std::shared_ptr<const AllocationDelta> parent;
        SparseAllocations node_allocations;
        SparseAllocations link_allocations;
        double link_allocation_total{0.0};
    };

    struct SelectionDelta {
        std::shared_ptr<const SelectionDelta> parent;
        int p_node_id{-1};
    };

    struct PlacementDelta {
        std::shared_ptr<const PlacementDelta> parent;
        int v_node_id{-1};
        int p_node_id{-1};
    };

    std::shared_ptr<const Network> p_net_;
    std::shared_ptr<const Network> v_net_;
    VNRConfig config_;

    std::shared_ptr<const AllocationDelta> allocation_deltas_;
    double total_link_allocation_{0.0};

    std::shared_ptr<const SelectionDelta> selection_deltas_;
    std::shared_ptr<const PlacementDelta> placement_deltas_;
    int selected_count_{0};
    std::vector<std::uint64_t> selected_p_mask_;
    mutable std::vector<int> selected_p_nodes_cache_;
    mutable bool selected_p_nodes_cache_valid_{false};
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
    static bool selected_mask_contains(const std::vector<std::uint64_t>& mask, int node_id) noexcept;
    static void selected_mask_set(std::vector<std::uint64_t>& mask, int node_id) noexcept;
    bool is_physical_selected(int p_node_id) const noexcept;
    void mark_physical_selected(int p_node_id);
    int lookup_placement(int v_node_id) const;
    static void add_allocation_delta(AllocationDelta::SparseAllocations& allocations,
                                     int item_id,
                                     const std::string& attr,
                                     double value);
    static double lookup_allocation_delta(const std::shared_ptr<const AllocationDelta>& delta_root,
                                          int item_id,
                                          const std::string& attr,
                                          bool node_resource);
    double get_allocated_node_resource(int node_id, const std::string& attr) const;
    double get_allocated_link_resource(int edge_id, const std::string& attr) const;
    void update_node_allocations(int p_node_id, int v_node_id, AllocationDelta& delta) const;
    bool reserve_link_resources(int new_virtual_node, int new_physical_node, VNRState& target, AllocationDelta& delta) const;
    bool reserve_path_for_virtual_edge(int v_src,
                                       int v_dst,
                                       int p_src,
                                       int p_dst,
                                       VNRState& target,
                                       AllocationDelta& delta) const;
    double sum_link_allocations() const;
};

}  // namespace azsfc
