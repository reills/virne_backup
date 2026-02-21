#pragma once

#include "mcts_engine.hpp"
#include "network.hpp"
#include "policy_network.hpp"
#include "vnr_state.hpp"

#include <torch/torch.h>

#include <string>
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
    std::vector<float> values;
    bool rejected{false};
    bool place_result{true};
    float final_reward{0.0f};
    SolveMetrics metrics;
};

SolveResult solve_vnr(
    const Network& physical,
    const Network& virtual_net,
    const VNRConfig& vnr_config,
    const SearchConfig& search_config,
    const std::string& policy_path,
    const std::string& device,
    std::optional<unsigned int> seed,
    float temperature,
    bool use_nn_policy,
    bool use_nn_value
);

}  // namespace azsfc
