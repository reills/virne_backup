#include "shortest_path.hpp"

#include "vnr_state.hpp"

#include <algorithm>
#include <limits>
#include <queue>
#include <unordered_map>

namespace azsfc {

namespace {
inline bool has_capacity(const VNRState& state,
                         int edge_id,
                         const std::unordered_map<std::string, double>& link_demands) {
    for (const auto& [attr, demand] : link_demands) {
        if (demand <= 0.0) {
            continue;
        }
        double available = state.get_available_link_resource(edge_id, attr);
        if (available + 1e-8 < demand) {
            return false;
        }
    }
    return true;
}
}  // namespace

std::vector<ShortestPathFinder::Path> ShortestPathFinder::find_paths(
    const Network& net,
    const VNRState& state,
    int source,
    int target,
    int k,
    const std::unordered_map<std::string, double>& link_demands,
    const std::string& method) const {

    std::vector<Path> results;
    if (source < 0 || target < 0 || source >= net.num_nodes || target >= net.num_nodes || k <= 0) {
        return results;
    }

    if (source == target) {
        Path trivial;
        trivial.nodes = {source};
        trivial.cost = 0.0;
        results.push_back(std::move(trivial));
        return results;
    }

    const std::string normalised_method = method.empty() ? "bfs_shortest" : method;
    auto ensure_limit = [](int value, int fallback) {
        return value <= 0 ? fallback : value;
    };

    const bool length_limited = (normalised_method == "k_shortest_length");
    const bool collect_all_shortest = (normalised_method == "all_shortest");
    const bool single_path_requested =
        normalised_method == "bfs_shortest" ||
        normalised_method == "first_shortest" ||
        normalised_method == "available_shortest";

    const int max_length = length_limited ? ensure_limit(k, 1) : std::numeric_limits<int>::max();
    int max_results =
        collect_all_shortest
            ? std::numeric_limits<int>::max()
            : (single_path_requested ? 1 : ensure_limit(k, 1));
    if (length_limited) {
        max_results = std::numeric_limits<int>::max();
    }

    auto bfs_single_path = [&](bool enforce_capacity) -> std::vector<Path> {
        std::vector<Path> bfs_results;
        std::queue<std::vector<int>> frontier;
        frontier.push({source});

        std::unordered_map<int, int> best_depth;
        best_depth[source] = 0;

        while (!frontier.empty()) {
            auto path = std::move(frontier.front());
            frontier.pop();

            int current = path.back();
            if (current == target) {
                Path out;
                out.nodes = path;
                out.cost = static_cast<double>(path.size() - 1);
                bfs_results.push_back(std::move(out));
                break;
            }

            int next_depth = static_cast<int>(path.size());
            const auto& neighbors = net.adjacency[current];
            for (const auto& [neighbor, edge_id] : neighbors) {
                if (std::find(path.begin(), path.end(), neighbor) != path.end()) {
                    continue;
                }
                if (enforce_capacity && !has_capacity(state, edge_id, link_demands)) {
                    continue;
                }
                auto extended = path;
                extended.push_back(neighbor);
                auto it = best_depth.find(neighbor);
                if (it == best_depth.end() || next_depth <= it->second) {
                    best_depth[neighbor] = next_depth;
                    frontier.push(std::move(extended));
                }
            }
        }
        return bfs_results;
    };

    if (normalised_method == "bfs_shortest") {
        return bfs_single_path(/*enforce_capacity=*/true);
    }
    if (normalised_method == "available_shortest") {
        return bfs_single_path(/*enforce_capacity=*/true);
    }

    struct Candidate {
        std::vector<int> nodes;
        double cost{0.0};
    };
    struct CandidateCompare {
        bool operator()(const Candidate& a, const Candidate& b) const noexcept {
            if (a.cost == b.cost) {
                return a.nodes.size() > b.nodes.size();
            }
            return a.cost > b.cost;
        }
    };

    std::priority_queue<Candidate, std::vector<Candidate>, CandidateCompare> frontier;
    frontier.push({{source}, 0.0});

    std::unordered_map<int, double> best_cost_to_node;
    best_cost_to_node[source] = 0.0;

    double best_goal_cost = std::numeric_limits<double>::infinity();

    while (!frontier.empty()) {
        Candidate current = std::move(frontier.top());
        frontier.pop();

        int current_node = current.nodes.back();
        if (collect_all_shortest && current.cost > best_goal_cost + 1e-6) {
            break;
        }

        if (current_node == target) {
            if (static_cast<int>(current.nodes.size()) > max_length) {
                continue;
            }
            if (best_goal_cost == std::numeric_limits<double>::infinity()) {
                best_goal_cost = current.cost;
            }
            results.push_back({current.nodes, current.cost});
            if (!collect_all_shortest && static_cast<int>(results.size()) >= max_results) {
                break;
            }
            if (collect_all_shortest) {
                continue;
            }
            continue;
        }

        if (static_cast<int>(current.nodes.size()) >= max_length) {
            continue;
        }
        if (static_cast<int>(current.nodes.size()) > net.num_nodes + 1) {
            continue;
        }

        const auto& neighbors = net.adjacency[current_node];
        for (const auto& [neighbor, edge_id] : neighbors) {
            if (std::find(current.nodes.begin(), current.nodes.end(), neighbor) != current.nodes.end()) {
                continue;
            }
            if (!has_capacity(state, edge_id, link_demands)) {
                continue;
            }
            Candidate expanded;
            expanded.nodes = current.nodes;
            expanded.nodes.push_back(neighbor);
            expanded.cost = current.cost + 1.0;

            auto it = best_cost_to_node.find(neighbor);
            if (it == best_cost_to_node.end() || expanded.cost <= it->second + 1e-6) {
                best_cost_to_node[neighbor] = expanded.cost;
                frontier.push(std::move(expanded));
            }
        }
    }

    if (results.empty() && (normalised_method == "available_k_shortest" || normalised_method == "available_shortest")) {
        return results;
    }

    if (results.size() > static_cast<std::size_t>(max_results) && !collect_all_shortest) {
        results.resize(static_cast<std::size_t>(max_results));
    }

    return results;
}

}  // namespace azsfc
