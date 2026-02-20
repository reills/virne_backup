#include "solver.hpp"

#include <chrono>
#include <cmath>
#include <numeric>
#include <random>
#include <stdexcept>

namespace azsfc {
namespace {

torch::Tensor build_edge_index(const Network& net) {
    auto edge_index = torch::empty({2, net.num_edges}, torch::kInt64);
    auto edge_index_acc = edge_index.accessor<std::int64_t, 2>();
    for (int e = 0; e < net.num_edges; ++e) {
        edge_index_acc[0][e] = net.edges[e].first;
        edge_index_acc[1][e] = net.edges[e].second;
    }
    return edge_index;
}

torch::Tensor build_v_net_x(const Network& net, const std::vector<std::string>& node_resource_names) {
    auto x = torch::zeros({net.num_nodes, static_cast<long>(node_resource_names.size())}, torch::kFloat32);
    auto x_acc = x.accessor<float, 2>();
    for (int n = 0; n < net.num_nodes; ++n) {
        const auto& attrs = net.node_attrs[n];
        for (std::size_t j = 0; j < node_resource_names.size(); ++j) {
            const auto& name = node_resource_names[j];
            auto it = attrs.find(name);
            x_acc[n][j] = (it != attrs.end()) ? static_cast<float>(it->second) : 0.0f;
        }
    }
    return x;
}

torch::Tensor build_p_net_x(const VNRState& state, const Network& net, const std::vector<std::string>& node_resource_names) {
    auto x = torch::zeros({net.num_nodes, static_cast<long>(node_resource_names.size())}, torch::kFloat32);
    auto x_acc = x.accessor<float, 2>();
    for (int n = 0; n < net.num_nodes; ++n) {
        for (std::size_t j = 0; j < node_resource_names.size(); ++j) {
            const auto& name = node_resource_names[j];
            x_acc[n][j] = static_cast<float>(state.get_available_node_resource(n, name));
        }
    }
    return x;
}

torch::Tensor build_p_edge_attr(const VNRState& state, const Network& net, const std::vector<std::string>& link_resource_names) {
    auto attr = torch::zeros({net.num_edges, static_cast<long>(link_resource_names.size())}, torch::kFloat32);
    auto acc = attr.accessor<float, 2>();
    for (int e = 0; e < net.num_edges; ++e) {
        for (std::size_t j = 0; j < link_resource_names.size(); ++j) {
            const auto& name = link_resource_names[j];
            acc[e][j] = static_cast<float>(state.get_available_link_resource(e, name));
        }
    }
    return attr;
}

torch::Tensor build_selected_tensor(const std::vector<int>& selected) {
    auto t = torch::zeros({static_cast<long>(selected.size())}, torch::kInt64);
    auto acc = t.accessor<std::int64_t, 1>();
    for (std::size_t i = 0; i < selected.size(); ++i) {
        acc[i] = static_cast<std::int64_t>(selected[i]);
    }
    return t;
}

torch::Tensor build_action_mask(const VNRState& state, int num_actions, bool allow_rejection, int reject_idx) {
    auto mask = torch::zeros({1, num_actions}, torch::kBool);
    auto mask_acc = mask.accessor<bool, 2>();
    auto candidates = state.get_candidate_nodes();
    for (int action : candidates) {
        if (action < 0 || action >= num_actions) {
            continue;
        }
        mask_acc[0][action] = true;
    }
    if (allow_rejection && reject_idx >= 0 && reject_idx < num_actions) {
        mask_acc[0][reject_idx] = true;
    }
    return mask;
}

StateView::TensorMap build_inputs(
    const VNRState& state,
    const Network& p_net,
    const std::vector<std::string>& node_resource_names,
    const std::vector<std::string>& link_resource_names,
    const torch::Tensor& edge_index,
    const torch::Tensor& p_batch,
    const torch::Tensor& encoder_outputs,
    int num_actions,
    bool allow_rejection,
    int reject_idx
) {
    StateView::TensorMap inputs;
    inputs.emplace("p_net_x", build_p_net_x(state, p_net, node_resource_names));
    inputs.emplace("p_net_edge_index", edge_index);
    inputs.emplace("p_net_edge_attr", build_p_edge_attr(state, p_net, link_resource_names));
    inputs.emplace("p_net_batch", p_batch);
    inputs.emplace("selected_p_nodes", build_selected_tensor(state.selected_physical_nodes()));
    inputs.emplace("encoder_outputs", encoder_outputs);

    int step_idx = static_cast<int>(state.selected_physical_nodes().size());
    inputs.emplace("curr_v_node_id", torch::tensor({step_idx}, torch::kInt64));
    int remaining = std::max(0, static_cast<int>(state.virtual_order().size()) - (step_idx + 1));
    inputs.emplace("vnfs_remaining", torch::tensor({remaining}, torch::kInt64));

    inputs.emplace("action_mask", build_action_mask(state, num_actions, allow_rejection, reject_idx));
    return inputs;
}

std::vector<float> tensor_to_vector(const torch::Tensor& tensor) {
    auto cpu = tensor.to(torch::kCPU).contiguous();
    auto flat = cpu.view({-1});
    std::vector<float> out(static_cast<std::size_t>(flat.numel()));
    auto acc = flat.accessor<float, 1>();
    for (int64_t i = 0; i < flat.numel(); ++i) {
        out[static_cast<std::size_t>(i)] = acc[i];
    }
    return out;
}

int select_action(
    const std::vector<int>& candidates,
    const std::vector<float>& visit_counts,
    float temperature,
    std::mt19937& rng
) {
    if (candidates.empty()) {
        return -1;
    }
    if (temperature <= 0.0f) {
        int best_action = candidates.front();
        float best_visits = -1.0f;
        for (int action : candidates) {
            float visits = (action >= 0 && action < static_cast<int>(visit_counts.size())) ? visit_counts[action] : 0.0f;
            if (visits > best_visits) {
                best_visits = visits;
                best_action = action;
            }
        }
        return best_action;
    }

    std::vector<double> weights;
    weights.reserve(candidates.size());
    double total = 0.0;
    for (int action : candidates) {
        double visits = (action >= 0 && action < static_cast<int>(visit_counts.size())) ? visit_counts[action] : 0.0;
        double w = (temperature == 1.0f) ? visits : std::pow(visits, 1.0 / temperature);
        weights.push_back(w);
        total += w;
    }
    if (total <= 0.0) {
        std::uniform_int_distribution<int> uni(0, static_cast<int>(candidates.size()) - 1);
        return candidates[static_cast<std::size_t>(uni(rng))];
    }
    std::discrete_distribution<int> dist(weights.begin(), weights.end());
    return candidates[static_cast<std::size_t>(dist(rng))];
}

std::vector<float> build_policy_fallback(
    int num_actions,
    const std::vector<int>& candidates,
    const std::vector<float>& root_priors
) {
    std::vector<float> policy(static_cast<std::size_t>(num_actions), 0.0f);
    float sum_priors = 0.0f;
    if (!root_priors.empty()) {
        for (int a = 0; a < num_actions; ++a) {
            float p = (a < static_cast<int>(root_priors.size())) ? root_priors[a] : 0.0f;
            if (p > 0.0f && std::isfinite(p)) {
                policy[static_cast<std::size_t>(a)] = p;
                sum_priors += p;
            }
        }
        if (sum_priors > 0.0f) {
            for (float& p : policy) {
                p /= sum_priors;
            }
            return policy;
        }
    }

    if (candidates.empty()) {
        float uniform = 1.0f / static_cast<float>(num_actions);
        for (float& p : policy) {
            p = uniform;
        }
        return policy;
    }
    float uniform = 1.0f / static_cast<float>(candidates.size());
    for (int action : candidates) {
        if (action >= 0 && action < num_actions) {
            policy[static_cast<std::size_t>(action)] = uniform;
        }
    }
    return policy;
}

}  // namespace

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
) {
    SolveResult result;
    if (physical.num_nodes <= 0 || virtual_net.num_nodes <= 0) {
        result.place_result = false;
        return result;
    }

    auto start_ts = std::chrono::high_resolution_clock::now();

    VNRState root_state(std::make_shared<Network>(physical), std::make_shared<Network>(virtual_net), vnr_config);

    int num_actions = physical.num_nodes + (vnr_config.allow_rejection ? 1 : 0);
    int reject_idx = physical.num_nodes;

    torch::Device torch_device = torch::kCPU;
    if (device == "cuda" || device == "cuda:0") {
        torch_device = torch::kCUDA;
    }

    PolicyNetwork policy;
    if (search_config.use_neural_network) {
        policy.load(policy_path, torch_device);
    }

    auto edge_index = build_edge_index(physical);
    auto p_batch = torch::zeros({physical.num_nodes}, torch::kInt64);
    auto v_net_x = build_v_net_x(virtual_net, vnr_config.node_resource_names).unsqueeze(0);
    torch::Tensor encoder_outputs;
    if (search_config.use_neural_network) {
        encoder_outputs = policy.encode(v_net_x);
    } else {
        encoder_outputs = torch::zeros({1, virtual_net.num_nodes, 1}, torch::kFloat32);
    }

    MCTSEngine engine(search_config);

    if (search_config.use_neural_network) {
        engine.set_evaluate_callback([&](const std::shared_ptr<StateView>& view) {
            auto& domain = *view->domain_state;
            auto inputs = build_inputs(
                domain,
                physical,
                vnr_config.node_resource_names,
                vnr_config.link_resource_names,
                edge_index,
                p_batch,
                encoder_outputs,
                num_actions,
                vnr_config.allow_rejection,
                reject_idx
            );

            EvaluationResult eval = policy.evaluate(inputs);
            torch::Tensor logits = eval.policy_logits;
            torch::Tensor value = eval.value;
            if (!use_nn_policy) {
                logits = torch::zeros({num_actions}, torch::kFloat32);
            } else if (logits.defined() && logits.dim() > 1) {
                logits = logits.squeeze();
            }
            if (!use_nn_value) {
                value = torch::zeros({}, torch::kFloat32);
            }

            auto mask_it = inputs.find("action_mask");
            if (mask_it != inputs.end()) {
                view->action_mask = mask_it->second.squeeze(0).to(torch::kBool);
            }
            view->policy_logits = logits;
            view->value = value;
            return EvaluationResult{logits, value};
        });
    }

    std::mt19937 rng;
    if (seed) {
        rng.seed(*seed);
    } else {
        rng.seed(std::random_device{}());
    }

    VNRState current_state = root_state;

    for (int step = 0; step < virtual_net.num_nodes; ++step) {
        auto state_view = std::make_shared<StateView>();
        state_view->id = static_cast<std::int64_t>(step + 1);
        state_view->step_index = static_cast<std::int64_t>(current_state.selected_physical_nodes().size());
        state_view->domain_state = std::make_shared<VNRState>(current_state);

        std::optional<unsigned int> step_seed;
        if (seed) {
            step_seed = static_cast<unsigned int>(*seed + static_cast<unsigned int>(step));
        }
        auto search_result = engine.run_search(state_view, step_seed);

        auto visit_counts_vec = tensor_to_vector(search_result.visit_counts);
        auto policy_vec = tensor_to_vector(search_result.policy);

        std::vector<int> candidates;
        candidates.reserve(static_cast<std::size_t>(num_actions));
        std::vector<char> seen(static_cast<std::size_t>(num_actions), 0);
        for (int action : current_state.get_candidate_nodes()) {
            if (action < 0 || action >= num_actions) {
                continue;
            }
            if (!seen[static_cast<std::size_t>(action)]) {
                seen[static_cast<std::size_t>(action)] = 1;
                candidates.push_back(action);
            }
        }
        if (vnr_config.allow_rejection && reject_idx >= 0 && reject_idx < num_actions) {
            if (!seen[static_cast<std::size_t>(reject_idx)]) {
                candidates.push_back(reject_idx);
            }
        }

        float total_visits = 0.0f;
        for (int action : candidates) {
            if (action >= 0 && action < static_cast<int>(visit_counts_vec.size())) {
                total_visits += visit_counts_vec[action];
            }
        }
        if (total_visits <= 0.0f) {
            result.place_result = false;
            break;
        }

        if (policy_vec.empty() || std::accumulate(policy_vec.begin(), policy_vec.end(), 0.0f) <= 0.0f) {
            auto priors_vec = tensor_to_vector(search_result.root_priors);
            policy_vec = build_policy_fallback(num_actions, candidates, priors_vec);
        }

        int action = select_action(candidates, visit_counts_vec, temperature, rng);
        if (action == reject_idx && vnr_config.allow_rejection) {
            result.rejected = true;
            result.place_result = false;
            current_state = current_state.create_child(reject_idx);
            break;
        }
        if (action < 0 || action >= num_actions) {
            result.place_result = false;
            break;
        }

        result.actions.push_back(action);
        result.policies.push_back(std::move(policy_vec));
        result.values.push_back(search_result.value);
        result.metrics.total_simulations += static_cast<int>(search_result.visit_counts.sum().item<float>());

        current_state = current_state.create_child(action);
        if (current_state.last_physical_node() == -1) {
            result.place_result = false;
            break;
        }
    }

    result.metrics.steps = static_cast<int>(result.actions.size());
    result.final_reward = current_state.compute_final_reward();

    auto end_ts = std::chrono::high_resolution_clock::now();
    result.metrics.total_time_ms = std::chrono::duration<double, std::milli>(end_ts - start_ts).count();

    return result;
}

}  // namespace azsfc
