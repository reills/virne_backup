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
    for (auto& [existing_action, existing_child] : children_) {
        if (existing_action == action) {
            if (existing_child) {
                existing_child->set_prior(prior);
                return existing_child.get();
            }
            existing_child = std::make_unique<TreeNode>(this, std::move(child_state), action);
            existing_child->set_prior(prior);
            return existing_child.get();
        }
    }
    auto child = std::make_unique<TreeNode>(this, std::move(child_state), action);
    child->set_prior(prior);
    auto* child_ptr = child.get();
    children_.emplace_back(action, std::move(child));
    return child_ptr;
}

bool TreeNode::is_expanded() const noexcept {
    return !children_.empty();
}

bool TreeNode::is_terminal() const noexcept {
    return terminal_;
}

void TreeNode::add_virtual_loss(float loss) {
    virtual_loss_ += loss;
    ++visit_count_;
}

void TreeNode::revert_virtual_loss(float loss) {
    virtual_loss_ -= loss;
    if (visit_count_ > 0) {
        --visit_count_;
    }
}

void TreeNode::update_stats(float leaf_value) {
    value_sum_ += leaf_value;
    ++visit_count_;
}

TreeNode* TreeNode::best_child(float c_puct) {
    TreeNode* best = nullptr;
    double best_score = -std::numeric_limits<double>::infinity();
    double total_visits = 0.0;
    for (const auto& [action, child_ptr] : children_) {
        (void)action;
        total_visits += static_cast<double>(child_ptr->visit_count());
    }
    double sqrt_total = std::sqrt(total_visits + 1.0);

    for (auto& [action, child_ptr] : children_) {
        TreeNode* child = child_ptr.get();
        double child_visits = static_cast<double>(child->visit_count_);
        double mean_value = child->visit_count_ > 0 ? child->value_sum_ / child_visits : 0.0;
        double exploration = static_cast<double>(c_puct) * static_cast<double>(child->prior_) * sqrt_total / (1.0 + child_visits);
        double score = mean_value + exploration - child->virtual_loss_;

        if (score > best_score) {
            best_score = score;
            best = child;
        }
    }

    return best;
}

TreeNode* TreeNode::child_for_action(int64_t action) {
    for (auto& [child_action, child] : children_) {
        if (child_action == action) {
            return child.get();
        }
    }
    return nullptr;
}

std::unique_ptr<TreeNode> TreeNode::extract_child(int64_t action) {
    for (auto it = children_.begin(); it != children_.end(); ++it) {
        if (it->first != action) {
            continue;
        }
        auto child = std::move(it->second);
        children_.erase(it);
        if (child) {
            child->parent_ = nullptr;
        }
        return child;
    }
    return nullptr;
}

bool TreeNode::has_children() const noexcept {
    return !children_.empty();
}

}  // namespace azsfc
