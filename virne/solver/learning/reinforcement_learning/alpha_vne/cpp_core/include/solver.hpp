#pragma once

#include "mcts_engine.hpp"
#include "network.hpp"
#include "policy_network.hpp"
#include "replay_writer.hpp"
#include "vnr_state.hpp"

#include <torch/torch.h>

#include <string>
#include <unordered_map>
#include <vector>

namespace azsfc {

struct SolveMetrics {
    int total_simulations{0};
    int steps{0};
    double total_time_ms{0.0};
    double encode_ms{0.0};
    double build_inputs_ms{0.0};
    double policy_eval_ms{0.0};
    double mcts_ms{0.0};
    double postprocess_ms{0.0};
};

struct SolveResult {
    std::vector<int> actions;
    std::vector<std::vector<float>> policies;
    std::vector<std::vector<float>> visit_counts;
    std::vector<float> values;
    bool rejected{false};
    bool place_result{true};
    bool route_result{true};
    std::vector<int> node_slots;
    std::unordered_map<std::string, double> place_info;
    int place_v_node_id{-1};
    int place_p_node_id{-1};
    float final_reward{0.0f};
    float total_cost{0.0f};
    float total_revenue{0.0f};
    float value_target{0.0f};
    bool replay_written{false};
    std::string replay_path;
    std::string replay_error;
    std::vector<VNRState::LinkPathRecord> link_mapping;
    SolveMetrics metrics;
};

SolveResult solve_vnr(
    const Network& physical,
    const Network& virtual_net,
    const VNRConfig& vnr_config,
    const SearchConfig& search_config,
    const std::string& policy_path,
    const std::string& policy_meta_path,
    const std::string& device,
    std::optional<unsigned int> seed,
    float temperature,
    int temperature_move_threshold,
    float temperature_after_threshold,
    float replay_policy_temperature,
    bool use_nn_policy,
    bool use_nn_value,
    bool write_replay,
    const std::string& replay_dir,
    int max_buffer_size
);

Observation debug_build_observation(
    const Network& physical,
    const Network& virtual_net,
    const VNRConfig& vnr_config,
    const std::string& policy_path,
    const std::string& device
);

Observation debug_build_observation_after_actions(
    const Network& physical,
    const Network& virtual_net,
    const VNRConfig& vnr_config,
    const std::vector<int>& actions,
    const std::string& policy_path,
    const std::string& device
);

EvaluationResult debug_evaluate_root(
    const Network& physical,
    const Network& virtual_net,
    const VNRConfig& vnr_config,
    const std::string& policy_path,
    const std::string& device
);

EvaluationResult debug_evaluate_after_actions(
    const Network& physical,
    const Network& virtual_net,
    const VNRConfig& vnr_config,
    const std::vector<int>& actions,
    const std::string& policy_path,
    const std::string& device
);

SearchResult debug_search_after_actions(
    const Network& physical,
    const Network& virtual_net,
    const VNRConfig& vnr_config,
    const SearchConfig& search_config,
    const std::vector<int>& actions,
    const std::string& policy_path,
    const std::string& device
);

SearchResult debug_search_child_after_actions(
    const Network& physical,
    const Network& virtual_net,
    const VNRConfig& vnr_config,
    const SearchConfig& search_config,
    const std::vector<int>& actions,
    int focus_action,
    const std::string& policy_path,
    const std::string& device
);

}  // namespace azsfc
