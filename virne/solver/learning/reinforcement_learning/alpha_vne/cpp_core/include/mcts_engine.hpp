#pragma once

#include "node.hpp"
#include "policy_network.hpp"

#include <torch/torch.h>

#include <functional>
#include <memory>
#include <random>
#include <string>
#include <vector>

namespace azsfc {

struct SearchConfig {
    int simulations = 32;
    float c_puct = 1.0f;
    float dirichlet_alpha = 0.1f;
    float dirichlet_epsilon = 0.25f;
    int top_k_candidates = 0;
    float virtual_loss = 1.0f;
    bool add_root_noise = true;
    // Plain MCTS mode (vanilla MCTS without neural network)
    bool use_neural_network = true;  // If false, use uniform priors and random rollouts
    int rollout_depth_limit = 100;   // Maximum depth for rollout simulations
    int eval_batch_size = 1;         // Batch size for neural network evaluation
    std::string value_normalization{"tanh"};  // acceptance_first | raw | sign | tanh
    float value_scale = 1000.0f;              // scale for tanh normalization
};

struct SearchResult {
    torch::Tensor visit_counts;
    torch::Tensor policy;
    torch::Tensor root_priors;
    float value = 0.0f;
};

class MCTSEngine {
public:
    using ExpandFn = std::function<std::vector<std::pair<int64_t, std::shared_ptr<StateView>>>(const std::shared_ptr<StateView>&)>;
    using EvaluateFn = std::function<EvaluationResult(const std::shared_ptr<StateView>&)>;
    using BatchEvaluateFn = std::function<std::vector<EvaluationResult>(const std::vector<std::shared_ptr<StateView>>&)>; 
    using TerminalValueFn = std::function<float(const std::shared_ptr<StateView>&)>;
    using TerminalCheckFn = std::function<bool(const std::shared_ptr<StateView>&)>;

    explicit MCTSEngine(SearchConfig config);

    void set_expand_callback(ExpandFn fn) { expand_fn_ = std::move(fn); }
    void set_evaluate_callback(EvaluateFn fn) { evaluate_fn_ = std::move(fn); }
    void set_batch_evaluate_callback(BatchEvaluateFn fn) { batch_evaluate_fn_ = std::move(fn); }
    void set_terminal_value_callback(TerminalValueFn fn) { terminal_value_fn_ = std::move(fn); }
    void set_terminal_check_callback(TerminalCheckFn fn) { terminal_check_fn_ = std::move(fn); }

    SearchResult run_search(const std::shared_ptr<StateView>& root_state, std::optional<unsigned int> seed = std::nullopt);

private:
    void apply_dirichlet_noise(TreeNode& root);
    TreeNode* select(TreeNode& root);
    float expand(TreeNode& node);
    void backpropagate(TreeNode* node, float value);
    void apply_virtual_loss(TreeNode* node);
    void revert_virtual_loss(TreeNode* node);
    float normalize_terminal_value(float raw, const std::shared_ptr<StateView>& state = nullptr) const;

    SearchConfig config_;
    ExpandFn expand_fn_;
    EvaluateFn evaluate_fn_;
    BatchEvaluateFn batch_evaluate_fn_;
    TerminalValueFn terminal_value_fn_;
    TerminalCheckFn terminal_check_fn_;
    std::mt19937 rng_;
    bool root_noise_applied_{false};
    mutable bool acceptance_stats_ready_{false};
    mutable float accepted_cost_min_{0.0f};
    mutable float accepted_cost_max_{0.0f};
};

}  // namespace azsfc
