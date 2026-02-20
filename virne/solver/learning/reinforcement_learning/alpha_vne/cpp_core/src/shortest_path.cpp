#include "shortest_path.hpp"

#include "vnr_state.hpp"

#include <algorithm>
#include <cstdint>
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

inline bool bit_is_set(const std::vector<std::uint64_t>& bits, int node) {
    const std::size_t word = static_cast<std::size_t>(node) >> 6U;
    const std::size_t bit = static_cast<std::size_t>(node) & 63U;
    return (bits[word] & (std::uint64_t{1} << bit)) != 0U;
}

inline void set_bit(std::vector<std::uint64_t>& bits, int node) {
    const std::size_t word = static_cast<std::size_t>(node) >> 6U;
    const std::size_t bit = static_cast<std::size_t>(node) & 63U;
    bits[word] |= (std::uint64_t{1} << bit);
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
        std::queue<int> frontier;
        std::vector<int> parent(static_cast<std::size_t>(net.num_nodes), -1);
        std::vector<char> visited(static_cast<std::size_t>(net.num_nodes), 0);

        frontier.push(source);
        visited[static_cast<std::size_t>(source)] = 1;

        while (!frontier.empty()) {
            int current = frontier.front();
            frontier.pop();
            if (current == target) {
                break;
            }

            const auto& neighbors = net.adjacency[current];
            for (const auto& [neighbor, edge_id] : neighbors) {
                if (visited[static_cast<std::size_t>(neighbor)]) {
                    continue;
                }
                if (enforce_capacity && !has_capacity(state, edge_id, link_demands)) {
                    continue;
                }

                visited[static_cast<std::size_t>(neighbor)] = 1;
                parent[static_cast<std::size_t>(neighbor)] = current;
                frontier.push(neighbor);
            }
        }

        if (!visited[static_cast<std::size_t>(target)]) {
            return bfs_results;
        }

        std::vector<int> nodes;
        for (int cursor = target; cursor != -1; cursor = parent[static_cast<std::size_t>(cursor)]) {
            nodes.push_back(cursor);
        }
        std::reverse(nodes.begin(), nodes.end());

        Path out;
        out.cost = static_cast<double>(nodes.size() - 1);
        out.nodes = std::move(nodes);
        bfs_results.push_back(std::move(out));
        return bfs_results;
    };

    if (normalised_method == "bfs_shortest" ||
        normalised_method == "first_shortest" ||
        normalised_method == "available_shortest") {
        return bfs_single_path(/*enforce_capacity=*/true);
    }

    struct Candidate {
        int node{-1};
        int parent_index{-1};
        int depth{0};
        double cost{0.0};
        std::vector<std::uint64_t> visited_bits;
    };
    struct FrontierEntry {
        double cost{0.0};
        int depth{0};
        int candidate_index{-1};
    };
    struct FrontierCompare {
        bool operator()(const FrontierEntry& a, const FrontierEntry& b) const noexcept {
            if (a.cost == b.cost) {
                return a.depth > b.depth;
            }
            return a.cost > b.cost;
        }
    };

    const int visited_words = std::max(1, (net.num_nodes + 63) / 64);
    std::vector<Candidate> arena;
    arena.reserve(64);

    Candidate root;
    root.node = source;
    root.parent_index = -1;
    root.depth = 1;
    root.cost = 0.0;
    root.visited_bits.assign(static_cast<std::size_t>(visited_words), 0U);
    set_bit(root.visited_bits, source);
    arena.push_back(std::move(root));

    std::priority_queue<FrontierEntry, std::vector<FrontierEntry>, FrontierCompare> frontier;
    frontier.push({0.0, 1, 0});

    std::unordered_map<int, double> best_cost_to_node;
    best_cost_to_node[source] = 0.0;

    double best_goal_cost = std::numeric_limits<double>::infinity();

    while (!frontier.empty()) {
        FrontierEntry current_entry = frontier.top();
        frontier.pop();

        const int current_index = current_entry.candidate_index;
        const int current_node = arena[current_index].node;
        const int current_depth = arena[current_index].depth;
        const double current_cost = arena[current_index].cost;

        if (collect_all_shortest && current_cost > best_goal_cost + 1e-6) {
            break;
        }

        if (current_node == target) {
            if (current_depth > max_length) {
                continue;
            }
            if (best_goal_cost == std::numeric_limits<double>::infinity()) {
                best_goal_cost = current_cost;
            }

            std::vector<int> nodes;
            nodes.reserve(static_cast<std::size_t>(current_depth));
            for (int cursor = current_index; cursor != -1; cursor = arena[cursor].parent_index) {
                nodes.push_back(arena[cursor].node);
            }
            std::reverse(nodes.begin(), nodes.end());

            results.push_back({std::move(nodes), current_cost});
            if (!collect_all_shortest && static_cast<int>(results.size()) >= max_results) {
                break;
            }
            if (collect_all_shortest) {
                continue;
            }
            continue;
        }

        if (current_depth >= max_length) {
            continue;
        }
        if (current_depth > net.num_nodes + 1) {
            continue;
        }

        const auto& neighbors = net.adjacency[current_node];
        for (const auto& [neighbor, edge_id] : neighbors) {
            const auto& current_visited = arena[current_index].visited_bits;
            if (bit_is_set(current_visited, neighbor)) {
                continue;
            }
            if (!has_capacity(state, edge_id, link_demands)) {
                continue;
            }

            Candidate expanded;
            expanded.node = neighbor;
            expanded.parent_index = current_index;
            expanded.depth = current_depth + 1;
            expanded.cost = current_cost + 1.0;
            expanded.visited_bits = current_visited;
            set_bit(expanded.visited_bits, neighbor);

            auto it = best_cost_to_node.find(neighbor);
            if (it == best_cost_to_node.end() || expanded.cost <= it->second + 1e-6) {
                best_cost_to_node[neighbor] = expanded.cost;
                int expanded_index = static_cast<int>(arena.size());
                arena.push_back(std::move(expanded));
                frontier.push({arena[expanded_index].cost, arena[expanded_index].depth, expanded_index});
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
