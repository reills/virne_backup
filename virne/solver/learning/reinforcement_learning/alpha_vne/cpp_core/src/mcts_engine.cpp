#include "mcts_engine.hpp"

#include <torch/torch.h>

#include "vnr_state.hpp"

#include <algorithm>
#include <atomic>
#include <cctype>
#include <cmath>
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

std::vector<float> normalize_nonnegative(const std::vector<float>& values) {
    std::vector<float> probs(values.size(), 0.0f);
    if (values.empty()) {
        return probs;
    }
    double total = 0.0;
    for (std::size_t i = 0; i < values.size(); ++i) {
        float v = values[i];
        if (!std::isfinite(v) || v < 0.0f) {
            v = 0.0f;
        }
        probs[i] = v;
        total += static_cast<double>(v);
    }
    if (total <= 1e-12) {
        const float uniform = 1.0f / static_cast<float>(values.size());
        std::fill(probs.begin(), probs.end(), uniform);
        return probs;
    }
    const float inv_total = static_cast<float>(1.0 / total);
    for (auto& p : probs) {
        p *= inv_total;
    }
    return probs;
}

std::vector<int> select_top_k_actions(
    const std::vector<int>& actions,
    const torch::Tensor& logits,
    const torch::Tensor& mask,
    int top_k,
    int action_space_size
) {
    if (top_k <= 0 || static_cast<int>(actions.size()) <= top_k) {
        return actions;
    }

    auto probs = masked_softmax(logits, mask);
    auto probs_cpu = probs.device().is_cuda() ? probs.to(torch::kCPU) : probs;
    probs_cpu = probs_cpu.contiguous();
    auto probs_acc = probs_cpu.accessor<float, 1>();

    int reject_action = -1;
    if (action_space_size > 0) {
        int candidate_reject = action_space_size - 1;
        if (std::find(actions.begin(), actions.end(), candidate_reject) != actions.end()) {
            reject_action = candidate_reject;
        }
    }

    std::vector<std::pair<float, int>> scored;
    scored.reserve(actions.size());
    for (int action : actions) {
        if (action == reject_action) {
            continue;
        }
        float prior = 0.0f;
        if (action >= 0 && action < probs_cpu.size(0)) {
            prior = probs_acc[action];
        }
        scored.emplace_back(prior, action);
    }
    if (scored.empty()) {
        return actions;
    }

    int keep = std::min<int>(top_k, scored.size());
    std::partial_sort(
        scored.begin(),
        scored.begin() + keep,
        scored.end(),
        [](const auto& lhs, const auto& rhs) {
            if (lhs.first == rhs.first) {
                return lhs.second < rhs.second;
            }
            return lhs.first > rhs.first;
        }
    );

    std::vector<int> selected;
    selected.reserve(static_cast<std::size_t>(keep + (reject_action >= 0 ? 1 : 0)));
    for (int i = 0; i < keep; ++i) {
        selected.push_back(scored[static_cast<std::size_t>(i)].second);
    }
    if (reject_action >= 0) {
        selected.push_back(reject_action);
    }
    return selected;
}

float dynamic_root_dirichlet_alpha(std::size_t num_children) {
    if (num_children == 0) {
        return 0.1f;
    }
    return std::clamp(10.0f / static_cast<float>(num_children), 0.03f, 0.30f);
}
}  // namespace

float MCTSEngine::normalize_terminal_value(float raw, const std::shared_ptr<StateView>& state) const {
    std::string mode = config_.value_normalization;
    std::transform(mode.begin(), mode.end(), mode.begin(),
                   [](unsigned char c) { return static_cast<char>(std::tolower(c)); });
    if (mode == "acceptance_first") {
        if (raw <= 0.0f) {
            return -1.0f;
        }
        double total_revenue = 0.0;
        bool has_revenue = false;
        if (state && state->domain_state) {
            total_revenue = state->domain_state->total_virtual_revenue();
            has_revenue = true;
        }
        float total_cost = has_revenue ? static_cast<float>(1000.0 + total_revenue - raw) : -raw;
        if (!acceptance_stats_ready_) {
            accepted_cost_min_ = total_cost;
            accepted_cost_max_ = total_cost;
            acceptance_stats_ready_ = true;
        } else {
            accepted_cost_min_ = std::min(accepted_cost_min_, total_cost);
            accepted_cost_max_ = std::max(accepted_cost_max_, total_cost);
        }
        float penalty = 0.5f;
        float span = accepted_cost_max_ - accepted_cost_min_;
        if (span > 1e-8f) {
            penalty = (total_cost - accepted_cost_min_) / span;
            penalty = std::clamp(penalty, 0.0f, 1.0f);
        }
        constexpr float kAcceptMin = 0.2f;
        constexpr float kAcceptMax = 1.0f;
        return kAcceptMax - (kAcceptMax - kAcceptMin) * penalty;
    }
    if (mode == "sign") {
        return raw > 0.0f ? 1.0f : -1.0f;
    }
    if (mode == "tanh") {
        float scale = config_.value_scale;
        if (scale == 0.0f) {
            scale = 1.0f;
        }
        return std::tanh(raw / scale);
    }
    return raw;
}

MCTSEngine::MCTSEngine(SearchConfig config)
    : config_(config),
      rng_(std::random_device{}()) {}

void MCTSEngine::reset_tree(const std::shared_ptr<StateView>& root_state) {
    tree_root_ = std::make_unique<TreeNode>(nullptr, root_state, std::nullopt);
}

void MCTSEngine::clear_tree() {
    tree_root_.reset();
}

std::shared_ptr<StateView> MCTSEngine::tree_root_state() const {
    if (!tree_root_) {
        return nullptr;
    }
    return tree_root_->state();
}

SearchResult MCTSEngine::run_search_tree(std::optional<unsigned int> seed) {
    if (!tree_root_) {
        throw std::runtime_error("run_search_tree called before reset_tree.");
    }
    return run_search(*tree_root_, seed);
}

bool MCTSEngine::advance_tree(std::int64_t action) {
    if (!tree_root_) {
        return false;
    }
    auto child = tree_root_->extract_child(action);
    if (child) {
        tree_root_ = std::move(child);
        return true;
    }
    auto state = tree_root_->state();
    if (!state || !state->domain_state) {
        return false;
    }
    auto child_domain = std::make_shared<VNRState>(state->domain_state->create_child(static_cast<int>(action)));
    auto child_state = std::make_shared<StateView>(g_state_id_counter.fetch_add(1));
    child_state->step_index = state->step_index + 1;
    // Match Python ObservationBuilder.build(..., v_node_id=None), which passes
    // `state.v_node_id + 1` through as an explicit v-node id for non-root tree
    // states. In this codebase that value is the stable-order position, not the
    // actual virtual-node id, so keep the legacy behavior for parity.
    child_state->curr_v_node_override = static_cast<std::int64_t>(child_state->step_index);
    child_state->domain_state = std::move(child_domain);
    tree_root_ = std::make_unique<TreeNode>(nullptr, std::move(child_state), std::nullopt);
    return true;
}

SearchResult MCTSEngine::run_search(const std::shared_ptr<StateView>& root_state, std::optional<unsigned int> seed) {
    TreeNode root(nullptr, root_state, std::nullopt);
    return run_search(root, seed);
}

SearchResult MCTSEngine::run_search(TreeNode& root, std::optional<unsigned int> seed) {
    auto root_state = root.state();
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

    const bool use_batch_eval =
        config_.use_neural_network && batch_evaluate_fn_ && config_.eval_batch_size > 1;
    if (!use_batch_eval) {
        for (int sim = 0; sim < config_.simulations; ++sim) {
            TreeNode* leaf = select(root);
            if (!leaf) {
                break;
            }
            float value = expand(*leaf);
            backpropagate(leaf, value);
        }
    } else {
        std::vector<TreeNode*> pending_nodes;
        std::vector<std::shared_ptr<StateView>> pending_states;
        pending_nodes.reserve(static_cast<std::size_t>(config_.eval_batch_size));
        pending_states.reserve(static_cast<std::size_t>(config_.eval_batch_size));

        for (int sim = 0; sim < config_.simulations; ++sim) {
            TreeNode* leaf = select(root);
            if (!leaf) {
                break;
            }

            auto state = leaf->state();
            bool terminal = false;
            if (state->domain_state) {
                terminal = state->domain_state->is_terminal();
            } else if (terminal_check_fn_) {
                terminal = terminal_check_fn_(state);
            }
            if (terminal) {
                leaf->set_terminal(true);
                float raw = state->domain_state ? state->domain_state->compute_final_reward()
                                                : (terminal_value_fn_ ? terminal_value_fn_(state) : 0.0f);
                float value = normalize_terminal_value(raw, state);
                backpropagate(leaf, value);
                continue;
            }

            if (state->policy_logits.defined() && state->value.defined()) {
                float value = expand(*leaf);
                backpropagate(leaf, value);
                continue;
            }

            apply_virtual_loss(leaf);
            pending_nodes.push_back(leaf);
            pending_states.push_back(state);

            bool flush = static_cast<int>(pending_nodes.size()) >= config_.eval_batch_size;
            if (!flush && sim + 1 < config_.simulations) {
                continue;
            }

            auto evals = batch_evaluate_fn_(pending_states);
            std::size_t eval_count = std::min(pending_states.size(), evals.size());
            for (std::size_t i = 0; i < eval_count; ++i) {
                pending_states[i]->policy_logits = evals[i].policy_logits;
                pending_states[i]->value = evals[i].value;
                float value = expand(*pending_nodes[i]);
                revert_virtual_loss(pending_nodes[i]);
                backpropagate(pending_nodes[i], value);
            }
            // Cleanup any leftover virtual loss if evals returned fewer entries.
            for (std::size_t i = eval_count; i < pending_nodes.size(); ++i) {
                revert_virtual_loss(pending_nodes[i]);
            }

            pending_nodes.clear();
            pending_states.clear();
        }
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

    float root_value = 0.0f;
    if (root.visit_count() > 0) {
        root_value = static_cast<float>(root.value_sum() / static_cast<double>(root.visit_count()));
    } else if (root_state->value.defined()) {
        root_value = root_state->value.item<float>();
    }

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
            return normalize_terminal_value(state->domain_state->compute_final_reward(), state);
        }
        return normalize_terminal_value(terminal_value_fn_(state), state);
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
        // Match the Python MCTS semantics: expand over the full legal action
        // set and let the policy prior shape exploration, rather than pruning
        // the tree with a top-k truncation step.
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
            // Match Python ObservationBuilder.build(..., v_node_id=None), which
            // forwards `state.v_node_id + 1` as an explicit id for non-root
            // states. That value is the stable-order position.
            child_state->curr_v_node_override = static_cast<std::int64_t>(child_state->step_index);
            child_state->domain_state = std::move(child_domain);
            options.emplace_back(action, std::move(child_state));
        }
        if (options.empty()) {
            auto invalid_child = std::make_shared<VNRState>(state->domain_state->create_child(-1));
            auto child_state = std::make_shared<StateView>(g_state_id_counter.fetch_add(1));
            child_state->step_index = state->step_index + 1;
            child_state->curr_v_node_override = static_cast<std::int64_t>(child_state->step_index);
            child_state->domain_state = std::move(invalid_child);
            options.emplace_back(-1, std::move(child_state));
        }
    } else if (expand_fn_) {
        options = expand_fn_(state);
    }

    if (options.empty()) {
        node.set_terminal(true);
        if (state->domain_state) {
            return normalize_terminal_value(state->domain_state->compute_final_reward(), state);
        }
        return normalize_terminal_value(terminal_value_fn_(state), state);
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

    torch::Tensor priors_cpu = priors;
    if (priors.device().is_cuda()) {
        priors_cpu = priors.to(torch::kCPU);
    }
    priors_cpu = priors_cpu.contiguous();
    auto priors_acc = priors_cpu.accessor<float, 1>();

    std::vector<float> option_priors;
    option_priors.reserve(options.size());
    for (const auto& [action, child_state] : options) {
        (void)child_state;
        float prior = 0.0f;
        if (action >= 0 && action < priors_cpu.size(0)) {
            prior = priors_acc[action];
        }
        option_priors.push_back(prior);
    }
    option_priors = normalize_nonnegative(option_priors);

    for (std::size_t i = 0; i < options.size(); ++i) {
        auto& [action, child_state] = options[i];
        node.add_child(action, std::move(child_state), option_priors[i]);
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

void MCTSEngine::apply_virtual_loss(TreeNode* node) {
    float loss = config_.virtual_loss;
    while (node) {
        node->add_virtual_loss(loss);
        node = node->parent();
    }
}

void MCTSEngine::revert_virtual_loss(TreeNode* node) {
    float loss = config_.virtual_loss;
    while (node) {
        node->revert_virtual_loss(loss);
        node = node->parent();
    }
}

void MCTSEngine::apply_dirichlet_noise(TreeNode& root) {
    auto state = root.state();
    std::vector<int64_t> valid_actions;
    std::vector<float> base_priors;
    valid_actions.reserve(root.children_ref().size());
    base_priors.reserve(root.children_ref().size());
    for (const auto& [action, child] : root.children_ref()) {
        if (child && action >= 0) {
            valid_actions.push_back(action);
            base_priors.push_back(child->prior());
        }
    }
    if (valid_actions.empty()) {
        return;
    }

    base_priors = normalize_nonnegative(base_priors);

    const float alpha = dynamic_root_dirichlet_alpha(valid_actions.size());
    std::gamma_distribution<float> gamma(alpha, 1.0f);
    std::vector<float> noise_vals;
    noise_vals.reserve(valid_actions.size());
    float noise_sum = 0.0f;
    for (std::size_t i = 0; i < valid_actions.size(); ++i) {
        float n = gamma(rng_);
        noise_vals.push_back(n);
        noise_sum += n;
    }
    if (noise_sum <= 0.0f) {
        return;
    }
    for (auto& v : noise_vals) {
        v /= noise_sum;
    }

    std::vector<float> mixed_vals(valid_actions.size(), 0.0f);
    for (std::size_t i = 0; i < valid_actions.size(); ++i) {
        mixed_vals[i] = (1.0f - config_.dirichlet_epsilon) * base_priors[i]
                        + config_.dirichlet_epsilon * noise_vals[i];
    }
    mixed_vals = normalize_nonnegative(mixed_vals);

    int64_t num_actions = infer_action_space_size(state);
    auto max_action = find_max_action_id(root.children_ref());
    if (max_action >= 0) {
        num_actions = std::max<int64_t>(num_actions, max_action + 1);
    }
    if (num_actions <= 0) {
        num_actions = std::max<int64_t>(1, static_cast<int64_t>(valid_actions.size()));
    }

    auto logits = torch::full({num_actions}, -1e9f, torch::TensorOptions().dtype(torch::kFloat32));
    for (std::size_t i = 0; i < valid_actions.size(); ++i) {
        int64_t action = valid_actions[i];
        float prob = std::max(1e-8f, mixed_vals[i]);
        if (action >= 0 && action < num_actions) {
            logits[action] = std::log(prob);
        }
    }
    state->policy_logits = logits;

    std::unordered_map<int64_t, float> mixed_by_action;
    mixed_by_action.reserve(valid_actions.size());
    for (std::size_t i = 0; i < valid_actions.size(); ++i) {
        mixed_by_action[valid_actions[i]] = mixed_vals[i];
    }

    for (const auto& [action, child] : root.children_ref()) {
        if (!child || action < 0) {
            continue;
        }
        auto it = mixed_by_action.find(action);
        if (it != mixed_by_action.end()) {
            child->set_prior(it->second);
        }
    }
}

}  // namespace azsfc
