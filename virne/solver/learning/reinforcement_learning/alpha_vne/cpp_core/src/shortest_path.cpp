#include "shortest_path.hpp"

#include <algorithm>
#include <cmath>
#include <cstdint>
#include <deque>
#include <limits>
#include <queue>
#include <unordered_set>
#include <utility>
#include <vector>

namespace azsfc {

namespace {
constexpr double kEpsilon = 1e-8;

inline bool has_capacity(const ShortestPathFinder::LinkCapacityFn& capacity_fn,
                         int edge_id,
                         const std::unordered_map<std::string, double>& link_demands) {
    if (!capacity_fn) {
        return true;
    }
    for (const auto& [attr, demand] : link_demands) {
        if (demand <= 0.0) {
            continue;
        }
        double available = capacity_fn(edge_id, attr);
        if (available + kEpsilon < demand) {
            return false;
        }
    }
    return true;
}

inline std::uint64_t edge_key(int u, int v) {
    return (static_cast<std::uint64_t>(static_cast<std::uint32_t>(u)) << 32U)
        | static_cast<std::uint64_t>(static_cast<std::uint32_t>(v));
}

inline bool is_edge_ignored(int u,
                            int v,
                            bool directed,
                            const std::unordered_set<std::uint64_t>& ignore_edges) {
    if (ignore_edges.empty()) {
        return false;
    }
    if (ignore_edges.find(edge_key(u, v)) != ignore_edges.end()) {
        return true;
    }
    if (!directed) {
        if (ignore_edges.find(edge_key(v, u)) != ignore_edges.end()) {
            return true;
        }
    }
    return false;
}

struct VectorHash {
    std::size_t operator()(const std::vector<int>& path) const noexcept {
        std::size_t seed = 0;
        for (int v : path) {
            seed ^= std::hash<int>{}(v) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
        }
        return seed;
    }
};

struct PathBufferEntry {
    double cost{0.0};
    std::size_t order{0};
    std::vector<int> path;
};

struct PathBufferCompare {
    bool operator()(const PathBufferEntry& a, const PathBufferEntry& b) const noexcept {
        if (a.cost == b.cost) {
            return a.order > b.order;
        }
        return a.cost > b.cost;
    }
};

class PathBuffer {
public:
    bool empty() const noexcept { return heap_.empty(); }

    void push(double cost, const std::vector<int>& path) {
        if (seen_.find(path) != seen_.end()) {
            return;
        }
        seen_.insert(path);
        heap_.push(PathBufferEntry{cost, counter_++, path});
    }

    std::vector<int> pop() {
        auto entry = heap_.top();
        heap_.pop();
        seen_.erase(entry.path);
        return entry.path;
    }

private:
    std::unordered_set<std::vector<int>, VectorHash> seen_;
    std::priority_queue<PathBufferEntry, std::vector<PathBufferEntry>, PathBufferCompare> heap_;
    std::size_t counter_{0};
};

bool bidirectional_shortest_path(const Network& net,
                                 int source,
                                 int target,
                                 const std::vector<char>& ignore_nodes,
                                 const std::unordered_set<std::uint64_t>& ignore_edges,
                                 std::vector<int>& out_path) {
    if (source == target) {
        out_path = {source};
        return true;
    }
    if (source < 0 || target < 0 || source >= net.num_nodes || target >= net.num_nodes) {
        return false;
    }
    if (!ignore_nodes.empty()) {
        if (ignore_nodes[static_cast<std::size_t>(source)] || ignore_nodes[static_cast<std::size_t>(target)]) {
            return false;
        }
    }

    const int kUnvisited = std::numeric_limits<int>::min();
    std::vector<int> pred(static_cast<std::size_t>(net.num_nodes), kUnvisited);
    std::vector<int> succ(static_cast<std::size_t>(net.num_nodes), kUnvisited);
    pred[static_cast<std::size_t>(source)] = -1;
    succ[static_cast<std::size_t>(target)] = -1;

    std::vector<int> forward_fringe{source};
    std::vector<int> reverse_fringe{target};

    std::vector<std::vector<int>> pred_adj;
    if (net.directed) {
        pred_adj.assign(static_cast<std::size_t>(net.num_nodes), {});
        for (const auto& edge : net.edges) {
            int u = edge.first;
            int v = edge.second;
            if (u < 0 || v < 0 || u >= net.num_nodes || v >= net.num_nodes) {
                continue;
            }
            pred_adj[static_cast<std::size_t>(v)].push_back(u);
        }
    }

    while (!forward_fringe.empty() && !reverse_fringe.empty()) {
        if (forward_fringe.size() <= reverse_fringe.size()) {
            std::vector<int> this_level = std::move(forward_fringe);
            forward_fringe.clear();
            for (int v : this_level) {
                const auto& neighbors = net.adjacency[v];
                for (const auto& [neighbor, edge_id] : neighbors) {
                    (void)edge_id;
                    if (!ignore_nodes.empty() && ignore_nodes[static_cast<std::size_t>(neighbor)]) {
                        continue;
                    }
                    if (is_edge_ignored(v, neighbor, net.directed, ignore_edges)) {
                        continue;
                    }
                    if (pred[static_cast<std::size_t>(neighbor)] == kUnvisited) {
                        pred[static_cast<std::size_t>(neighbor)] = v;
                        forward_fringe.push_back(neighbor);
                    }
                    if (succ[static_cast<std::size_t>(neighbor)] != kUnvisited) {
                        int meet = neighbor;
                        std::vector<int> path;
                        int w = meet;
                        while (w != -1) {
                            path.push_back(w);
                            w = succ[static_cast<std::size_t>(w)];
                        }
                        w = pred[static_cast<std::size_t>(path.front())];
                        while (w != -1) {
                            path.insert(path.begin(), w);
                            w = pred[static_cast<std::size_t>(w)];
                        }
                        out_path = std::move(path);
                        return true;
                    }
                }
            }
        } else {
            std::vector<int> this_level = std::move(reverse_fringe);
            reverse_fringe.clear();
            for (int v : this_level) {
                if (net.directed) {
                    for (int neighbor : pred_adj[static_cast<std::size_t>(v)]) {
                        if (!ignore_nodes.empty() && ignore_nodes[static_cast<std::size_t>(neighbor)]) {
                            continue;
                        }
                        if (is_edge_ignored(neighbor, v, net.directed, ignore_edges)) {
                            continue;
                        }
                        if (succ[static_cast<std::size_t>(neighbor)] == kUnvisited) {
                            succ[static_cast<std::size_t>(neighbor)] = v;
                            reverse_fringe.push_back(neighbor);
                        }
                        if (pred[static_cast<std::size_t>(neighbor)] != kUnvisited) {
                            int meet = neighbor;
                            std::vector<int> path;
                            int w = meet;
                            while (w != -1) {
                                path.push_back(w);
                                w = succ[static_cast<std::size_t>(w)];
                            }
                            w = pred[static_cast<std::size_t>(path.front())];
                            while (w != -1) {
                                path.insert(path.begin(), w);
                                w = pred[static_cast<std::size_t>(w)];
                            }
                            out_path = std::move(path);
                            return true;
                        }
                    }
                } else {
                    const auto& neighbors = net.adjacency[v];
                    for (const auto& [neighbor, edge_id] : neighbors) {
                        (void)edge_id;
                        if (!ignore_nodes.empty() && ignore_nodes[static_cast<std::size_t>(neighbor)]) {
                            continue;
                        }
                        if (is_edge_ignored(neighbor, v, net.directed, ignore_edges)) {
                            continue;
                        }
                        if (succ[static_cast<std::size_t>(neighbor)] == kUnvisited) {
                            succ[static_cast<std::size_t>(neighbor)] = v;
                            reverse_fringe.push_back(neighbor);
                        }
                        if (pred[static_cast<std::size_t>(neighbor)] != kUnvisited) {
                            int meet = neighbor;
                            std::vector<int> path;
                            int w = meet;
                            while (w != -1) {
                                path.push_back(w);
                                w = succ[static_cast<std::size_t>(w)];
                            }
                            w = pred[static_cast<std::size_t>(path.front())];
                            while (w != -1) {
                                path.insert(path.begin(), w);
                                w = pred[static_cast<std::size_t>(w)];
                            }
                            out_path = std::move(path);
                            return true;
                        }
                    }
                }
            }
        }
    }

    return false;
}

bool dijkstra_shortest_path(const Network& net,
                            int source,
                            int target,
                            const std::vector<char>& ignore_nodes,
                            const std::unordered_set<std::uint64_t>& ignore_edges,
                            bool enforce_capacity,
                            const ShortestPathFinder::LinkCapacityFn& capacity_fn,
                            const std::unordered_map<std::string, double>& link_demands,
                            std::vector<int>& out_path) {
    if (source < 0 || target < 0 || source >= net.num_nodes || target >= net.num_nodes) {
        return false;
    }
    if (!ignore_nodes.empty()) {
        if (ignore_nodes[static_cast<std::size_t>(source)] || ignore_nodes[static_cast<std::size_t>(target)]) {
            return false;
        }
    }
    if (source == target) {
        out_path = {source};
        return true;
    }

    const double inf = std::numeric_limits<double>::infinity();
    std::vector<double> dist(static_cast<std::size_t>(net.num_nodes), inf);
    std::vector<int> parent(static_cast<std::size_t>(net.num_nodes), -1);

    struct NodeEntry {
        double cost{0.0};
        std::size_t order{0};
        int node{-1};
    };
    struct NodeCompare {
        bool operator()(const NodeEntry& a, const NodeEntry& b) const noexcept {
            if (a.cost == b.cost) {
                return a.order > b.order;
            }
            return a.cost > b.cost;
        }
    };

    std::priority_queue<NodeEntry, std::vector<NodeEntry>, NodeCompare> frontier;
    std::size_t counter = 0;
    dist[static_cast<std::size_t>(source)] = 0.0;
    frontier.push(NodeEntry{0.0, counter++, source});

    while (!frontier.empty()) {
        NodeEntry entry = frontier.top();
        frontier.pop();

        if (entry.cost > dist[static_cast<std::size_t>(entry.node)] + kEpsilon) {
            continue;
        }
        if (entry.node == target) {
            break;
        }

        const auto& neighbors = net.adjacency[entry.node];
        for (const auto& [neighbor, edge_id] : neighbors) {
            if (!ignore_nodes.empty() && ignore_nodes[static_cast<std::size_t>(neighbor)]) {
                continue;
            }
            if (is_edge_ignored(entry.node, neighbor, net.directed, ignore_edges)) {
                continue;
            }
            if (enforce_capacity && !has_capacity(capacity_fn, edge_id, link_demands)) {
                continue;
            }
            double next_cost = entry.cost + 1.0;
            if (next_cost + kEpsilon < dist[static_cast<std::size_t>(neighbor)]) {
                dist[static_cast<std::size_t>(neighbor)] = next_cost;
                parent[static_cast<std::size_t>(neighbor)] = entry.node;
                frontier.push(NodeEntry{next_cost, counter++, neighbor});
            }
        }
    }

    if (!std::isfinite(dist[static_cast<std::size_t>(target)])) {
        return false;
    }

    std::vector<int> path;
    for (int cursor = target; cursor != -1; cursor = parent[static_cast<std::size_t>(cursor)]) {
        path.push_back(cursor);
    }
    std::reverse(path.begin(), path.end());
    out_path = std::move(path);
    return true;
}

std::vector<std::vector<int>> build_all_shortest_paths(const Network& net, int source, int target) {
    std::vector<std::vector<int>> pred(static_cast<std::size_t>(net.num_nodes));
    std::vector<int> seen(static_cast<std::size_t>(net.num_nodes), -1);

    std::vector<int> nextlevel{source};
    seen[static_cast<std::size_t>(source)] = 0;

    int level = 0;
    while (!nextlevel.empty()) {
        ++level;
        std::vector<int> thislevel = std::move(nextlevel);
        nextlevel.clear();
        for (int v : thislevel) {
            const auto& neighbors = net.adjacency[v];
            for (const auto& [neighbor, edge_id] : neighbors) {
                (void)edge_id;
                if (seen[static_cast<std::size_t>(neighbor)] == -1) {
                    pred[static_cast<std::size_t>(neighbor)].push_back(v);
                    seen[static_cast<std::size_t>(neighbor)] = level;
                    nextlevel.push_back(neighbor);
                } else if (seen[static_cast<std::size_t>(neighbor)] == level) {
                    pred[static_cast<std::size_t>(neighbor)].push_back(v);
                }
            }
        }
    }

    std::vector<std::vector<int>> paths;
    if (target < 0 || target >= net.num_nodes) {
        return paths;
    }
    if (target != source && pred[static_cast<std::size_t>(target)].empty()) {
        return paths;
    }

    std::vector<std::pair<int, std::size_t>> stack;
    stack.push_back({target, 0});
    std::vector<char> in_stack(static_cast<std::size_t>(net.num_nodes), 0);
    in_stack[static_cast<std::size_t>(target)] = 1;
    int top = 0;
    while (top >= 0) {
        int node = stack[static_cast<std::size_t>(top)].first;
        std::size_t idx = stack[static_cast<std::size_t>(top)].second;
        if (node == source) {
            std::vector<int> path;
            path.reserve(static_cast<std::size_t>(top) + 1);
            for (int i = top; i >= 0; --i) {
                path.push_back(stack[static_cast<std::size_t>(i)].first);
            }
            std::reverse(path.begin(), path.end());
            paths.push_back(std::move(path));
        }
        if (idx < pred[static_cast<std::size_t>(node)].size()) {
            stack[static_cast<std::size_t>(top)].second = idx + 1;
            int next = pred[static_cast<std::size_t>(node)][idx];
            if (in_stack[static_cast<std::size_t>(next)]) {
                continue;
            }
            in_stack[static_cast<std::size_t>(next)] = 1;
            ++top;
            if (static_cast<std::size_t>(top) == stack.size()) {
                stack.push_back({next, 0});
            } else {
                stack[static_cast<std::size_t>(top)] = {next, 0};
            }
        } else {
            in_stack[static_cast<std::size_t>(node)] = 0;
            --top;
        }
    }

    return paths;
}

}  // namespace

std::vector<ShortestPathFinder::Path> ShortestPathFinder::find_paths(
    const Network& net,
    int source,
    int target,
    int k,
    const std::unordered_map<std::string, double>& link_demands,
    const std::string& method,
    const LinkCapacityFn& capacity_fn) const {

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

    if (normalised_method == "bfs_shortest") {
        std::deque<std::pair<int, std::vector<int>>> queue;
        std::vector<char> visited(static_cast<std::size_t>(net.num_nodes), 0);
        queue.emplace_back(source, std::vector<int>{});
        bool found = false;
        std::vector<int> shortest_path;
        while (!queue.empty() && !found) {
            auto current = queue.front();
            queue.pop_front();
            int node = current.first;
            std::vector<int> path = std::move(current.second);
            path.push_back(node);
            const auto& neighbors = net.adjacency[node];
            for (const auto& [neighbor, edge_id] : neighbors) {
                if (!has_capacity(capacity_fn, edge_id, link_demands)) {
                    continue;
                }
                std::vector<int> next_path = path;
                if (neighbor == target) {
                    next_path.push_back(neighbor);
                    shortest_path = std::move(next_path);
                    found = true;
                    break;
                }
                if (!visited[static_cast<std::size_t>(neighbor)]) {
                    visited[static_cast<std::size_t>(neighbor)] = 1;
                    queue.emplace_back(neighbor, std::move(next_path));
                }
            }
        }
        if (!found) {
            return results;
        }
        Path out;
        out.nodes = std::move(shortest_path);
        out.cost = static_cast<double>(out.nodes.size() - 1);
        results.push_back(std::move(out));
        return results;
    }

    if (normalised_method == "available_shortest") {
        std::vector<char> ignore_nodes;
        std::unordered_set<std::uint64_t> ignore_edges;
        std::vector<int> path;
        bool ok = dijkstra_shortest_path(
            net,
            source,
            target,
            ignore_nodes,
            ignore_edges,
            true,
            capacity_fn,
            link_demands,
            path
        );
        if (!ok) {
            return results;
        }
        Path out;
        out.nodes = std::move(path);
        out.cost = static_cast<double>(out.nodes.size() - 1);
        results.push_back(std::move(out));
        return results;
    }

    if (normalised_method == "first_shortest") {
        std::vector<char> ignore_nodes;
        std::unordered_set<std::uint64_t> ignore_edges;
        std::vector<int> path;
        bool ok = dijkstra_shortest_path(
            net,
            source,
            target,
            ignore_nodes,
            ignore_edges,
            false,
            capacity_fn,
            link_demands,
            path
        );
        if (!ok) {
            return results;
        }
        Path out;
        out.nodes = std::move(path);
        out.cost = static_cast<double>(out.nodes.size() - 1);
        results.push_back(std::move(out));
        return results;
    }

    if (normalised_method == "all_shortest") {
        auto paths = build_all_shortest_paths(net, source, target);
        for (auto& nodes : paths) {
            Path out;
            out.cost = static_cast<double>(nodes.size() - 1);
            out.nodes = std::move(nodes);
            results.push_back(std::move(out));
        }
        return results;
    }

    const bool length_limited = (normalised_method == "k_shortest_length");
    const int max_length = length_limited ? std::max(1, k) : std::numeric_limits<int>::max();
    const int max_results = std::max(1, k);

    PathBuffer buffer;
    std::vector<std::vector<int>> listA;
    std::vector<int> prev_path;
    bool has_prev = false;

    while (true) {
        if (!has_prev) {
            std::vector<int> path;
            std::vector<char> ignore_nodes;
            std::unordered_set<std::uint64_t> ignore_edges;
            if (!bidirectional_shortest_path(net, source, target, ignore_nodes, ignore_edges, path)) {
                break;
            }
            buffer.push(static_cast<double>(path.size()), path);
        } else {
            std::vector<char> ignore_nodes(static_cast<std::size_t>(net.num_nodes), 0);
            std::unordered_set<std::uint64_t> ignore_edges;
            for (std::size_t i = 1; i < prev_path.size(); ++i) {
                std::vector<int> root(prev_path.begin(), prev_path.begin() + static_cast<std::ptrdiff_t>(i));
                double root_length = static_cast<double>(root.size());
                for (const auto& path : listA) {
                    if (path.size() >= i && std::equal(path.begin(), path.begin() + static_cast<std::ptrdiff_t>(i), root.begin())) {
                        ignore_edges.insert(edge_key(path[i - 1], path[i]));
                    }
                }
                std::vector<int> spur;
                if (bidirectional_shortest_path(net, root.back(), target, ignore_nodes, ignore_edges, spur)) {
                    std::vector<int> total_path = root;
                    total_path.pop_back();
                    total_path.insert(total_path.end(), spur.begin(), spur.end());
                    buffer.push(root_length + static_cast<double>(spur.size()), total_path);
                }
                ignore_nodes[static_cast<std::size_t>(root.back())] = 1;
            }
        }

        if (buffer.empty()) {
            break;
        }

        std::vector<int> path = buffer.pop();
        has_prev = true;
        prev_path = path;
        listA.push_back(path);

        if (length_limited && static_cast<int>(path.size()) > max_length) {
            break;
        }

        Path out;
        out.cost = static_cast<double>(path.size() - 1);
        out.nodes = std::move(path);
        results.push_back(std::move(out));

        if (!length_limited && static_cast<int>(results.size()) >= max_results) {
            break;
        }
    }

    return results;
}

}  // namespace azsfc
