#pragma once

#include "state.hpp"

#include <torch/torch.h>

#include <memory>
#include <mutex>
#include <optional>
#include <unordered_map>
#include <vector>

namespace azsfc {

/**
 * Tree node for PUCT search. Each node is responsible for a single action taken
 * from its parent state.
 */
class TreeNode {
public:
    TreeNode(TreeNode* parent,
             std::shared_ptr<StateView> state,
             std::optional<int64_t> action_from_parent = std::nullopt);

    TreeNode* add_child(int64_t action, std::shared_ptr<StateView> child_state, float prior);

    [[nodiscard]] bool is_expanded() const noexcept;
    [[nodiscard]] bool is_terminal() const noexcept;
    [[nodiscard]] std::size_t visit_count() const noexcept { return visit_count_; }

    void set_terminal(bool terminal) noexcept { terminal_ = terminal; }
    void add_virtual_loss(float loss);
    void revert_virtual_loss(float loss);

    float prior() const noexcept { return prior_; }
    void set_prior(float p) noexcept { prior_ = p; }

    float value_sum() const noexcept { return value_sum_; }

    void update_stats(float leaf_value);

    TreeNode* best_child(float c_puct);
    TreeNode* child_for_action(int64_t action);

    std::shared_ptr<StateView> state() const { return state_; }
    std::optional<int64_t> action_from_parent() const { return action_from_parent_; }
    TreeNode* parent() const noexcept { return parent_; }

    std::vector<std::pair<int64_t, TreeNode*>> children();

private:
    TreeNode* parent_{nullptr};
    std::shared_ptr<StateView> state_;
    std::optional<int64_t> action_from_parent_;

    float prior_{0.0f};
    float value_sum_{0.0f};
    float virtual_loss_{0.0f};
    std::size_t visit_count_{0};
    bool terminal_{false};

    std::unordered_map<int64_t, std::unique_ptr<TreeNode>> children_;
    mutable std::mutex mutex_;
};

}  // namespace azsfc
