#pragma once

#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

namespace azsfc {

struct PairHash {
    std::size_t operator()(const std::pair<int, int>& key) const noexcept {
        std::size_t h1 = std::hash<int>{}(key.first);
        std::size_t h2 = std::hash<int>{}(key.second);
        return h1 ^ (h2 << 1);
    }
};

/**
 * Lightweight adjacency representation used by the AlphaZero C++ core.
 *
 * The Network structure models either the physical substrate or the virtual
 * request graph. It stores per-node/edge attributes required for resource
 * feasibility checks during tree search. The structure is intentionally
 * simple: attributes are kept in unordered_map containers keyed by the string
 * attribute names used in the Python side. This keeps the serialization logic
 * straightforward and agnostic of the domain specifics while still allowing
 * O(1) lookups from the C++ search code.
 */
struct Network {
    int num_nodes{0};
    int num_edges{0};
    bool directed{false};

    // Node adjacency: node -> [(neighbor, edge_id)]
    std::vector<std::vector<std::pair<int, int>>> adjacency;

    // Node attributes: node_id -> {attr_name -> value}
    std::vector<std::unordered_map<std::string, double>> node_attrs;

    // Edge attribute table aligned with `edges`
    std::vector<std::unordered_map<std::string, double>> edge_attrs;

    // Edge list: edge_id -> (u, v). For undirected networks both directions
    // map to the same edge id via `edge_index`.
    std::vector<std::pair<int, int>> edges;

    // Quick lookup for edge ids
    std::unordered_map<std::pair<int, int>, int, PairHash> edge_index;

    void set_num_nodes(int n);
    void set_edges(const std::vector<std::pair<int, int>>& edge_list, bool is_directed = false);
    void set_node_attrs(const std::vector<std::unordered_map<std::string, double>>& attrs);
    void set_edge_attrs(const std::vector<std::unordered_map<std::string, double>>& attrs);
};

}  // namespace azsfc

