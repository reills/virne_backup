#include "network.hpp"

#include <stdexcept>

namespace azsfc {

void Network::set_num_nodes(int n) {
    if (n < 0) {
        throw std::invalid_argument("Network::set_num_nodes expects non-negative node count.");
    }
    num_nodes = n;
    adjacency.assign(num_nodes, {});
    node_attrs.assign(num_nodes, {});
}

void Network::set_edges(const std::vector<std::pair<int, int>>& edge_list, bool is_directed) {
    if (num_nodes <= 0) {
        throw std::runtime_error("Network::set_edges called before set_num_nodes.");
    }
    directed = is_directed;
    edges = edge_list;
    num_edges = static_cast<int>(edges.size());
    adjacency.assign(num_nodes, {});
    edge_attrs.assign(num_edges, {});
    edge_index.clear();

    for (int edge_id = 0; edge_id < num_edges; ++edge_id) {
        auto [u, v] = edges[edge_id];
        if (u < 0 || u >= num_nodes || v < 0 || v >= num_nodes) {
            throw std::out_of_range("Network::set_edges received node id outside valid range.");
        }
        adjacency[u].emplace_back(v, edge_id);
        edge_index[{u, v}] = edge_id;
        if (!directed) {
            adjacency[v].emplace_back(u, edge_id);
            edge_index[{v, u}] = edge_id;
        }
    }
}

void Network::set_node_attrs(const std::vector<std::unordered_map<std::string, double>>& attrs) {
    if (static_cast<int>(attrs.size()) != num_nodes) {
        throw std::invalid_argument("Network::set_node_attrs size mismatch with num_nodes.");
    }
    node_attrs = attrs;
}

void Network::set_edge_attrs(const std::vector<std::unordered_map<std::string, double>>& attrs) {
    if (static_cast<int>(attrs.size()) != num_edges) {
        throw std::invalid_argument("Network::set_edge_attrs size mismatch with num_edges.");
    }
    edge_attrs = attrs;
}

}  // namespace azsfc

