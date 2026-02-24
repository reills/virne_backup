#include "mcts_engine.hpp"

#include <torch/torch.h>

#include "vnr_state.hpp"

#include <algorithm>
#include <atomic>
#include <stdexcept>

namespace azsfc {

namespace {
torch::Tensor masked_softmax(const torch::Tensor& logits, const torch::Tensor& mask) {
    auto float_mask = mask.to(logits.device(), logits.dtype());
    auto masked_logits = logits + (float_mask - 1.0f) * 1e9f;
    return torch::softmax(masked_logits, -1);
}

int64_t infer_action_space_size(const std::shared_ptr<StateView>& state) {
    if (!state) {
        return 0;
    }
    auto from_mask = state->num_actions();
    if (from_mask > 0) {
        return from_mask;
    }
    if (state->domain_state) {
        return state->domain_state->action_space_size();
    }
    return 0;
}

template <typename Container>
int64_t find_max_action_id(const Container& entries) {
    int64_t max_action = -1;
    for (const auto& item : entries) {
        max_action = std::max<int64_t>(max_action, item.first);
    }
    return max_action;
}

std::atomic<std::int64_t> g_state_id_counter{1};
}  // namespace

MCTSEngine::MCTSEngine(SearchConfig config)
    : config_(config),
      rng_(std::random_device{}()) {}

SearchResult MCTSEngine::run_search(const std::shared_ptr<StateView>& root_state, std::optional<unsigned int> seed) {
    bool has_domain_state = root_state && root_state->domain_state;
    if (config_.use_neural_network && !evaluate_fn_) {
        throw std::runtime_error("MCTSEngine requires an evaluation callback when use_neural_network=true.");
    }
    if (!has_domain_state) {
        if (!expand_fn_ || !terminal_value_fn_ || !terminal_check_fn_) {
            throw std::runtime_error("MCTSEngine callbacks must be set before running search.");
        }
    }

    if (seed) {
        rng_.seed(*seed);
    }

    root_noise_applied_ = false;

    TreeNode root(nullptr, root_state, std::nullopt);

    // Ensure root evaluation is ready only when NN guidance is enabled
    if (config_.use_neural_network) {
        if (!root_state->policy_logits.defined() || !root_state->value.defined()) {
            auto eval = evaluate_fn_(root_state);
            root_state->policy_logits = eval.policy_logits;
            root_state->value = eval.value;
        }
    }

    // Align with Python MCTS semantics: expand the root once before the budgeted
    // simulations so a budget of 1 can still assign visits to a child action.
    bool root_terminal = false;
    if (root_state && root_state->domain_state) {
        root_terminal = root_state->domain_state->is_terminal();
    } else if (terminal_check_fn_) {
        root_terminal = terminal_check_fn_(root_state);
    }
    if (!root_terminal && !root.has_children()) {
        (void)expand(root);
    }

    for (int sim = 0; sim < config_.simulations; ++sim) {
        TreeNode* leaf = select(root);
        if (!leaf) {
            break;
        }
        float value = expand(*leaf);
        backpropagate(leaf, value);
    }

    const auto& root_children = root.children_ref();
    auto num_actions = infer_action_space_size(root_state);
    auto max_child_action = find_max_action_id(root_children);
    if (max_child_action >= 0) {
        num_actions = std::max<int64_t>(num_actions, max_child_action + 1);
    }
    if (num_actions <= 0) {
        num_actions = static_cast<int64_t>(root_children.size());
        if (max_child_action >= 0) {
            num_actions = std::max<int64_t>(num_actions, max_child_action + 1);
        }
    }
    if (num_actions <= 0) {
        num_actions = 1;
    }
    auto visit_counts = torch::zeros({num_actions}, torch::kFloat32);
    for (const auto& [action, child] : root_children) {
        if (action >= 0 && action < visit_counts.size(0)) {
            visit_counts[action] = static_cast<float>(child->visit_count());
        }
    }
    auto policy = visit_counts.clone();
    float total_visits = policy.sum().item<float>();
    if (total_visits > 0.0f) {
        policy /= total_visits;
    }

    auto root_priors = torch::zeros({num_actions}, torch::kFloat32);
    for (const auto& [action, child] : root_children) {
        if (child && action >= 0 && action < root_priors.size(0)) {
            root_priors[action] = child->prior();
        }
    }

    float root_value = root_state->value.defined() ? root_state->value.item<float>() : 0.0f;

    return {visit_counts, policy, root_priors, root_value};
}

TreeNode* MCTSEngine::select(TreeNode& root) {
    TreeNode* node = &root;
    while (true) {
        auto state = node->state();
        bool terminal = false;
        if (state->domain_state) {
            terminal = state->domain_state->is_terminal();
        } else if (terminal_check_fn_) {
            terminal = terminal_check_fn_(state);
        }
        if (terminal) {
            node->set_terminal(true);
            return node;
        }

        if (!node->has_children()) {
            return node;
        }

        TreeNode* best = node->best_child(config_.c_puct);
        if (!best) {
            return node;
        }
        node = best;
    }
}

float MCTSEngine::expand(TreeNode& node) {
    auto state = node.state();
    bool terminal = false;
    if (state->domain_state) {
        terminal = state->domain_state->is_terminal();
    } else if (terminal_check_fn_) {
        terminal = terminal_check_fn_(state);
    }

    if (terminal) {
        node.set_terminal(true);
        if (state->domain_state) {
            return state->domain_state->compute_final_reward();
        }
        return terminal_value_fn_(state);
    }

    // PLAIN MCTS MODE: Skip neural network evaluation if use_neural_network is false
    if (config_.use_neural_network) {
        if (!state->policy_logits.defined() || !state->value.defined()) {
            auto eval = evaluate_fn_(state);
            state->policy_logits = eval.policy_logits;
            state->value = eval.value;
        }
    }

    std::vector<std::pair<int64_t, std::shared_ptr<StateView>>> options;
    if (state->domain_state) {
        auto actions = state->domain_state->get_candidate_nodes();
        options.reserve(actions.size());
        for (int64_t action : actions) {
            auto child_domain = std::make_shared<VNRState>(state->domain_state->create_child(static_cast<int>(action)));
            if (!child_domain) {
                continue;
            }
            if (child_domain->last_physical_node() == -1) {
                continue;
            }
            auto child_state = std::make_shared<StateView>(g_state_id_counter.fetch_add(1));
            child_state->step_index = state->step_index + 1;
            child_state->domain_state = std::move(child_domain);
            options.emplace_back(action, std::move(child_state));
        }
    } else if (expand_fn_) {
        options = expand_fn_(state);
    }

    if (options.empty()) {
        node.set_terminal(true);
        if (state->domain_state) {
            return state->domain_state->compute_final_reward();
        }
        return terminal_value_fn_(state);
    }

    // PLAIN MCTS MODE: Use uniform priors instead of neural network policy
    torch::Tensor priors;
    if (config_.use_neural_network && state->policy_logits.defined()) {
        auto logits = state->policy_logits.squeeze();
        torch::Tensor mask;
        if (state->action_mask.defined()) {
            mask = state->action_mask.squeeze().to(torch::kBool);
        } else {
            mask = torch::ones_like(logits, torch::TensorOptions().dtype(torch::kBool));
        }
        priors = masked_softmax(logits, mask);
    } else {
        // Uniform priors for plain MCTS aligned with global action indices
        auto max_action = find_max_action_id(options);
        int64_t num_actions = infer_action_space_size(state);
        if (max_action >= 0) {
            num_actions = std::max<int64_t>(num_actions, max_action + 1);
        }
        if (num_actions <= 0) {
            num_actions = std::max<int64_t>(1, static_cast<int64_t>(options.size()));
            if (max_action >= 0) {
                num_actions = std::max<int64_t>(num_actions, max_action + 1);
            }
        }
        priors = torch::zeros({num_actions}, torch::kFloat32);
        if (!options.empty()) {
            float uniform = 1.0f / static_cast<float>(options.size());
            for (const auto& [action, _] : options) {
                if (action >= 0 && action < priors.size(0)) {
                    priors[action] = uniform;
                }
            }
        } else {
            priors.fill_(1.0f / static_cast<float>(num_actions));
        }
    }

    for (auto& [action, child_state] : options) {
        float prior = 0.0f;
        if (action >= 0 && action < priors.size(0)) {
            prior = priors[action].item<float>();
        } else {
            // Fallback uniform prior for this action
            prior = 1.0f / static_cast<float>(options.size());
        }
        node.add_child(action, std::move(child_state), prior);
    }

    if (node.parent() == nullptr && config_.add_root_noise && !root_noise_applied_ && config_.use_neural_network) {
        apply_dirichlet_noise(node);
        root_noise_applied_ = true;
    }

    // PLAIN MCTS MODE: Use random rollout for value estimation instead of neural network
    float value = 0.0f;
    if (config_.use_neural_network && state->value.defined()) {
        value = state->value.item<float>();
    } else if (state->domain_state) {
        // Run random rollout from this state
        value = state->domain_state->run_random_rollout(rng_, config_.rollout_depth_limit);
    } else {
        // Fallback to terminal value function if no domain state
        value = terminal_value_fn_ ? terminal_value_fn_(state) : 0.0f;
    }

    return value;
}

void MCTSEngine::backpropagate(TreeNode* node, float value) {
    while (node) {
        node->update_stats(value);
        node = node->parent();
    }
}

void MCTSEngine::apply_dirichlet_noise(TreeNode& root) {
    auto state = root.state();
    auto logits = state->policy_logits.squeeze();
    auto mask = state->action_mask.defined()
                    ? state->action_mask.squeeze().to(torch::kBool)
                    : torch::ones_like(logits, torch::TensorOptions().dtype(torch::kBool));
    auto priors = masked_softmax(logits, mask);

    std::vector<int64_t> valid_actions;
    valid_actions.reserve(root.children_ref().size());
    for (const auto& [action, child] : root.children_ref()) {
        (void)child;
        if (action >= 0 && action < priors.size(0)) {
            valid_actions.push_back(action);
        }
    }
    if (valid_actions.empty()) {
        return;
    }

    std::gamma_distribution<float> gamma(config_.dirichlet_alpha, 1.0f);
    auto noise = torch::zeros_like(priors);
    float noise_sum = 0.0f;
    for (int64_t action : valid_actions) {
        float n = gamma(rng_);
        noise[action] = n;
        noise_sum += n;
    }
    if (noise_sum <= 0.0f) {
        return;
    }

    for (int64_t action : valid_actions) {
        noise[action] = noise[action].item<float>() / noise_sum;
    }

    auto mixed = (1.0f - config_.dirichlet_epsilon) * priors + config_.dirichlet_epsilon * noise;
    state->policy_logits = torch::log(mixed + 1e-8f);

    for (const auto& [action, child] : root.children_ref()) {
        if (child && action >= 0 && action < mixed.size(0)) {
            child->set_prior(mixed[action].item<float>());
        }
    }
}

}  // namespace azsfc
