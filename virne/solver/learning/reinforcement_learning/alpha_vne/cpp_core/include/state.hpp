#pragma once

#include <torch/torch.h>

#include <memory>
#include <optional>
#include <string>
#include <unordered_map>
#include <vector>

namespace azsfc {

class VNRState;

/**
 * Lightweight snapshot of the environment that the MCTS engine can reason
 * about. The Python code is responsible for building these snapshots from
 * domain objects (virtual/physical networks, resource views, etc.).
 *
 * The class stores only the information required by the tree search: a unique
 * identifier, mask of valid actions, current history embedding and any cached
 * neural network outputs.
 */
struct StateView {
    using TensorMap = std::unordered_map<std::string, torch::Tensor>;

    std::int64_t id = -1;
    std::int64_t step_index = 0;
    TensorMap features;
    torch::Tensor action_mask;  // 1 x N boolean tensor
    torch::Tensor policy_logits;  // 1 x N float tensor
    torch::Tensor value;  // scalar tensor
    std::shared_ptr<VNRState> domain_state;  // Optional pointer to C++ environment state

    StateView() = default;
    explicit StateView(std::int64_t identifier) : id(identifier) {}

    std::int64_t num_actions() const {
        if (!action_mask.defined()) {
            return 0;
        }
        return action_mask.size(-1);
    }
};

/**
 * Result of evaluating a state with the neural network.
 */
struct EvaluationResult {
    torch::Tensor policy_logits;
    torch::Tensor value;
};

}  // namespace azsfc
