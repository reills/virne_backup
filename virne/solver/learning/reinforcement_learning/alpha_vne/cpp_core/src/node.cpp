#include "node.hpp"

#include <cmath>
#include <limits>

namespace azsfc {

TreeNode::TreeNode(TreeNode* parent,
                   std::shared_ptr<StateView> state,
                   std::optional<int64_t> action_from_parent)
    : parent_(parent),
      state_(std::move(state)),
      action_from_parent_(action_from_parent) {}

TreeNode* TreeNode::add_child(int64_t action, std::shared_ptr<StateView> child_state, float prior) {
    auto child = std::make_unique<TreeNode>(this, std::move(child_state), action);
    child->set_prior(prior);
    std::lock_guard<std::mutex> guard(mutex_);
    auto it = children_.emplace(action, std::move(child));
    return it.first->second.get();
}

bool TreeNode::is_expanded() const noexcept {
    std::lock_guard<std::mutex> guard(mutex_);
    return !children_.empty();
}

bool TreeNode::is_terminal() const noexcept {
    return terminal_;
}

void TreeNode::add_virtual_loss(float loss) {
    std::lock_guard<std::mutex> guard(mutex_);
    virtual_loss_ += loss;
    ++visit_count_;
}

void TreeNode::revert_virtual_loss(float loss) {
    std::lock_guard<std::mutex> guard(mutex_);
    virtual_loss_ -= loss;
    if (visit_count_ > 0) {
        --visit_count_;
    }
}

void TreeNode::update_stats(float leaf_value) {
    std::lock_guard<std::mutex> guard(mutex_);
    value_sum_ += leaf_value;
    ++visit_count_;
}

TreeNode* TreeNode::best_child(float c_puct) {
    std::lock_guard<std::mutex> guard(mutex_);
    TreeNode* best = nullptr;
    float best_score = -std::numeric_limits<float>::infinity();
    float parent_visits = static_cast<float>(std::max<std::size_t>(1, visit_count_));

    for (auto& [action, child_ptr] : children_) {
        TreeNode* child = child_ptr.get();
        float child_visits = static_cast<float>(std::max<std::size_t>(1, child->visit_count_));
        float mean_value = child->visit_count_ > 0 ? child->value_sum_ / child_visits : 0.0f;
        float exploration = c_puct * child->prior_ * std::sqrt(parent_visits) / (1.0f + child_visits);
        float score = mean_value + exploration - child->virtual_loss_;

        if (score > best_score) {
            best_score = score;
            best = child;
        }
    }

    return best;
}

TreeNode* TreeNode::child_for_action(int64_t action) {
    std::lock_guard<std::mutex> guard(mutex_);
    auto it = children_.find(action);
    if (it == children_.end()) {
        return nullptr;
    }
    return it->second.get();
}

std::vector<std::pair<int64_t, TreeNode*>> TreeNode::children() {
    std::lock_guard<std::mutex> guard(mutex_);
    std::vector<std::pair<int64_t, TreeNode*>> out;
    out.reserve(children_.size());
    for (auto& [action, child] : children_) {
        out.emplace_back(action, child.get());
    }
    return out;
}

}  // namespace azsfc
