#include "solver.hpp"
#include "replay_writer.hpp"

#include <algorithm>
#include <chrono>
#include <cmath>
#include <filesystem>
#include <limits>
#include <mutex>
#include <numeric>
#include <random>
#include <stdexcept>
#include <unordered_map>

namespace azsfc {
namespace {

struct CachedPolicyEntry {
    std::shared_ptr<PolicyNetwork> policy;
    std::filesystem::file_time_type mtime{};
};

std::mutex g_policy_cache_mutex;
std::unordered_map<std::string, CachedPolicyEntry> g_policy_cache;

std::string policy_cache_key(const std::string& path, const torch::Device& device) {
    const char* device_key = (device.type() == torch::kCUDA) ? "cuda" : "cpu";
    return path + "|" + device_key;
}

float normalize_value_target(float raw_reward, const SearchConfig& search_config) {
    std::string mode = search_config.value_normalization;
    std::transform(mode.begin(), mode.end(), mode.begin(),
                   [](unsigned char c) { return static_cast<char>(std::tolower(c)); });
    if (mode == "raw") {
        return raw_reward;
    }
    if (mode == "tanh") {
        const float scale = std::abs(search_config.value_scale) > 1e-8f ? search_config.value_scale : 1.0f;
        return std::tanh(raw_reward / scale);
    }
    if (mode == "sign") {
        return raw_reward > 0.0f ? 1.0f : -1.0f;
    }
    // acceptance_first depends on running accepted-cost stats inside MCTS. For replay
    // labels outside the tree, keep the historical success/failure fallback.
    return raw_reward > 0.0f ? 1.0f : -1.0f;
}

std::shared_ptr<PolicyNetwork> get_cached_policy(const std::string& path, const torch::Device& device) {
    const std::string key = policy_cache_key(path, device);

    {
        std::lock_guard<std::mutex> lock(g_policy_cache_mutex);
        auto it = g_policy_cache.find(key);
        if (it != g_policy_cache.end() && it->second.policy) {
            auto current_mtime = std::filesystem::last_write_time(path);
            if (it->second.mtime == current_mtime) {
                return it->second.policy;
            }
        }
    }

    auto policy = std::make_shared<PolicyNetwork>();
    try {
        policy->load(path, device);
    } catch (...) {
        // Retry once in case the file was replaced between mtime check and load.
        auto retry = std::make_shared<PolicyNetwork>();
        retry->load(path, device);
        policy = std::move(retry);
    }

    auto final_mtime = std::filesystem::last_write_time(path);
    {
        std::lock_guard<std::mutex> lock(g_policy_cache_mutex);
        auto& entry = g_policy_cache[key];
        entry.policy = policy;
        entry.mtime = final_mtime;
    }

    return policy;
}

double safe_lookup(const std::unordered_map<std::string, double>& attrs, const std::string& key) {
    auto it = attrs.find(key);
    if (it == attrs.end()) {
        return 0.0;
    }
    return it->second;
}

double safe_div(double value, double benchmark) {
    if (std::abs(benchmark) <= 1e-12) {
        return value;
    }
    return value / benchmark;
}

constexpr const char* kPTopoDegree = "__az_p_degree__";
constexpr const char* kPTopoCloseness = "__az_p_closeness__";
constexpr const char* kPTopoEigenvector = "__az_p_eigenvector__";
constexpr const char* kPTopoBetweenness = "__az_p_betweenness__";
constexpr const char* kVTopoDegree = "__az_v_degree__";
constexpr const char* kVTopoCloseness = "__az_v_closeness__";
constexpr const char* kVTopoEigenvector = "__az_v_eigenvector__";
constexpr const char* kVTopoBetweenness = "__az_v_betweenness__";

int compute_p_net_feature_dim(const VNRConfig& cfg) {
    int dim = static_cast<int>(cfg.node_resource_names.size()) + 1;
    if (cfg.feature_use_node_status_flags) {
        dim += 2;
    }
    if (cfg.feature_use_aggregated_link_attrs) {
        dim += static_cast<int>(cfg.link_resource_names.size()) * 4;
    }
    if (cfg.feature_use_degree_metric) {
        dim += 1;
    }
    if (cfg.feature_use_more_topological_metrics) {
        dim += 3;
    }
    return dim;
}

int compute_v_net_feature_dim(const VNRConfig& cfg) {
    int dim = static_cast<int>(cfg.node_resource_names.size()) + 1;
    if (cfg.feature_use_node_status_flags) {
        dim += 3;
    }
    if (cfg.feature_use_aggregated_link_attrs) {
        dim += static_cast<int>(cfg.link_resource_names.size()) * 4;
    }
    if (cfg.feature_use_degree_metric) {
        dim += 1;
    }
    if (cfg.feature_use_more_topological_metrics) {
        dim += 3;
    }
    return dim;
}

double available_node_resource(
    const Network& net,
    const VNRState::SparseResourceAllocations& allocated,
    int node_id,
    const std::string& attr_name
) {
    double value = safe_lookup(net.node_attrs[node_id], attr_name);
    auto node_it = allocated.find(node_id);
    if (node_it == allocated.end()) {
        return value;
    }
    auto attr_it = node_it->second.find(attr_name);
    if (attr_it == node_it->second.end()) {
        return value;
    }
    return value - attr_it->second;
}

double available_link_resource(
    const Network& net,
    const VNRState::SparseResourceAllocations& allocated,
    int edge_id,
    const std::string& attr_name
) {
    double value = safe_lookup(net.edge_attrs[edge_id], attr_name);
    auto edge_it = allocated.find(edge_id);
    if (edge_it == allocated.end()) {
        return value;
    }
    auto attr_it = edge_it->second.find(attr_name);
    if (attr_it == edge_it->second.end()) {
        return value;
    }
    return value - attr_it->second;
}

int current_virtual_node_id(const VNRState& state) {
    const auto& order = state.virtual_order();
    const auto& selected = state.selected_physical_nodes();
    if (selected.size() >= order.size()) {
        return -1;
    }
    return order[selected.size()];
}

std::unordered_map<int, int> build_node_slots(const VNRState& state) {
    std::unordered_map<int, int> node_slots;
    const auto& order = state.virtual_order();
    const auto& selected = state.selected_physical_nodes();
    int placed = std::min(static_cast<int>(order.size()), static_cast<int>(selected.size()));
    node_slots.reserve(placed);
    for (int idx = 0; idx < placed; ++idx) {
        node_slots.emplace(order[idx], selected[idx]);
    }
    return node_slots;
}

std::vector<int> build_selected_p_neighbors(
    const Network& virtual_net,
    const VNRState& state
) {
    std::vector<int> neighbors;
    int curr_v_node = current_virtual_node_id(state);
    if (curr_v_node < 0 || curr_v_node >= virtual_net.num_nodes) {
        return neighbors;
    }
    const auto node_slots = build_node_slots(state);
    for (const auto& [v_neighbor, _edge_id] : virtual_net.adjacency[curr_v_node]) {
        auto it = node_slots.find(v_neighbor);
        if (it != node_slots.end()) {
            neighbors.push_back(it->second);
        }
    }
    return neighbors;
}

std::vector<double> compute_average_distance(const Network& net, const std::vector<int>& selected) {
    std::vector<double> avg(net.num_nodes, 0.0);
    if (selected.empty()) {
        return avg;
    }
    std::vector<int> queue(net.num_nodes, 0);
    for (int src = 0; src < net.num_nodes; ++src) {
        std::vector<int> dist(net.num_nodes, -1);
        int head = 0;
        int tail = 0;
        dist[src] = 0;
        queue[tail++] = src;
        while (head < tail) {
            int u = queue[head++];
            for (const auto& [v, _edge_id] : net.adjacency[u]) {
                if (dist[v] >= 0) {
                    continue;
                }
                dist[v] = dist[u] + 1;
                queue[tail++] = v;
            }
        }
        double sum = 0.0;
        for (int dst : selected) {
            if (dst >= 0 && dst < net.num_nodes && dist[dst] >= 0) {
                sum += static_cast<double>(dist[dst]);
            }
        }
        avg[src] = sum / static_cast<double>(selected.size() + 1);
    }
    double min_val = *std::min_element(avg.begin(), avg.end());
    double max_val = *std::max_element(avg.begin(), avg.end());
    if (std::abs(max_val - min_val) <= 1e-12) {
        return avg;
    }
    for (double& value : avg) {
        value = (value - min_val) / (max_val - min_val);
    }
    return avg;
}

double sum_node_demand(const Network& net, const std::vector<std::string>& node_resource_names) {
    double total = 0.0;
    for (int n = 0; n < net.num_nodes; ++n) {
        const auto& attrs = net.node_attrs[n];
        for (const auto& name : node_resource_names) {
            total += safe_lookup(attrs, name);
        }
    }
    return total;
}

double sum_link_demand(const Network& net, const std::vector<std::string>& link_resource_names) {
    double total = 0.0;
    for (int e = 0; e < net.num_edges; ++e) {
        const auto& attrs = net.edge_attrs[e];
        for (const auto& name : link_resource_names) {
            total += safe_lookup(attrs, name);
        }
    }
    return total;
}

torch::Tensor build_edge_index(const Network& net) {
    const int out_edges = net.directed ? net.num_edges : net.num_edges * 2;
    auto edge_index = torch::empty({2, out_edges}, torch::kInt64);
    auto edge_index_acc = edge_index.accessor<std::int64_t, 2>();
    for (int e = 0; e < net.num_edges; ++e) {
        int out = net.directed ? e : (2 * e);
        edge_index_acc[0][out] = net.edges[e].first;
        edge_index_acc[1][out] = net.edges[e].second;
        if (!net.directed) {
            edge_index_acc[0][out + 1] = net.edges[e].second;
            edge_index_acc[1][out + 1] = net.edges[e].first;
        }
    }
    return edge_index;
}

torch::Tensor build_v_net_x(const Network& net, const VNRState& state, const VNRConfig& cfg, int p_net_num_nodes) {
    (void)p_net_num_nodes;
    auto x = torch::zeros({net.num_nodes, compute_v_net_feature_dim(cfg)}, torch::kFloat32);
    auto x_acc = x.accessor<float, 2>();
    const auto node_slots = build_node_slots(state);
    const int curr_v_node = current_virtual_node_id(state);
    const double curr_neighbors = (curr_v_node >= 0 && net.num_nodes > 0)
        ? (static_cast<double>(net.adjacency[curr_v_node].size()) / static_cast<double>(net.num_nodes))
        : 0.0;
    for (int n = 0; n < net.num_nodes; ++n) {
        int feat_idx = 0;
        for (const auto& name : cfg.node_resource_names) {
            x_acc[n][feat_idx++] = static_cast<float>(safe_div(
                safe_lookup(net.node_attrs[n], name),
                safe_lookup(cfg.node_attr_benchmarks, name)
            ));
        }
        if (cfg.feature_use_node_status_flags) {
            x_acc[n][feat_idx++] = node_slots.count(n) ? 1.0f : 0.0f;
            x_acc[n][feat_idx++] = (curr_v_node == n) ? 1.0f : 0.0f;
            float neighbor_flag = 0.0f;
            if (curr_v_node >= 0 && curr_v_node < net.num_nodes) {
                for (const auto& [neighbor, _edge_id] : net.adjacency[curr_v_node]) {
                    if (node_slots.count(neighbor)) {
                        neighbor_flag = 1.0f;
                        break;
                    }
                }
            }
            x_acc[n][feat_idx++] = neighbor_flag;
        }
        if (cfg.feature_use_aggregated_link_attrs) {
            for (const auto& name : cfg.link_resource_names) {
                double min_v = 0.0, max_v = 0.0, sum_v = 0.0, mean_v = 0.0;
                if (!net.adjacency[n].empty()) {
                    min_v = std::numeric_limits<double>::infinity();
                    for (const auto& [_neighbor, edge_id] : net.adjacency[n]) {
                        double value = safe_lookup(net.edge_attrs[edge_id], name);
                        min_v = std::min(min_v, value);
                        max_v = std::max(max_v, value);
                        sum_v += value;
                    }
                    mean_v = sum_v / static_cast<double>(net.adjacency[n].size());
                    if (!std::isfinite(min_v)) {
                        min_v = 0.0;
                    }
                }
                x_acc[n][feat_idx++] = static_cast<float>(safe_div(min_v, safe_lookup(cfg.link_attr_benchmarks, name)));
                x_acc[n][feat_idx++] = static_cast<float>(safe_div(max_v, safe_lookup(cfg.link_attr_benchmarks, name)));
                x_acc[n][feat_idx++] = static_cast<float>(safe_div(sum_v, safe_lookup(cfg.link_sum_attr_benchmarks, name)));
                x_acc[n][feat_idx++] = static_cast<float>(safe_div(mean_v, safe_lookup(cfg.link_attr_benchmarks, name)));
            }
        }
        x_acc[n][feat_idx++] = static_cast<float>(curr_neighbors);
        if (cfg.feature_use_degree_metric) {
            x_acc[n][feat_idx++] = static_cast<float>(safe_lookup(net.node_attrs[n], kVTopoDegree));
        }
        if (cfg.feature_use_more_topological_metrics) {
            x_acc[n][feat_idx++] = static_cast<float>(safe_lookup(net.node_attrs[n], kVTopoCloseness));
            x_acc[n][feat_idx++] = static_cast<float>(safe_lookup(net.node_attrs[n], kVTopoEigenvector));
            x_acc[n][feat_idx++] = static_cast<float>(safe_lookup(net.node_attrs[n], kVTopoBetweenness));
        }
    }
    return x;
}

torch::Tensor build_p_net_x(
    const Network& net,
    const Network& virtual_net,
    const VNRState& state,
    const VNRConfig& cfg
) {
    auto x = torch::zeros({net.num_nodes, compute_p_net_feature_dim(cfg)}, torch::kFloat32);
    auto x_acc = x.accessor<float, 2>();
    const auto node_alloc = state.get_allocated_node_resources();
    const auto link_alloc = state.get_allocated_link_resources();
    const auto& selected = state.selected_physical_nodes();
    const auto selected_neighbors = build_selected_p_neighbors(virtual_net, state);
    const auto avg_distance = compute_average_distance(net, selected);
    for (int n = 0; n < net.num_nodes; ++n) {
        int feat_idx = 0;
        for (const auto& name : cfg.node_resource_names) {
            x_acc[n][feat_idx++] = static_cast<float>(safe_div(
                available_node_resource(net, node_alloc, n, name),
                safe_lookup(cfg.node_attr_benchmarks, name)
            ));
        }
        if (cfg.feature_use_node_status_flags) {
            x_acc[n][feat_idx++] = std::find(selected.begin(), selected.end(), n) != selected.end() ? 1.0f : 0.0f;
            x_acc[n][feat_idx++] = std::find(selected_neighbors.begin(), selected_neighbors.end(), n) != selected_neighbors.end() ? 1.0f : 0.0f;
        }
        if (cfg.feature_use_aggregated_link_attrs) {
            for (const auto& name : cfg.link_resource_names) {
                double min_v = 0.0, mean_v = 0.0, max_v = 0.0, sum_v = 0.0;
                if (!net.adjacency[n].empty()) {
                    min_v = std::numeric_limits<double>::infinity();
                    for (const auto& [_neighbor, edge_id] : net.adjacency[n]) {
                        double value = available_link_resource(net, link_alloc, edge_id, name);
                        min_v = std::min(min_v, value);
                        max_v = std::max(max_v, value);
                        sum_v += value;
                    }
                    mean_v = sum_v / static_cast<double>(net.adjacency[n].size());
                    if (!std::isfinite(min_v)) {
                        min_v = 0.0;
                    }
                }
                x_acc[n][feat_idx++] = static_cast<float>(safe_div(min_v, safe_lookup(cfg.link_attr_benchmarks, name)));
                x_acc[n][feat_idx++] = static_cast<float>(safe_div(mean_v, safe_lookup(cfg.link_attr_benchmarks, name)));
                x_acc[n][feat_idx++] = static_cast<float>(safe_div(max_v, safe_lookup(cfg.link_attr_benchmarks, name)));
                x_acc[n][feat_idx++] = static_cast<float>(safe_div(sum_v, safe_lookup(cfg.link_sum_attr_benchmarks, name)));
            }
        }
        x_acc[n][feat_idx++] = static_cast<float>(avg_distance[n]);
        if (cfg.feature_use_degree_metric) {
            x_acc[n][feat_idx++] = static_cast<float>(safe_lookup(net.node_attrs[n], kPTopoDegree));
        }
        if (cfg.feature_use_more_topological_metrics) {
            x_acc[n][feat_idx++] = static_cast<float>(safe_lookup(net.node_attrs[n], kPTopoCloseness));
            x_acc[n][feat_idx++] = static_cast<float>(safe_lookup(net.node_attrs[n], kPTopoEigenvector));
            x_acc[n][feat_idx++] = static_cast<float>(safe_lookup(net.node_attrs[n], kPTopoBetweenness));
        }
    }
    return x;
}

torch::Tensor build_p_edge_attr(
    const Network& net,
    const VNRState& state,
    const VNRConfig& cfg
) {
    const auto link_alloc = state.get_allocated_link_resources();
    const int out_edges = net.directed ? net.num_edges : net.num_edges * 2;
    auto attr = torch::zeros({out_edges, static_cast<long>(cfg.link_resource_names.size())}, torch::kFloat32);
    auto acc = attr.accessor<float, 2>();
    for (int e = 0; e < net.num_edges; ++e) {
        int out = net.directed ? e : (2 * e);
        for (std::size_t j = 0; j < cfg.link_resource_names.size(); ++j) {
            const auto& name = cfg.link_resource_names[j];
            float value = static_cast<float>(safe_div(
                available_link_resource(net, link_alloc, e, name),
                safe_lookup(cfg.link_attr_benchmarks, name)
            ));
            acc[out][j] = value;
            if (!net.directed) {
                acc[out + 1][j] = value;
            }
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

torch::Tensor build_action_mask_device(
    const std::vector<int>& candidates,
    int num_actions,
    bool allow_rejection,
    int reject_idx,
    torch::Device device
) {
    auto mask = torch::zeros({1, num_actions}, torch::TensorOptions().dtype(torch::kBool).device(device));
    if (device.is_cuda()) {
        std::vector<int64_t> indices;
        indices.reserve(candidates.size() + 1);
        for (int action : candidates) {
            if (action >= 0 && action < num_actions) {
                indices.push_back(static_cast<int64_t>(action));
            }
        }
        if (allow_rejection && reject_idx >= 0 && reject_idx < num_actions) {
            indices.push_back(static_cast<int64_t>(reject_idx));
        }
        if (!indices.empty()) {
            auto idx = torch::tensor(indices, torch::TensorOptions().dtype(torch::kInt64).device(device));
            mask.index_put_({0, idx}, true);
        }
    } else {
        auto mask_acc = mask.accessor<bool, 2>();
        for (int action : candidates) {
            if (action < 0 || action >= num_actions) {
                continue;
            }
            mask_acc[0][action] = true;
        }
        if (allow_rejection && reject_idx >= 0 && reject_idx < num_actions) {
            mask_acc[0][reject_idx] = true;
        }
    }
    return mask;
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

torch::Tensor build_history_features_single(
    const torch::Tensor& p_net_x,
    const std::vector<int>& selected,
    const torch::Tensor& start_embedding,
    torch::Device device
) {
    int64_t hist_len = static_cast<int64_t>(selected.size()) + 1;
    auto options = torch::TensorOptions().dtype(p_net_x.dtype()).device(device);
    auto history = torch::zeros({1, hist_len, p_net_x.size(1)}, options);
    if (start_embedding.defined()) {
        auto start = start_embedding.to(device, p_net_x.dtype()).view({-1});
        int64_t length = std::min<int64_t>(start.numel(), history.size(2));
        if (length > 0) {
            history[0][0].narrow(0, 0, length).copy_(start.narrow(0, 0, length));
        }
    }
    if (!selected.empty()) {
        auto idx = torch::tensor(selected, torch::TensorOptions().dtype(torch::kInt64).device(device));
        auto gathered = p_net_x.index_select(0, idx);
        history[0].narrow(0, 1, static_cast<int64_t>(selected.size())).copy_(gathered);
    }
    return history;
}

StateView::TensorMap build_inputs_cached(
    const VNRState& state,
    const Network& physical,
    const Network& virtual_net,
    const VNRConfig& vnr_config,
    PolicyNetwork& policy,
    const torch::Tensor& edge_index,
    const torch::Tensor& p_batch,
    int num_actions,
    bool allow_rejection,
    int reject_idx,
    const torch::Tensor& start_embedding,
    torch::Device device
) {
    StateView::TensorMap inputs;
    auto p_net_x = build_p_net_x(physical, virtual_net, state, vnr_config).to(device);
    auto p_edge_attr = build_p_edge_attr(physical, state, vnr_config).to(device);
    auto v_net_x = build_v_net_x(virtual_net, state, vnr_config, physical.num_nodes).unsqueeze(0).to(device);
    inputs.emplace("p_net_x", p_net_x);
    inputs.emplace("p_net_edge_index", edge_index);
    inputs.emplace("p_net_edge_attr", p_edge_attr);
    inputs.emplace("p_net_batch", p_batch);
    inputs.emplace("encoder_outputs", policy.encode(v_net_x));

    const auto& selected = state.selected_physical_nodes();
    inputs.emplace("selected_p_nodes", build_selected_tensor(selected).to(device));
    inputs.emplace("history_features", build_history_features_single(p_net_x, selected, start_embedding, device));
    inputs.emplace(
        "history_lengths",
        torch::tensor(
            {static_cast<int64_t>(selected.size()) + 1},
            torch::TensorOptions().dtype(torch::kInt64).device(device))
    );

    int step_idx = static_cast<int>(selected.size());
    inputs.emplace("curr_v_node_id", torch::tensor({step_idx}, torch::TensorOptions().dtype(torch::kInt64).device(device)));
    int remaining = std::max(0, static_cast<int>(state.virtual_order().size()) - (step_idx + 1));
    inputs.emplace("vnfs_remaining", torch::tensor({remaining}, torch::TensorOptions().dtype(torch::kInt64).device(device)));

    auto candidates = state.get_candidate_nodes();
    inputs.emplace("action_mask", build_action_mask_device(candidates, num_actions, allow_rejection, reject_idx, device));
    inputs.emplace("candidate_features", state.build_candidate_feature_tensor().to(device));
    return inputs;
}

StateView::TensorMap build_inputs_batch(
    const std::vector<std::shared_ptr<StateView>>& states,
    const Network& physical,
    const Network& virtual_net,
    const VNRConfig& vnr_config,
    PolicyNetwork& policy,
    const torch::Tensor& edge_index_batched,
    const torch::Tensor& p_batch_batched,
    int num_actions,
    bool allow_rejection,
    int reject_idx,
    const torch::Tensor& start_embedding,
    torch::Device device
) {
    std::size_t batch_size = states.size();
    StateView::TensorMap inputs;
    if (batch_size == 0) {
        return inputs;
    }

    std::vector<torch::Tensor> p_net_x_list;
    std::vector<torch::Tensor> p_edge_attr_list;
    std::vector<torch::Tensor> v_net_x_list;
    p_net_x_list.reserve(batch_size);
    p_edge_attr_list.reserve(batch_size);
    v_net_x_list.reserve(batch_size);

    std::vector<std::vector<int>> selected_nodes;
    selected_nodes.reserve(batch_size);
    std::vector<int64_t> curr_v_ids;
    std::vector<int64_t> remaining;
    std::vector<int64_t> history_lengths;
    curr_v_ids.reserve(batch_size);
    remaining.reserve(batch_size);
    history_lengths.reserve(batch_size);
    std::vector<torch::Tensor> masks;
    masks.reserve(batch_size);
    std::vector<torch::Tensor> candidate_features;
    candidate_features.reserve(batch_size);

    int64_t max_hist_len = 1;
    for (const auto& view : states) {
        auto& domain = *view->domain_state;
        auto p_net_x = build_p_net_x(physical, virtual_net, domain, vnr_config).to(device);
        auto p_edge_attr = build_p_edge_attr(physical, domain, vnr_config).to(device);
        p_net_x_list.push_back(p_net_x);
        p_edge_attr_list.push_back(p_edge_attr);
        v_net_x_list.push_back(build_v_net_x(virtual_net, domain, vnr_config, physical.num_nodes).to(device));

        const auto& selected = domain.selected_physical_nodes();
        selected_nodes.emplace_back(selected.begin(), selected.end());
        max_hist_len = std::max<int64_t>(max_hist_len, static_cast<int64_t>(selected.size()) + 1);
        history_lengths.push_back(static_cast<int64_t>(selected.size()) + 1);

        int step_idx = static_cast<int>(selected.size());
        curr_v_ids.push_back(step_idx);
        int remain = std::max(0, static_cast<int>(domain.virtual_order().size()) - (step_idx + 1));
        remaining.push_back(remain);

        auto candidates = domain.get_candidate_nodes();
        masks.push_back(build_action_mask_device(candidates, num_actions, allow_rejection, reject_idx, device));
        candidate_features.push_back(domain.build_candidate_feature_tensor().to(device));
    }

    auto p_net_x_batch = torch::cat(p_net_x_list, 0);
    auto p_edge_attr_batch = torch::cat(p_edge_attr_list, 0);
    inputs.emplace("p_net_x", p_net_x_batch);
    inputs.emplace("p_net_edge_index", edge_index_batched);
    inputs.emplace("p_net_edge_attr", p_edge_attr_batch);
    inputs.emplace("p_net_batch", p_batch_batched);
    inputs.emplace("encoder_outputs", policy.encode(torch::stack(v_net_x_list, 0)));

    auto options = torch::TensorOptions().dtype(p_net_x_batch.dtype()).device(device);
    auto history = torch::zeros({static_cast<long>(batch_size), max_hist_len, p_net_x_batch.size(1)}, options);
    if (start_embedding.defined()) {
        auto start = start_embedding.to(device, p_net_x_batch.dtype()).view({-1});
        int64_t length = std::min<int64_t>(start.numel(), history.size(2));
        if (length > 0) {
            auto expanded = start.narrow(0, 0, length).expand({static_cast<long>(batch_size), length});
            history.select(1, 0).narrow(1, 0, length).copy_(expanded);
        }
    }

    for (std::size_t i = 0; i < batch_size; ++i) {
        const auto& selected = selected_nodes[i];
        if (selected.empty()) {
            continue;
        }
        auto idx = torch::tensor(selected, torch::TensorOptions().dtype(torch::kInt64).device(device));
        auto gathered = p_net_x_list[i].index_select(0, idx);
        history[i].narrow(0, 1, static_cast<int64_t>(selected.size())).copy_(gathered);
    }
    inputs.emplace("history_features", history);
    inputs.emplace("history_lengths", torch::tensor(history_lengths, torch::TensorOptions().dtype(torch::kInt64).device(device)));
    inputs.emplace("selected_p_nodes", torch::zeros({0}, torch::TensorOptions().dtype(torch::kInt64).device(device)));

    inputs.emplace("curr_v_node_id", torch::tensor(curr_v_ids, torch::TensorOptions().dtype(torch::kInt64).device(device)));
    inputs.emplace("vnfs_remaining", torch::tensor(remaining, torch::TensorOptions().dtype(torch::kInt64).device(device)));

    if (!masks.empty()) {
        inputs.emplace("action_mask", torch::cat(masks, 0));
    } else {
        inputs.emplace("action_mask", torch::zeros({static_cast<long>(batch_size), num_actions},
                                                   torch::TensorOptions().dtype(torch::kBool).device(device)));
    }
    if (!candidate_features.empty()) {
        inputs.emplace("candidate_features", torch::cat(candidate_features, 0));
    } else {
        inputs.emplace(
            "candidate_features",
            torch::zeros(
                {static_cast<long>(batch_size), num_actions, states.front()->domain_state->candidate_feature_dim()},
                torch::TensorOptions().dtype(torch::kFloat32).device(device)));
    }
    return inputs;
}

Observation build_observation(
    const VNRState& state,
    const Network& p_net,
    const Network& v_net,
    const VNRConfig& vnr_config,
    PolicyNetwork* policy,
    const torch::Tensor& edge_index_cpu,
    const torch::Tensor& start_embedding_cpu,
    int num_actions,
    bool allow_rejection,
    int reject_idx
) {
    Observation obs;
    obs.p_net_x = build_p_net_x(p_net, v_net, state, vnr_config);
    obs.p_net_edge_index = edge_index_cpu;
    obs.p_net_edge_attr = build_p_edge_attr(p_net, state, vnr_config);
    obs.p_net_num_nodes = p_net.num_nodes;
    obs.v_net_x = build_v_net_x(v_net, state, vnr_config, p_net.num_nodes).unsqueeze(0);
    if (policy != nullptr) {
        obs.encoder_outputs = policy->encode(obs.v_net_x);
    } else {
        obs.encoder_outputs = torch::zeros({1, v_net.num_nodes, 1}, torch::kFloat32);
    }

    const auto& selected = state.selected_physical_nodes();
    int64_t history_len = static_cast<int64_t>(selected.size()) + 1;
    auto history_features = torch::zeros({1, history_len, obs.p_net_x.size(1)}, torch::kFloat32);
    if (start_embedding_cpu.numel() == history_features.size(2)) {
        history_features[0][0].copy_(start_embedding_cpu);
    } else {
        int64_t length = std::min<int64_t>(start_embedding_cpu.numel(), history_features.size(2));
        if (length > 0) {
            history_features[0][0].narrow(0, 0, length).copy_(start_embedding_cpu.narrow(0, 0, length));
        }
    }
    for (std::size_t i = 0; i < selected.size(); ++i) {
        int node_id = selected[i];
        if (node_id >= 0 && node_id < obs.p_net_x.size(0)) {
            history_features[0][static_cast<int64_t>(i) + 1].copy_(obs.p_net_x[node_id]);
        }
    }
    obs.history_features = history_features;

    int step_idx = static_cast<int>(selected.size());
    obs.curr_v_node_id = torch::tensor({step_idx}, torch::kInt64);
    int remaining = std::max(0, static_cast<int>(state.virtual_order().size()) - (step_idx + 1));
    obs.vnfs_remaining = torch::tensor({remaining}, torch::kInt64);
    obs.action_mask = build_action_mask(state, num_actions, allow_rejection, reject_idx);
    obs.candidate_features = state.build_candidate_feature_tensor();
    return obs;
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

float temperature_for_step(
    float base_temperature,
    int step_idx,
    int move_threshold,
    float temperature_after_threshold
) {
    if (move_threshold >= 0 && step_idx >= move_threshold) {
        return temperature_after_threshold;
    }
    return base_temperature;
}

std::vector<float> build_policy_from_visits(
    int num_actions,
    const std::vector<int>& candidates,
    const std::vector<float>& visit_counts,
    float temperature
) {
    std::vector<float> policy(static_cast<std::size_t>(num_actions), 0.0f);
    if (candidates.empty()) {
        return policy;
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
        if (best_action >= 0 && best_action < num_actions) {
            policy[static_cast<std::size_t>(best_action)] = 1.0f;
        }
        return policy;
    }

    double total = 0.0;
    for (int action : candidates) {
        if (action < 0 || action >= num_actions) {
            continue;
        }
        double visits = (action < static_cast<int>(visit_counts.size())) ? visit_counts[action] : 0.0;
        double weight = (temperature == 1.0f) ? visits : std::pow(visits, 1.0 / temperature);
        if (!std::isfinite(weight) || weight < 0.0) {
            weight = 0.0;
        }
        policy[static_cast<std::size_t>(action)] = static_cast<float>(weight);
        total += weight;
    }
    if (total <= 0.0) {
        float uniform = 1.0f / static_cast<float>(candidates.size());
        for (int action : candidates) {
            if (action >= 0 && action < num_actions) {
                policy[static_cast<std::size_t>(action)] = uniform;
            }
        }
        return policy;
    }
    float inv_total = static_cast<float>(1.0 / total);
    for (float& value : policy) {
        value *= inv_total;
    }
    return policy;
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
) {
    SolveResult result;
    if (physical.num_nodes <= 0 || virtual_net.num_nodes <= 0) {
        result.place_result = false;
        return result;
    }

    bool do_replay = write_replay && !replay_dir.empty();

    auto start_ts = std::chrono::high_resolution_clock::now();

    VNRState root_state(std::make_shared<Network>(physical), std::make_shared<Network>(virtual_net), vnr_config);

    int num_actions = physical.num_nodes + (vnr_config.allow_rejection ? 1 : 0);
    int reject_idx = physical.num_nodes;

    torch::Device torch_device = torch::kCPU;
    if (device == "cuda" || device == "cuda:0") {
        torch_device = torch::kCUDA;
    }

    std::shared_ptr<PolicyNetwork> policy;
    bool need_policy = search_config.use_neural_network || do_replay;
    if (need_policy) {
        policy = get_cached_policy(policy_path, torch_device);
    }

    auto edge_index_cpu = build_edge_index(physical);
    auto p_batch_cpu = torch::zeros({physical.num_nodes}, torch::kInt64);
    auto edge_index = edge_index_cpu;
    auto p_batch = p_batch_cpu;
    if (torch_device.type() == torch::kCUDA) {
        edge_index = edge_index.to(torch_device);
        p_batch = p_batch.to(torch_device);
    }
    torch::Tensor start_embedding_cpu;
    if (do_replay) {
        start_embedding_cpu = policy->start_embedding().to(torch::kCPU);
    } else {
        start_embedding_cpu = torch::zeros({compute_p_net_feature_dim(vnr_config)}, torch::kFloat32);
    }

    MCTSEngine engine(search_config);
    double build_inputs_ms = 0.0;
    double policy_eval_ms = 0.0;
    double mcts_ms = 0.0;
    double postprocess_ms = 0.0;
    torch::Tensor start_embedding = do_replay ? policy->start_embedding().to(torch_device)
                                              : torch::zeros({compute_p_net_feature_dim(vnr_config)},
                                                             torch::TensorOptions().dtype(torch::kFloat32).device(torch_device));

    std::unordered_map<int, torch::Tensor> edge_index_batch_cache;
    std::unordered_map<int, torch::Tensor> p_batch_cache;

    auto get_edge_index_batched = [&](int batch_size) {
        auto it = edge_index_batch_cache.find(batch_size);
        if (it != edge_index_batch_cache.end()) {
            return it->second;
        }
        int64_t nodes = physical.num_nodes;
        int64_t edges = edge_index_cpu.size(1);
        auto base = edge_index_cpu.to(torch::kCPU).contiguous();
        auto batched = torch::empty({2, edges * batch_size}, torch::TensorOptions().dtype(torch::kInt64));
        auto base_acc = base.accessor<std::int64_t, 2>();
        auto batched_acc = batched.accessor<std::int64_t, 2>();
        for (int b = 0; b < batch_size; ++b) {
            int64_t offset = static_cast<int64_t>(b) * nodes;
            int64_t start = static_cast<int64_t>(b) * edges;
            for (int64_t e = 0; e < edges; ++e) {
                batched_acc[0][start + e] = base_acc[0][e] + offset;
                batched_acc[1][start + e] = base_acc[1][e] + offset;
            }
        }
        if (torch_device.type() == torch::kCUDA) {
            batched = batched.to(torch_device);
        }
        edge_index_batch_cache.emplace(batch_size, batched);
        return batched;
    };

    auto get_p_batch_batched = [&](int batch_size) {
        auto it = p_batch_cache.find(batch_size);
        if (it != p_batch_cache.end()) {
            return it->second;
        }
        int64_t nodes = physical.num_nodes;
        auto batch = torch::empty({nodes * batch_size}, torch::TensorOptions().dtype(torch::kInt64));
        auto acc = batch.accessor<std::int64_t, 1>();
        for (int b = 0; b < batch_size; ++b) {
            int64_t start = static_cast<int64_t>(b) * nodes;
            for (int64_t n = 0; n < nodes; ++n) {
                acc[start + n] = b;
            }
        }
        if (torch_device.type() == torch::kCUDA) {
            batch = batch.to(torch_device);
        }
        p_batch_cache.emplace(batch_size, batch);
        return batch;
    };

    if (search_config.use_neural_network) {
        engine.set_evaluate_callback([&](const std::shared_ptr<StateView>& view) {
            auto& domain = *view->domain_state;
            auto build_start = std::chrono::high_resolution_clock::now();
            auto inputs = build_inputs_cached(
                domain,
                physical,
                virtual_net,
                vnr_config,
                *policy,
                edge_index,
                p_batch,
                num_actions,
                vnr_config.allow_rejection,
                reject_idx,
                start_embedding,
                torch_device
            );
            auto build_end = std::chrono::high_resolution_clock::now();
            build_inputs_ms += std::chrono::duration<double, std::milli>(build_end - build_start).count();

            auto eval_start = std::chrono::high_resolution_clock::now();
            EvaluationResult eval = policy->evaluate(inputs);
            auto eval_end = std::chrono::high_resolution_clock::now();
            policy_eval_ms += std::chrono::duration<double, std::milli>(eval_end - eval_start).count();
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

        if (search_config.eval_batch_size > 1 && torch_device.type() == torch::kCUDA) {
            engine.set_batch_evaluate_callback([&](const std::vector<std::shared_ptr<StateView>>& states) {
                auto build_start = std::chrono::high_resolution_clock::now();
                int batch_size = static_cast<int>(states.size());
                auto edge_index_batched = get_edge_index_batched(batch_size);
                auto p_batch_batched = get_p_batch_batched(batch_size);
                auto inputs = build_inputs_batch(
                    states,
                    physical,
                    virtual_net,
                    vnr_config,
                    *policy,
                    edge_index_batched,
                    p_batch_batched,
                    num_actions,
                    vnr_config.allow_rejection,
                    reject_idx,
                    start_embedding,
                    torch_device
                );
                auto build_end = std::chrono::high_resolution_clock::now();
                build_inputs_ms += std::chrono::duration<double, std::milli>(build_end - build_start).count();

                torch::Tensor batched_mask;
                auto mask_it = inputs.find("action_mask");
                if (mask_it != inputs.end()) {
                    batched_mask = mask_it->second;
                }

                auto eval_start = std::chrono::high_resolution_clock::now();
                EvaluationResult eval = policy->evaluate(inputs);
                auto eval_end = std::chrono::high_resolution_clock::now();
                policy_eval_ms += std::chrono::duration<double, std::milli>(eval_end - eval_start).count();

                torch::Tensor logits = eval.policy_logits;
                torch::Tensor value = eval.value;
                if (!use_nn_policy) {
                    logits = torch::zeros({batch_size, num_actions}, torch::TensorOptions().dtype(torch::kFloat32).device(torch_device));
                } else if (logits.defined() && logits.dim() == 1) {
                    logits = logits.unsqueeze(0);
                }
                if (!use_nn_value) {
                    value = torch::zeros({batch_size}, torch::TensorOptions().dtype(torch::kFloat32).device(torch_device));
                } else if (value.defined()) {
                    if (value.dim() == 0) {
                        value = value.unsqueeze(0);
                    } else if (value.dim() > 1 && value.size(-1) == 1) {
                        value = value.squeeze(-1);
                    }
                }

                std::vector<EvaluationResult> results;
                results.reserve(states.size());
                for (int i = 0; i < batch_size; ++i) {
                    EvaluationResult out;
                    out.policy_logits = logits[i];
                    out.value = value[i];
                    if (batched_mask.defined() && batched_mask.dim() == 2 && i < batched_mask.size(0)) {
                        states[i]->action_mask = batched_mask[i].to(torch::kBool);
                    }
                    results.push_back(std::move(out));
                }
                return results;
            });
        }
    }

    std::mt19937 rng;
    if (seed) {
        rng.seed(*seed);
    } else {
        rng.seed(std::random_device{}());
    }

    VNRState current_state = root_state;
    std::vector<ReplayStep> replay_steps;
    replay_steps.reserve(static_cast<std::size_t>(virtual_net.num_nodes));

    for (int step = 0; step < virtual_net.num_nodes; ++step) {
        auto state_view = std::make_shared<StateView>();
        state_view->id = static_cast<std::int64_t>(step + 1);
        state_view->step_index = static_cast<std::int64_t>(current_state.selected_physical_nodes().size());
        state_view->domain_state = std::make_shared<VNRState>(current_state);

        auto mcts_start = std::chrono::high_resolution_clock::now();
        std::optional<unsigned int> step_seed;
        if (seed) {
            step_seed = static_cast<unsigned int>(*seed + static_cast<unsigned int>(step));
        }
        auto search_result = engine.run_search(state_view, step_seed);
        auto mcts_end = std::chrono::high_resolution_clock::now();
        mcts_ms += std::chrono::duration<double, std::milli>(mcts_end - mcts_start).count();

        auto post_start = std::chrono::high_resolution_clock::now();
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

        float step_temperature = temperature_for_step(
            temperature,
            step,
            temperature_move_threshold,
            temperature_after_threshold
        );
        int action = select_action(candidates, visit_counts_vec, step_temperature, rng);
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
        if (do_replay) {
            Observation obs = build_observation(
                current_state,
                physical,
                virtual_net,
                vnr_config,
                policy.get(),
                edge_index_cpu,
                start_embedding_cpu,
                num_actions,
                vnr_config.allow_rejection,
                reject_idx
            );

            ReplayStep step;
            step.observation = std::move(obs);
            step.pi = build_policy_from_visits(
                num_actions,
                candidates,
                visit_counts_vec,
                replay_policy_temperature
            );
            step.v_root = result.values.back();
            step.a_taken = action;
            step.mask.reserve(static_cast<std::size_t>(num_actions));
            auto mask_cpu = step.observation.action_mask.to(torch::kCPU).contiguous();
            if (mask_cpu.numel() > 0) {
                auto acc = mask_cpu.accessor<bool, 2>();
                for (int i = 0; i < num_actions; ++i) {
                    step.mask.push_back(acc[0][i]);
                }
            } else {
                step.mask.assign(static_cast<std::size_t>(num_actions), false);
            }
            replay_steps.push_back(std::move(step));
        }
        result.metrics.total_simulations += static_cast<int>(search_result.visit_counts.sum().item<float>());

        VNRState::PlacementInfo place_info;
        current_state = current_state.create_child_with_info(action, &place_info);
        if (current_state.last_physical_node() == -1) {
            result.place_result = false;
            if (!place_info.feasible) {
                result.place_info = place_info.offsets;
                result.place_v_node_id = place_info.v_node_id;
                result.place_p_node_id = place_info.p_node_id;
            }
            auto post_end = std::chrono::high_resolution_clock::now();
            postprocess_ms += std::chrono::duration<double, std::milli>(post_end - post_start).count();
            break;
        }
        auto post_end = std::chrono::high_resolution_clock::now();
        postprocess_ms += std::chrono::duration<double, std::milli>(post_end - post_start).count();
    }

    result.metrics.steps = static_cast<int>(result.actions.size());
    result.node_slots = current_state.node_slots();
    if (result.place_result && !result.rejected) {
        bool placement_complete = static_cast<int>(result.node_slots.size()) == virtual_net.num_nodes;
        if (placement_complete) {
            for (int slot : result.node_slots) {
                if (slot < 0) {
                    placement_complete = false;
                    break;
                }
            }
        }
        if (!placement_complete) {
            result.place_result = false;
            result.place_info["incomplete_placement"] = 1.0;
            result.place_info["node_slots_size"] = static_cast<double>(result.node_slots.size());
        }
    }
    if (!result.place_result || result.rejected) {
        result.route_result = false;
    } else {
        auto link_map = current_state.link_mapping(result.node_slots);
        result.route_result = link_map.success;
        result.link_mapping = std::move(link_map.records);
        if (result.route_result) {
            double total_node_demand = sum_node_demand(virtual_net, vnr_config.node_resource_names);
            double total_link_demand = sum_link_demand(virtual_net, vnr_config.link_resource_names);
            double total_revenue = total_node_demand + total_link_demand;
            double total_cost = total_node_demand + link_map.total_link_cost;
            result.total_revenue = static_cast<float>(total_revenue);
            result.total_cost = static_cast<float>(total_cost);
            result.final_reward = static_cast<float>(1000.0 + total_revenue - total_cost);
            result.value_target = normalize_value_target(result.final_reward, search_config);
        } else {
            result.final_reward = -1000.0f;
            result.value_target = normalize_value_target(result.final_reward, search_config);
        }
    }
    if (!result.place_result || result.rejected) {
        result.final_reward = -1000.0f;
        result.value_target = normalize_value_target(result.final_reward, search_config);
    }
    result.metrics.build_inputs_ms = build_inputs_ms;
    result.metrics.policy_eval_ms = policy_eval_ms;
    result.metrics.mcts_ms = mcts_ms;
    result.metrics.postprocess_ms = postprocess_ms;

    auto end_ts = std::chrono::high_resolution_clock::now();
    result.metrics.total_time_ms = std::chrono::duration<double, std::milli>(end_ts - start_ts).count();

    if (do_replay) {
        ReplayEpisode episode;
        episode.static_env = build_static_environment(physical, virtual_net);
        episode.trajectory = std::move(replay_steps);
        episode.final_reward = static_cast<double>(result.final_reward);
        episode.accepted = bool(result.place_result && result.route_result && !result.rejected);
        episode.value_target = static_cast<double>(result.value_target);
        if (episode.accepted) {
            episode.total_cost = static_cast<double>(result.total_cost);
            episode.total_revenue = static_cast<double>(result.total_revenue);
        }
        episode.policy_path = policy_meta_path;
        if (!policy_meta_path.empty()) {
            try {
                auto ftime = std::filesystem::last_write_time(policy_meta_path);
                auto sctp = std::chrono::time_point_cast<std::chrono::system_clock::duration>(
                    ftime - decltype(ftime)::clock::now() + std::chrono::system_clock::now());
                episode.policy_mtime = std::chrono::duration<double>(sctp.time_since_epoch()).count();
            } catch (...) {
            }
        }
        auto replay_res = write_replay_episode(episode, replay_dir, max_buffer_size);
        result.replay_written = replay_res.written;
        result.replay_path = replay_res.path;
        result.replay_error = replay_res.error;
    }

    return result;
}

}  // namespace azsfc
