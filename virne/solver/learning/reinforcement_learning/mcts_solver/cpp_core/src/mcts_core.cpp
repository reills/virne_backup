#include <pybind11/pybind11.h>
#include <pybind11/stl.h>
#include <pybind11/numpy.h>

#include <algorithm>
#include <cmath>
#include <cctype>
#include <limits>
#include <memory>
#include <optional>
#include <queue>
#include <random>
#include <string>
#include <stdexcept>
#include <utility>
#include <vector>
#include <unordered_set>
#include <unordered_map>

namespace py = pybind11;

namespace {

double negative_infinity() {
    return -std::numeric_limits<double>::infinity();
}

// Constraint attribute representation
struct AttributeConstraint {
    enum class Method { LE, GE, EQ };

    std::string name;
    Method method{Method::LE};
    bool is_hard{true};
    std::size_t attr_index{0};

    std::pair<bool, double> evaluate(double v_value, double p_value) const {
        bool flag = true;
        double offset = 0.0;
        switch (method) {
            case Method::GE:
                flag = v_value >= p_value - 1e-8;
                offset = p_value - v_value;
                break;
            case Method::EQ:
                flag = std::abs(v_value - p_value) <= 1e-8;
                offset = std::abs(v_value - p_value);
                break;
            case Method::LE:
            default:
                flag = v_value <= p_value + 1e-8;
                offset = v_value - p_value;
                break;
        }
        if (is_hard) {
            return {flag, offset};
        }
        return {true, offset};
    }
};

// Hash function for std::pair (must be defined before use)
struct PairHash {
    std::size_t operator()(const std::pair<int, int>& p) const noexcept {
        return std::hash<int>{}(p.first) ^ (std::hash<int>{}(p.second) << 1);
    }
};

// Network structure for C++ graph operations
struct NetworkGraph {
    int num_nodes{0};
    std::vector<std::vector<std::pair<int, int>>> adjacency;  // node -> [(neighbor, edge_id)]
    std::vector<std::pair<int, int>> edges;  // edge_id -> (u, v)
    std::unordered_map<std::pair<int, int>, int, PairHash> edge_index;  // (u,v) -> edge_id

    // Edge resource data for path finding
    std::vector<std::unordered_map<std::string, double>> edge_attrs;
};

// Cache network data in C++ to avoid repeated Python calls
struct NetworkCache {
    int num_v_nodes;
    int num_p_nodes;
    std::string shortest_method;
    int k_shortest{1};
    std::vector<std::vector<double>> v_node_resources;  // [v_node_id][resource_idx]
    std::vector<std::vector<double>> p_node_resources;  // [p_node_id][resource_idx]
    std::vector<std::vector<double>> v_link_resources;  // [v_link_idx][resource_idx]
    std::vector<std::pair<int, int>> v_links;           // virtual network edges
    std::vector<int> v_node_degrees;
    std::vector<int> p_node_degrees;
    std::vector<double> v_link_aggr_resources;
    std::vector<double> p_link_aggr_resources;
    std::vector<std::string> link_resource_names;       // attribute names for link resources

    // Demand ordering and totals
    std::vector<int> v_order;
    std::vector<int> v_position;
    double total_node_demand{0.0};
    double total_link_demand{0.0};
    double total_v_revenue{0.0};
    bool allow_rejection{false};
    double reject_penalty{50.0};

    // Network graph structure for shortest path finding
    NetworkGraph p_graph;
    NetworkGraph v_graph;

    // Precompute candidate nodes for each v_node
    std::vector<std::vector<int>> candidate_nodes_cache;  // [v_node_id] -> list of candidate p_nodes

    // Constraint data
    std::vector<AttributeConstraint> node_constraints;
    std::vector<AttributeConstraint> link_constraints;
    std::vector<std::string> node_resource_attr_names;
    bool use_sum_link_aggregation{false};
};

// Extract network data once at initialization
NetworkCache extract_network_data(py::object v_net,
                                  py::object p_net,
                                  py::object controller,
                                  const std::string& shortest_method,
                                  int k_shortest) {
    py::gil_scoped_acquire gil;
    NetworkCache cache;

    // Get network sizes
    cache.num_v_nodes = py::cast<int>(v_net.attr("num_nodes"));
    cache.num_p_nodes = py::cast<int>(p_net.attr("num_nodes"));
    cache.shortest_method = shortest_method;
    cache.k_shortest = k_shortest;

    // Extract node resource attributes
    py::list node_resource_attrs = controller.attr("node_resource_attrs");
    py::list link_resource_attrs = controller.attr("link_resource_attrs");
    int num_node_attrs = py::len(node_resource_attrs);
    int num_link_attrs = py::len(link_resource_attrs);

    // Pre-cache node resource attribute names
    std::vector<std::string> node_attr_names;
    node_attr_names.reserve(num_node_attrs);
    for (int attr_idx = 0; attr_idx < num_node_attrs; ++attr_idx) {
        py::object attr = node_resource_attrs[attr_idx];
        node_attr_names.push_back(py::cast<std::string>(attr.attr("name")));
    }
    cache.node_resource_attr_names = node_attr_names;

    // Extract virtual node resources
    cache.v_node_resources.resize(cache.num_v_nodes);
    py::object v_nodes = v_net.attr("nodes");
    for (int v_id = 0; v_id < cache.num_v_nodes; ++v_id) {
        py::object v_node_data = v_nodes.attr("__getitem__")(py::int_(v_id));
        for (int attr_idx = 0; attr_idx < num_node_attrs; ++attr_idx) {
            const auto& attr_name = node_attr_names[attr_idx];
            double value = py::cast<double>(v_node_data.attr("__getitem__")(py::str(attr_name)));
            cache.v_node_resources[v_id].push_back(value);
        }
    }

    // Extract physical node resources
    cache.p_node_resources.resize(cache.num_p_nodes);
    py::object p_nodes = p_net.attr("nodes");
    for (int p_id = 0; p_id < cache.num_p_nodes; ++p_id) {
        py::object p_node_data = p_nodes.attr("__getitem__")(py::int_(p_id));
        for (int attr_idx = 0; attr_idx < num_node_attrs; ++attr_idx) {
            const auto& attr_name = node_attr_names[attr_idx];
            double value = py::cast<double>(p_node_data.attr("__getitem__")(py::str(attr_name)));
            cache.p_node_resources[p_id].push_back(value);
        }
    }

    // Extract virtual links with their resource demands
    py::object v_links_obj = v_net.attr("links");
    py::object v_links_data = v_net.attr("links");  // to access link attributes

    for (const auto& link : v_links_obj) {
        auto link_tuple = py::cast<std::tuple<int, int>>(link);
        int u = std::get<0>(link_tuple);
        int v = std::get<1>(link_tuple);
        cache.v_links.push_back({u, v});

        // Extract link resource demands
        py::object link_data = v_links_data.attr("__getitem__")(link);
        std::vector<double> link_resources;
        for (int attr_idx = 0; attr_idx < num_link_attrs; ++attr_idx) {
            py::object attr = link_resource_attrs[attr_idx];
            std::string attr_name = py::cast<std::string>(attr.attr("name"));
            double value = py::cast<double>(link_data.attr("__getitem__")(py::str(attr_name)));
            link_resources.push_back(value);
        }
        cache.v_link_resources.push_back(link_resources);
    }

    // Extract node degrees
    py::dict v_degree_dict = v_net.attr("degree")();
    py::dict p_degree_dict = p_net.attr("degree")();

    cache.v_node_degrees.resize(cache.num_v_nodes);
    for (int v_id = 0; v_id < cache.num_v_nodes; ++v_id) {
        cache.v_node_degrees[v_id] = py::cast<int>(v_degree_dict[py::int_(v_id)]);
    }

    cache.p_node_degrees.resize(cache.num_p_nodes);
    for (int p_id = 0; p_id < cache.num_p_nodes; ++p_id) {
        cache.p_node_degrees[p_id] = py::cast<int>(p_degree_dict[py::int_(p_id)]);
    }

    // Determine aggregation method based on requested shortest path settings
    cache.use_sum_link_aggregation = (shortest_method == "mcf");

    // Extract aggregated link resources
    py::str aggr_method(cache.use_sum_link_aggregation ? "sum" : "max");
    py::object v_link_aggr = v_net.attr("get_aggregation_attrs_data")(link_resource_attrs, py::arg("aggr") = aggr_method);
    py::object p_link_aggr = p_net.attr("get_aggregation_attrs_data")(link_resource_attrs, py::arg("aggr") = aggr_method);

    // Convert to numpy arrays and extract data
    py::array_t<double> v_aggr_array = py::cast<py::array_t<double>>(v_link_aggr);
    py::array_t<double> p_aggr_array = py::cast<py::array_t<double>>(p_link_aggr);

    auto v_aggr_buf = v_aggr_array.request();
    auto p_aggr_buf = p_aggr_array.request();

    double* v_aggr_ptr = static_cast<double*>(v_aggr_buf.ptr);
    double* p_aggr_ptr = static_cast<double*>(p_aggr_buf.ptr);

    // Assume shape is [num_attrs, num_nodes]
    int v_aggr_size = v_aggr_buf.size;
    int p_aggr_size = p_aggr_buf.size;

    cache.v_link_aggr_resources.assign(v_aggr_ptr, v_aggr_ptr + v_aggr_size);
    cache.p_link_aggr_resources.assign(p_aggr_ptr, p_aggr_ptr + p_aggr_size);

    // Extract link resource attribute names
    for (int i = 0; i < num_link_attrs; ++i) {
        py::object attr = link_resource_attrs[i];
        std::string attr_name = py::cast<std::string>(attr.attr("name"));
        cache.link_resource_names.push_back(attr_name);
    }

    // Build network graph structures for shortest path finding
    cache.p_graph.num_nodes = cache.num_p_nodes;
    cache.p_graph.adjacency.resize(cache.num_p_nodes);
    cache.v_graph.num_nodes = cache.num_v_nodes;
    cache.v_graph.adjacency.resize(cache.num_v_nodes);

    // Extract physical network edges
    py::object p_edges = p_net.attr("edges");
    int p_edge_id = 0;
    for (const auto& edge : p_edges) {
        auto edge_tuple = py::cast<std::tuple<int, int>>(edge);
        int u = std::get<0>(edge_tuple);
        int v = std::get<1>(edge_tuple);

        cache.p_graph.edges.push_back({u, v});
        cache.p_graph.adjacency[u].push_back({v, p_edge_id});
        cache.p_graph.adjacency[v].push_back({u, p_edge_id});  // undirected
        cache.p_graph.edge_index[{u, v}] = p_edge_id;
        cache.p_graph.edge_index[{v, u}] = p_edge_id;

        // Extract edge attributes
        py::object p_links = p_net.attr("links");
        py::object edge_data = p_links.attr("__getitem__")(edge);
        std::unordered_map<std::string, double> edge_attrs_map;
        for (const auto& attr_name : cache.link_resource_names) {
            double val = py::cast<double>(edge_data.attr("__getitem__")(py::str(attr_name)));
            edge_attrs_map[attr_name] = val;
        }
        cache.p_graph.edge_attrs.push_back(edge_attrs_map);

        p_edge_id++;
    }

    // Extract virtual network edges
    int v_edge_id = 0;
    for (const auto& v_link : cache.v_links) {
        int u = v_link.first;
        int v = v_link.second;

        cache.v_graph.edges.push_back({u, v});
        cache.v_graph.adjacency[u].push_back({v, v_edge_id});
        cache.v_graph.adjacency[v].push_back({u, v_edge_id});  // undirected
        cache.v_graph.edge_index[{u, v}] = v_edge_id;
        cache.v_graph.edge_index[{v, u}] = v_edge_id;

        v_edge_id++;
    }

    // Extract node constraint configuration
    py::object constraint_checker = controller.attr("constraint_checker");
    py::list node_constraint_attrs = constraint_checker.attr("node_constraint_attrs_checking_at_node");

    for (const auto& attr_obj : node_constraint_attrs) {
        AttributeConstraint constraint;
        constraint.name = py::cast<std::string>(attr_obj.attr("name"));
        std::string method_str = "le";
        try {
            if (py::hasattr(attr_obj, "method")) {
                method_str = py::cast<std::string>(attr_obj.attr("method"));
            } else {
                py::object attr_dict = attr_obj.attr("__dict__");
                if (py::hasattr(attr_dict, "get")) {
                    method_str = py::cast<std::string>(attr_dict.attr("get")(py::str("method"), py::str("le")));
                }
            }
        } catch (const py::error_already_set&) {
            method_str = "le";
        }

        std::string restriction = "hard";
        try {
            if (py::hasattr(attr_obj, "constraint_restrictions")) {
                restriction = py::cast<std::string>(attr_obj.attr("constraint_restrictions"));
            }
        } catch (const py::error_already_set&) {
            restriction = "hard";
        }

        std::transform(method_str.begin(), method_str.end(), method_str.begin(), [](unsigned char c) {
            return static_cast<char>(std::tolower(c));
        });

        if (method_str == "ge" || method_str == ">=") {
            constraint.method = AttributeConstraint::Method::GE;
        } else if (method_str == "eq" || method_str == "==") {
            constraint.method = AttributeConstraint::Method::EQ;
        } else {
            constraint.method = AttributeConstraint::Method::LE;
        }
        constraint.is_hard = (restriction == "hard");

        auto it = std::find(cache.node_resource_attr_names.begin(),
                            cache.node_resource_attr_names.end(),
                            constraint.name);
        if (it == cache.node_resource_attr_names.end()) {
            continue;
        }
        constraint.attr_index = static_cast<std::size_t>(std::distance(cache.node_resource_attr_names.begin(), it));
        cache.node_constraints.push_back(constraint);
    }

    // Pull solver-level rejection configuration if available
    try {
        if (py::hasattr(controller, "config")) {
            py::object cfg = controller.attr("config");
            if (!cfg.is_none()) {
                auto update_from_dict = [&](const py::dict& dict) {
                    if (dict.contains(py::str("allow_rejection"))) {
                        cache.allow_rejection = py::cast<bool>(dict[py::str("allow_rejection")]);
                    }
                    if (dict.contains(py::str("reject_penalty"))) {
                        cache.reject_penalty = py::cast<double>(dict[py::str("reject_penalty")]);
                    }
                };
                auto update_from_object = [&](const py::object& obj) {
                    if (py::hasattr(obj, "allow_rejection")) {
                        cache.allow_rejection = py::cast<bool>(obj.attr("allow_rejection"));
                    }
                    if (py::hasattr(obj, "reject_penalty")) {
                        cache.reject_penalty = py::cast<double>(obj.attr("reject_penalty"));
                    }
                };

                if (py::isinstance<py::dict>(cfg)) {
                    py::dict cfg_dict = py::reinterpret_borrow<py::dict>(cfg);
                    update_from_dict(cfg_dict);
                    if (cfg_dict.contains(py::str("solver"))) {
                        py::object solver_cfg_obj = cfg_dict[py::str("solver")];
                        if (!solver_cfg_obj.is_none()) {
                            if (py::isinstance<py::dict>(solver_cfg_obj)) {
                                update_from_dict(py::reinterpret_borrow<py::dict>(solver_cfg_obj));
                            } else {
                                update_from_object(solver_cfg_obj);
                            }
                        }
                    }
                } else {
                    update_from_object(cfg);
                    if (py::hasattr(cfg, "solver")) {
                        py::object solver_cfg_obj = cfg.attr("solver");
                        if (!solver_cfg_obj.is_none()) {
                            if (py::isinstance<py::dict>(solver_cfg_obj)) {
                                update_from_dict(py::reinterpret_borrow<py::dict>(solver_cfg_obj));
                            } else {
                                update_from_object(solver_cfg_obj);
                            }
                        }
                    }
                }
            }
        }
    } catch (const py::error_already_set&) {
        PyErr_Clear();
    } catch (const std::exception&) {
        // ignore config extraction errors
    }

    // Precompute total resource demands
    cache.total_node_demand = 0.0;
    for (const auto& node_res : cache.v_node_resources) {
        for (double value : node_res) {
            cache.total_node_demand += value;
        }
    }
    cache.total_link_demand = 0.0;
    for (const auto& link_res : cache.v_link_resources) {
        for (double value : link_res) {
            cache.total_link_demand += value;
        }
    }
    cache.total_v_revenue = cache.total_node_demand + cache.total_link_demand;

    // Determine stable virtual node ordering (descending demand)
    std::vector<std::pair<int, double>> order_scores;
    order_scores.reserve(cache.num_v_nodes);
    for (int v = 0; v < cache.num_v_nodes; ++v) {
        double node_sum = 0.0;
        if (v < static_cast<int>(cache.v_node_resources.size())) {
            for (double value : cache.v_node_resources[v]) {
                node_sum += value;
            }
        }
        double edge_sum = 0.0;
        if (v < static_cast<int>(cache.v_graph.adjacency.size())) {
            const auto& neighbors = cache.v_graph.adjacency[v];
            for (const auto& [neighbor, edge_id] : neighbors) {
                (void)neighbor;
                if (edge_id < static_cast<int>(cache.v_link_resources.size())) {
                    for (double value : cache.v_link_resources[edge_id]) {
                        edge_sum += value;
                    }
                }
            }
        }
        order_scores.emplace_back(v, node_sum + edge_sum);
    }
    std::sort(order_scores.begin(), order_scores.end(), [](const auto& a, const auto& b) {
        return a.second > b.second;
    });
    cache.v_order.clear();
    cache.v_order.reserve(order_scores.size());
    cache.v_position.assign(cache.num_v_nodes, 0);
    for (std::size_t idx = 0; idx < order_scores.size(); ++idx) {
        int v_id = order_scores[idx].first;
        cache.v_order.push_back(v_id);
        if (v_id >= 0 && v_id < cache.num_v_nodes) {
            cache.v_position[v_id] = static_cast<int>(idx);
        }
    }
    if (cache.v_order.empty()) {
        cache.v_order.resize(cache.num_v_nodes);
        cache.v_position.assign(cache.num_v_nodes, 0);
        for (int v = 0; v < cache.num_v_nodes; ++v) {
            cache.v_order[v] = v;
            cache.v_position[v] = v;
        }
    }

    return cache;
}

// C++ implementation of cost/revenue calculation
struct CostRevenueResult {
    double cost;
    double revenue;
    bool success;
};

CostRevenueResult calculate_cost_revenue_cpp(
    const NetworkCache& cache,
    const std::vector<int>& selected_nodes,
    const std::vector<std::vector<int>>& link_paths  // [v_link_idx] -> [p_node_path]
) {
    CostRevenueResult result{0.0, 0.0, true};

    // Calculate node revenue (sum of all virtual node resources)
    double node_revenue = 0.0;
    for (int v_id = 0; v_id < cache.num_v_nodes; ++v_id) {
        for (double resource : cache.v_node_resources[v_id]) {
            node_revenue += resource;
        }
    }

    // Calculate link revenue and cost
    double link_revenue = 0.0;
    double link_cost = 0.0;

    for (size_t v_link_idx = 0; v_link_idx < cache.v_links.size(); ++v_link_idx) {
        const auto& p_path = link_paths[v_link_idx];

        if (p_path.empty()) {
            result.success = false;
            return result;
        }

        // Virtual link resource demand (revenue)
        // Sum of all resource attributes for this virtual link
        if (v_link_idx < cache.v_link_resources.size()) {
            for (double resource : cache.v_link_resources[v_link_idx]) {
                link_revenue += resource;
            }
        }

        // Physical path cost (sum over all physical links in path)
        // Cost = sum of virtual link demands * number of physical hops
        if (v_link_idx < cache.v_link_resources.size()) {
            for (size_t i = 0; i + 1 < p_path.size(); ++i) {
                // Each hop costs the full virtual link demand
                for (double resource : cache.v_link_resources[v_link_idx]) {
                    link_cost += resource;
                }
            }
        }
    }

    // Total revenue = node resources + link resources
    // Total cost = node resources + link path costs
    result.revenue = node_revenue + link_revenue;
    result.cost = node_revenue + link_cost;
    result.success = true;

    return result;
}

// BFS shortest path finder in C++
struct PathResult {
    std::vector<int> nodes;
    double cost{0.0};
};

std::vector<PathResult> find_bfs_shortest_path(
    const NetworkGraph& graph,
    int source,
    int target,
    const std::unordered_map<std::string, double>& current_link_resources,
    const std::unordered_map<std::string, double>& link_demands
) {
    std::vector<PathResult> results;

    if (source < 0 || target < 0 || source >= graph.num_nodes || target >= graph.num_nodes) {
        return results;
    }

    if (source == target) {
        PathResult trivial;
        trivial.nodes = {source};
        trivial.cost = 0.0;
        results.push_back(std::move(trivial));
        return results;
    }

    // BFS with capacity checking
    std::queue<std::vector<int>> frontier;
    frontier.push({source});

    std::unordered_map<int, int> best_depth;
    best_depth[source] = 0;

    while (!frontier.empty()) {
        auto path = std::move(frontier.front());
        frontier.pop();

        int current = path.back();
        if (current == target) {
            PathResult out;
            out.nodes = path;
            out.cost = static_cast<double>(path.size() - 1);
            results.push_back(std::move(out));
            break;
        }

        int next_depth = static_cast<int>(path.size());
        const auto& neighbors = graph.adjacency[current];
        for (const auto& [neighbor, edge_id] : neighbors) {
            // Check if neighbor already in path
            if (std::find(path.begin(), path.end(), neighbor) != path.end()) {
                continue;
            }

            // Check link capacity
            bool has_capacity = true;
            for (const auto& [attr_name, demand] : link_demands) {
                if (demand <= 0.0) continue;

                // Get current available resource for this edge
                auto edge_pair = std::make_pair(current, neighbor);
                auto it = current_link_resources.find(attr_name + "_" + std::to_string(edge_id));
                if (it != current_link_resources.end()) {
                    if (it->second + 1e-8 < demand) {
                        has_capacity = false;
                        break;
                    }
                }
            }

            if (!has_capacity) {
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

    return results;
}

// C++ version of check_node_level_constraints
bool check_node_constraints_cpp(
    const NetworkCache& cache,
    int v_node_id,
    int p_node_id
) {
    // Check all node constraints in C++
    for (const auto& constraint : cache.node_constraints) {
        if (constraint.attr_index >= cache.v_node_resources[v_node_id].size() ||
            constraint.attr_index >= cache.p_node_resources[p_node_id].size()) {
            continue;
        }
        double v_value = cache.v_node_resources[v_node_id][constraint.attr_index];
        double p_value = cache.p_node_resources[p_node_id][constraint.attr_index];
        auto [satisfied, _] = constraint.evaluate(v_value, p_value);
        if (!satisfied) {
            return false;
        }
    }

    return true;  // All constraints satisfied
}

// Fast C++ implementation of find_candidate_nodes
std::vector<int> find_candidate_nodes_cpp(
    const NetworkCache& cache,
    int v_node_id,
    const std::unordered_set<int>& filter,
    bool check_node_constraint,
    bool check_link_constraint
) {
    std::vector<int> node_candidates;
    node_candidates.reserve(cache.num_p_nodes);

    if (v_node_id < 0 || v_node_id >= cache.num_v_nodes) {
        return node_candidates;
    }

    if (check_node_constraint) {
        for (int p_node_id = 0; p_node_id < cache.num_p_nodes; ++p_node_id) {
            if (filter.find(p_node_id) != filter.end()) {
                continue;
            }
            if (!check_node_constraints_cpp(cache, v_node_id, p_node_id)) {
                continue;
            }
            node_candidates.push_back(p_node_id);
        }
    } else {
        for (int p_node_id = 0; p_node_id < cache.num_p_nodes; ++p_node_id) {
            if (filter.find(p_node_id) != filter.end()) {
                continue;
            }
            node_candidates.push_back(p_node_id);
        }
    }

    if (check_link_constraint) {
        const int v_degree = cache.v_node_degrees[v_node_id];
        const int num_attrs = static_cast<int>(cache.link_resource_names.size());
        const bool has_aggr_data = !cache.v_link_aggr_resources.empty() && !cache.p_link_aggr_resources.empty();

        std::vector<int> link_candidates;
        link_candidates.reserve(cache.num_p_nodes);

        for (int p_node_id = 0; p_node_id < cache.num_p_nodes; ++p_node_id) {
            if (filter.find(p_node_id) != filter.end()) {
                continue;
            }

            if (cache.p_node_degrees[p_node_id] < v_degree) {
                continue;
            }

            bool resource_ok = true;
            if (has_aggr_data && num_attrs > 0) {
                for (int attr_idx = 0; attr_idx < num_attrs; ++attr_idx) {
                    const int v_offset = attr_idx * cache.num_v_nodes + v_node_id;
                    const int p_offset = attr_idx * cache.num_p_nodes + p_node_id;
                    if (v_offset >= static_cast<int>(cache.v_link_aggr_resources.size()) ||
                        p_offset >= static_cast<int>(cache.p_link_aggr_resources.size())) {
                        continue;
                    }

                    const double v_resource = cache.v_link_aggr_resources[v_offset];
                    const double p_resource = cache.p_link_aggr_resources[p_offset];
                    if (p_resource + 1e-8 < v_resource) {
                        resource_ok = false;
                        break;
                    }
                }
            }

            if (resource_ok) {
                link_candidates.push_back(p_node_id);
            }
        }

        if (check_node_constraint) {
            std::vector<int> intersection;
            intersection.reserve(std::min(node_candidates.size(), link_candidates.size()));
            std::vector<char> link_mask(cache.num_p_nodes, 0);
            for (int p_node_id : link_candidates) {
                if (p_node_id >= 0 && p_node_id < cache.num_p_nodes) {
                    link_mask[p_node_id] = 1;
                }
            }
            for (int p_node_id : node_candidates) {
                if (p_node_id >= 0 && p_node_id < cache.num_p_nodes && link_mask[p_node_id]) {
                    intersection.push_back(p_node_id);
                }
            }
            return intersection;
        }

        return link_candidates;
    }

    return node_candidates;
}

// Helper function for BFS shortest path with state allocations
std::vector<PathResult> find_bfs_shortest_path_with_state(
    const NetworkGraph& graph,
    int source,
    int target,
    const std::vector<std::unordered_map<std::string, double>>& link_allocations,
    const std::unordered_map<std::string, double>& link_demands
) {
    std::vector<PathResult> results;

    if (source < 0 || target < 0 || source >= graph.num_nodes || target >= graph.num_nodes) {
        return results;
    }

    if (source == target) {
        PathResult trivial;
        trivial.nodes = {source};
        trivial.cost = 0.0;
        results.push_back(std::move(trivial));
        return results;
    }

    // BFS with capacity checking
    std::queue<std::vector<int>> frontier;
    frontier.push({source});

    std::unordered_map<int, int> best_depth;
    best_depth[source] = 0;

    while (!frontier.empty()) {
        auto path = std::move(frontier.front());
        frontier.pop();

        int current = path.back();
        if (current == target) {
            PathResult out;
            out.nodes = path;
            out.cost = static_cast<double>(path.size() - 1);
            results.push_back(std::move(out));
            break;
        }

        int next_depth = static_cast<int>(path.size());
        const auto& neighbors = graph.adjacency[current];
        for (const auto& [neighbor, edge_id] : neighbors) {
            // Check if neighbor already in path
            if (std::find(path.begin(), path.end(), neighbor) != path.end()) {
                continue;
            }

            // Check link capacity with current allocations
            bool has_capacity = true;
            for (const auto& [attr_name, demand] : link_demands) {
                if (demand <= 0.0) continue;

                // Get available capacity: original - allocated
                double original_capacity = 0.0;
                if (edge_id < graph.edge_attrs.size()) {
                    auto it = graph.edge_attrs[edge_id].find(attr_name);
                    if (it != graph.edge_attrs[edge_id].end()) {
                        original_capacity = it->second;
                    }
                }

                double allocated = 0.0;
                if (edge_id < link_allocations.size()) {
                    auto it = link_allocations[edge_id].find(attr_name);
                    if (it != link_allocations[edge_id].end()) {
                        allocated = it->second;
                    }
                }

                double available = original_capacity - allocated;
                if (available + 1e-8 < demand) {
                    has_capacity = false;
                    break;
                }
            }

            if (!has_capacity) {
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

    return results;
}

// Pure C++ State class (no Python objects)
class PureCppState {
public:
    explicit PureCppState(std::shared_ptr<const NetworkCache> cache)
        : cache_(std::move(cache)),
          v_node_index_(-1),
          p_node_id_(0),
          rejected_(false),
          allow_rejection_(cache_->allow_rejection),
          reject_penalty_(cache_->reject_penalty),
          reject_action_id_(cache_->num_p_nodes) {
        p_node_id_ = reject_action_id_;
        placement_map_.assign(cache_->num_v_nodes, -1);
        selected_p_nodes_.reserve(cache_->num_v_nodes);
        node_allocations_.resize(cache_->num_p_nodes);
        link_allocations_.resize(cache_->p_graph.edges.size());
    }

    PureCppState(const PureCppState&) = default;

    bool is_terminal() const {
        if (rejected_) {
            return true;
        }
        if (p_node_id_ == -1) {
            return true;
        }
        return v_node_index_ == (cache_->num_v_nodes - 1);
    }

    std::vector<int> get_candidate_nodes() const;
    PureCppState create_child(int p_node_id) const;
    double compute_final_reward() const;

    int reject_action_id() const { return reject_action_id_; }
    bool rejected() const { return rejected_; }
    const std::vector<int>& selected_p_nodes() const { return selected_p_nodes_; }

    std::shared_ptr<const NetworkCache> cache_;
    int v_node_index_;
    int p_node_id_;
    std::vector<int> selected_p_nodes_;
    std::vector<int> placement_map_;
    std::vector<std::unordered_map<std::string, double>> node_allocations_;
    std::vector<std::unordered_map<std::string, double>> link_allocations_;
    std::unordered_map<std::pair<int, int>, std::vector<int>, PairHash> reserved_paths_;
    bool rejected_;
    bool allow_rejection_;
    double reject_penalty_;
    int reject_action_id_;

private:
    bool apply_node_allocation(int p_node_id, int v_node_id);
    bool reserve_link_resources(int v_node_id, int p_node_id);
    bool reserve_path_for_virtual_edge(int v_src, int v_dst, int p_src, int p_dst);
    double get_allocated_node_resource(int p_node_id, const std::string& attr) const;
};

std::vector<int> PureCppState::get_candidate_nodes() const {
    std::vector<int> candidates;
    int next_index = v_node_index_ + 1;
    if (next_index >= cache_->num_v_nodes) {
        if (allow_rejection_) {
            candidates.push_back(reject_action_id_);
        }
        if (candidates.empty()) {
            candidates.push_back(-1);
        }
        return candidates;
    }

    int v_target = cache_->v_order[next_index];
    for (int p = 0; p < cache_->num_p_nodes; ++p) {
        if (std::find(selected_p_nodes_.begin(), selected_p_nodes_.end(), p) != selected_p_nodes_.end()) {
            continue;
        }
        bool feasible = true;
        if (v_target >= 0 && v_target < static_cast<int>(cache_->v_node_resources.size())) {
            const auto& demands = cache_->v_node_resources[v_target];
            for (std::size_t attr_idx = 0; attr_idx < demands.size(); ++attr_idx) {
                double demand = demands[attr_idx];
                if (demand <= 0.0) {
                    continue;
                }
                const auto& attr_name = cache_->node_resource_attr_names[attr_idx];
                double available = cache_->p_node_resources[p][attr_idx] - get_allocated_node_resource(p, attr_name);
                if (available + 1e-8 < demand) {
                    feasible = false;
                    break;
                }
            }
        }
        if (feasible) {
            candidates.push_back(p);
        }
    }

    if (allow_rejection_) {
        candidates.push_back(reject_action_id_);
    }
    if (candidates.empty()) {
        candidates.push_back(-1);
    }
    return candidates;
}

PureCppState PureCppState::create_child(int p_node_id) const {
    PureCppState child(*this);
    child.v_node_index_ = v_node_index_ + 1;
    child.p_node_id_ = p_node_id;

    if (p_node_id == reject_action_id_) {
        if (allow_rejection_) {
            child.rejected_ = true;
        } else {
            child.p_node_id_ = -1;
        }
        return child;
    }

    if (p_node_id == -1) {
        child.p_node_id_ = -1;
        return child;
    }

    child.selected_p_nodes_.push_back(p_node_id);
    if (child.v_node_index_ < static_cast<int>(cache_->v_order.size())) {
        int v_target = cache_->v_order[child.v_node_index_];
        if (v_target >= 0 && v_target < static_cast<int>(child.placement_map_.size())) {
            child.placement_map_[v_target] = p_node_id;
        }

        if (!child.apply_node_allocation(p_node_id, v_target)) {
            child.p_node_id_ = -1;
            return child;
        }

        if (!child.reserve_link_resources(v_target, p_node_id)) {
            child.p_node_id_ = -1;
            return child;
        }
    }

    return child;
}

double PureCppState::compute_final_reward() const {
    if (rejected_) {
        return -reject_penalty_;
    }
    if (p_node_id_ == -1) {
        return -1000.0;
    }
    if (static_cast<int>(selected_p_nodes_.size()) != cache_->num_v_nodes) {
        return -1000.0;
    }

    double link_cost = 0.0;
    for (const auto& edge_map : link_allocations_) {
        for (const auto& kv : edge_map) {
            link_cost += kv.second;
        }
    }

    double total_cost = cache_->total_node_demand + link_cost;
    return 1000.0 + cache_->total_v_revenue - total_cost;
}

double PureCppState::get_allocated_node_resource(int p_node_id, const std::string& attr) const {
    if (p_node_id < 0 || p_node_id >= static_cast<int>(node_allocations_.size())) {
        return 0.0;
    }
    const auto& table = node_allocations_[p_node_id];
    auto it = table.find(attr);
    if (it == table.end()) {
        return 0.0;
    }
    return it->second;
}

bool PureCppState::apply_node_allocation(int p_node_id, int v_node_id) {
    if (v_node_id < 0 || v_node_id >= static_cast<int>(cache_->v_node_resources.size())) {
        return false;
    }
    const auto& demands = cache_->v_node_resources[v_node_id];
    for (std::size_t attr_idx = 0; attr_idx < demands.size(); ++attr_idx) {
        double demand = demands[attr_idx];
        if (demand <= 0.0) {
            continue;
        }
        const auto& attr_name = cache_->node_resource_attr_names[attr_idx];
        double available = cache_->p_node_resources[p_node_id][attr_idx] - get_allocated_node_resource(p_node_id, attr_name);
        if (available + 1e-8 < demand) {
            return false;
        }
    }
    for (std::size_t attr_idx = 0; attr_idx < demands.size(); ++attr_idx) {
        double demand = demands[attr_idx];
        if (demand <= 0.0) {
            continue;
        }
        const auto& attr_name = cache_->node_resource_attr_names[attr_idx];
        node_allocations_[p_node_id][attr_name] += demand;
    }
    return true;
}

bool PureCppState::reserve_link_resources(int v_node_id, int p_node_id) {
    if (v_node_id < 0 || v_node_id >= static_cast<int>(cache_->v_graph.adjacency.size())) {
        return true;
    }
    const auto& neighbors = cache_->v_graph.adjacency[v_node_id];
    for (const auto& [neighbor, edge_id] : neighbors) {
        (void)edge_id;
        int neighbor_pos = 0;
        if (neighbor >= 0 && neighbor < static_cast<int>(cache_->v_position.size())) {
            neighbor_pos = cache_->v_position[neighbor];
        }
        if (neighbor_pos > v_node_index_) {
            continue;
        }
        if (neighbor < 0 || neighbor >= static_cast<int>(placement_map_.size())) {
            continue;
        }
        int mapped_neighbor = placement_map_[neighbor];
        if (mapped_neighbor < 0) {
            continue;
        }
        if (!reserve_path_for_virtual_edge(v_node_id, neighbor, p_node_id, mapped_neighbor)) {
            return false;
        }
    }
    return true;
}

bool PureCppState::reserve_path_for_virtual_edge(int v_src, int v_dst, int p_src, int p_dst) {
    auto lookup = cache_->v_graph.edge_index.find({v_src, v_dst});
    if (lookup == cache_->v_graph.edge_index.end()) {
        lookup = cache_->v_graph.edge_index.find({v_dst, v_src});
    }
    if (lookup == cache_->v_graph.edge_index.end()) {
        return false;
    }
    int v_edge_id = lookup->second;

    std::unordered_map<std::string, double> demands;
    if (v_edge_id >= 0 && v_edge_id < static_cast<int>(cache_->v_link_resources.size())) {
        const auto& demand_vec = cache_->v_link_resources[v_edge_id];
        for (std::size_t attr_idx = 0; attr_idx < demand_vec.size(); ++attr_idx) {
            double demand = demand_vec[attr_idx];
            if (demand <= 0.0) {
                continue;
            }
            const auto& attr_name = cache_->link_resource_names[attr_idx];
            demands[attr_name] = demand;
        }
    }

    auto paths = find_bfs_shortest_path_with_state(
        cache_->p_graph,
        p_src,
        p_dst,
        link_allocations_,
        demands
    );

    if (paths.empty()) {
        return false;
    }

    const auto& best_path = paths.front().nodes;
    if (best_path.size() < 2) {
        return false;
    }

    for (std::size_t i = 0; i + 1 < best_path.size(); ++i) {
        int u = best_path[i];
        int v = best_path[i + 1];
        auto edge_lookup = cache_->p_graph.edge_index.find({u, v});
        if (edge_lookup == cache_->p_graph.edge_index.end()) {
            edge_lookup = cache_->p_graph.edge_index.find({v, u});
            if (edge_lookup == cache_->p_graph.edge_index.end()) {
                return false;
            }
        }
        int edge_id = edge_lookup->second;
        for (const auto& [attr_name, demand] : demands) {
            link_allocations_[edge_id][attr_name] += demand;
        }
    }

    reserved_paths_[{v_src, v_dst}] = best_path;
    return true;
}

class State {
public:
    State(py::object p_net,
          py::object v_net,
          py::object controller,
          py::object counter,
          std::shared_ptr<NetworkCache> cache)
        : p_net_(std::move(p_net)),
          v_net_(std::move(v_net)),
          controller_(std::move(controller)),
          counter_(std::move(counter)),
          cache_(std::move(cache)),
          v_node_id_(-1),
          selected_nodes_() {
        p_node_id_ = cache_->num_p_nodes;
        max_expansion_ = p_node_id_;
        v_net_num_nodes_ = cache_->num_v_nodes;
    }

    State(const State&) = default;
    State& operator=(const State&) = default;

    bool is_terminal() const {
        if (p_node_id_ == -1) {
            return true;
        }
        return v_node_id_ == (v_net_num_nodes_ - 1);
    }

    State random_select_next_state(std::mt19937& rng,
                                   const std::vector<int>& tried_actions) {
        // Use cached C++ implementation instead of Python call
        std::unordered_set<int> filter(selected_nodes_.begin(), selected_nodes_.end());

        std::vector<int> candidates = find_candidate_nodes_cpp(
            *cache_,
            v_node_id_ + 1,
            filter,
            /*check_node_constraint=*/true,
            /*check_link_constraint=*/true);

        max_expansion_ = static_cast<int>(candidates.size());

        int choice = -1;
        if (!candidates.empty()) {
            std::vector<int> untried;
            untried.reserve(candidates.size());
            for (int candidate : candidates) {
                if (std::find(tried_actions.begin(), tried_actions.end(), candidate) == tried_actions.end()) {
                    untried.push_back(candidate);
                }
            }
            const std::vector<int>& pool = untried.empty() ? candidates : untried;
            if (!pool.empty()) {
                std::uniform_int_distribution<std::size_t> dist(0, pool.size() - 1);
                choice = pool[dist(rng)];
            }
        }

        State next(*this);
        next.v_node_id_ = v_node_id_ + 1;
        next.p_node_id_ = choice;
        next.selected_nodes_.push_back(choice);
        return next;
    }

    double compute_final_reward() const {
        if (p_node_id_ == -1) {
            return negative_infinity();
        }

        if (static_cast<int>(selected_nodes_.size()) != v_net_num_nodes_) {
            return negative_infinity();
        }

        // NOW USING C++ IMPLEMENTATION - NO PYTHON CALLS!

        // Step 1: Perform link mapping using C++ BFS shortest path
        std::vector<std::vector<int>> link_paths;
        link_paths.reserve(cache_->v_links.size());

        // Current available resources (initially from cache, will be updated as we allocate)
        std::unordered_map<std::string, double> current_link_resources;

        // Initialize with physical network link resources
        for (size_t edge_id = 0; edge_id < cache_->p_graph.edges.size(); ++edge_id) {
            for (const auto& [attr_name, value] : cache_->p_graph.edge_attrs[edge_id]) {
                current_link_resources[attr_name + "_" + std::to_string(edge_id)] = value;
            }
        }

        // Find paths for each virtual link
        for (size_t v_link_idx = 0; v_link_idx < cache_->v_links.size(); ++v_link_idx) {
            const auto& v_link = cache_->v_links[v_link_idx];
            int v_src = v_link.first;
            int v_dst = v_link.second;

            // Get physical source and destination from node mapping
            int p_src = selected_nodes_[v_src];
            int p_dst = selected_nodes_[v_dst];

            // Get virtual link demands
            std::unordered_map<std::string, double> link_demands;
            if (v_link_idx < cache_->v_link_resources.size()) {
                for (size_t attr_idx = 0; attr_idx < cache_->link_resource_names.size(); ++attr_idx) {
                    const auto& attr_name = cache_->link_resource_names[attr_idx];
                    if (attr_idx < cache_->v_link_resources[v_link_idx].size()) {
                        link_demands[attr_name] = cache_->v_link_resources[v_link_idx][attr_idx];
                    }
                }
            }

            // Find shortest path using C++ BFS
            std::vector<PathResult> paths = find_bfs_shortest_path(
                cache_->p_graph,
                p_src,
                p_dst,
                current_link_resources,
                link_demands
            );

            // If no path found, mapping failed
            if (paths.empty()) {
                return negative_infinity();
            }

            // Use the first path found
            const auto& path = paths[0].nodes;
            link_paths.push_back(path);

            // Update available resources along the path
            for (size_t i = 0; i + 1 < path.size(); ++i) {
                int p_u = path[i];
                int p_v = path[i + 1];
                auto edge_pair = std::make_pair(p_u, p_v);

                if (cache_->p_graph.edge_index.find(edge_pair) != cache_->p_graph.edge_index.end()) {
                    int edge_id = cache_->p_graph.edge_index.at(edge_pair);

                    // Deduct resources
                    for (const auto& [attr_name, demand] : link_demands) {
                        std::string key = attr_name + "_" + std::to_string(edge_id);
                        current_link_resources[key] -= demand;

                        // Check for over-allocation (shouldn't happen but be safe)
                        if (current_link_resources[key] < -1e-8) {
                            return negative_infinity();
                        }
                    }
                }
            }
        }

        // Step 2: Calculate cost and revenue using C++ implementation
        CostRevenueResult result = calculate_cost_revenue_cpp(*cache_, selected_nodes_, link_paths);

        if (!result.success) {
            return negative_infinity();
        }

        // Return the same reward formula as Python version
        return 1000.0 + result.revenue - result.cost;
    }

    int max_expansion() const {
        return max_expansion_;
    }

    int physical_node_choice() const {
        return p_node_id_;
    }

    const std::vector<int>& selected_nodes() const {
        return selected_nodes_;
    }

    int virtual_node_count() const {
        return v_net_num_nodes_;
    }

private:
    py::object p_net_;
    py::object v_net_;
    py::object controller_;
    py::object counter_;
    std::shared_ptr<NetworkCache> cache_;
    int v_node_id_;
    int p_node_id_;
    std::vector<int> selected_nodes_;
    int max_expansion_;
    int v_net_num_nodes_;
};

struct TreeNode : public std::enable_shared_from_this<TreeNode> {
    explicit TreeNode(State state, std::shared_ptr<TreeNode> parent = nullptr)
        : parent(std::move(parent)),
          children(),
          state(std::move(state)),
          visit_times(0),
          value_sum(0.0) {}

    bool is_fully_expanded() const {
        if (state.max_expansion() <= 0) {
            return true;
        }
        return static_cast<int>(children.size()) >= state.max_expansion();
    }

    std::shared_ptr<TreeNode> parent;
    std::vector<std::shared_ptr<TreeNode>> children;
    State state;
    int visit_times;
    double value_sum;
};

// Pure C++ TreeNode for PureCppState
struct PureCppTreeNode : public std::enable_shared_from_this<PureCppTreeNode> {
    explicit PureCppTreeNode(PureCppState state, std::shared_ptr<PureCppTreeNode> parent = nullptr)
        : parent(std::move(parent)),
          children(),
          state(std::move(state)),
          visit_times(0),
          value_sum(0.0),
          tried_actions_() {}

    bool is_fully_expanded() const {
        auto candidates = state.get_candidate_nodes();
        if (candidates.empty()) {
            return true;
        }
        // Fully expanded if all candidates have been tried
        return tried_actions_.size() >= candidates.size();
    }

    std::shared_ptr<PureCppTreeNode> parent;
    std::vector<std::shared_ptr<PureCppTreeNode>> children;
    PureCppState state;
    int visit_times;
    double value_sum;
    std::vector<int> tried_actions_;
};

// Pure C++ MCTS Engine
class PureCppMctsEngine {
public:
    PureCppMctsEngine(int computation_budget, double exploration_constant, std::optional<unsigned int> seed)
        : computation_budget_(computation_budget),
          exploration_constant_(exploration_constant),
          rng_(seed ? *seed : std::random_device{}()) {}

    std::vector<int> solve(const PureCppState& root_state, int num_virtual_nodes) {
        auto root = std::make_shared<PureCppTreeNode>(root_state);
        auto cache = root_state.cache_;
        std::vector<int> placements_in_order;
        placements_in_order.reserve(num_virtual_nodes);

        for (int step = 0; step < num_virtual_nodes; ++step) {
            auto next_node = search(root);
            if (!next_node) {
                return {};
            }

            int selected = next_node->state.p_node_id_;
            if (selected == -1 || selected == root_state.reject_action_id()) {
                return {};
            }

            placements_in_order.push_back(selected);
            root = std::move(next_node);
            root->parent.reset();
        }

        if (!root || root->state.rejected() ||
            static_cast<int>(root->state.selected_p_nodes().size()) != num_virtual_nodes) {
            return {};
        }

        if (!cache) {
            return placements_in_order;
        }

        std::vector<int> placements(cache->num_v_nodes, -1);
        for (int idx = 0; idx < num_virtual_nodes && idx < static_cast<int>(cache->v_order.size()); ++idx) {
            int v_id = cache->v_order[idx];
            if (v_id >= 0 && v_id < cache->num_v_nodes) {
                placements[v_id] = placements_in_order[idx];
            }
        }
        return placements;
    }

private:
    std::shared_ptr<PureCppTreeNode> search(const std::shared_ptr<PureCppTreeNode>& root) {
        for (int i = 0; i < computation_budget_; ++i) {
            auto leaf = select_and_expand(root);
            if (!leaf) {
                break;
            }
            double reward = simulate(leaf->state);
            backpropagate(leaf, reward);
        }
        return best_child(root, /*is_exploration=*/false);
    }

    std::shared_ptr<PureCppTreeNode> select_and_expand(std::shared_ptr<PureCppTreeNode> node) {
        while (!node->state.is_terminal()) {
            if (node->is_fully_expanded()) {
                auto best = best_child(node, /*is_exploration=*/true);
                if (!best) {
                    return nullptr;
                }
                node = std::move(best);
            } else {
                return expand(node);
            }
        }
        return node;
    }

    std::shared_ptr<PureCppTreeNode> expand(const std::shared_ptr<PureCppTreeNode>& node) {
        auto candidates = node->state.get_candidate_nodes();

        // Find untried candidates
        std::vector<int> untried;
        for (int candidate : candidates) {
            if (std::find(node->tried_actions_.begin(), node->tried_actions_.end(), candidate)
                == node->tried_actions_.end()) {
                untried.push_back(candidate);
            }
        }

        if (untried.empty()) {
            return nullptr;
        }

        // Randomly select an untried action
        std::uniform_int_distribution<std::size_t> dist(0, untried.size() - 1);
        int choice = untried[dist(rng_)];

        node->tried_actions_.push_back(choice);

        PureCppState child_state = node->state.create_child(choice);
        auto child = std::make_shared<PureCppTreeNode>(child_state, node);
        node->children.push_back(child);
        return child;
    }

    double simulate(PureCppState state) {
        while (!state.is_terminal()) {
            auto candidates = state.get_candidate_nodes();
            if (candidates.empty()) {
                break;
            }

            // Prefer feasible placements over failure/rejection when possible
            std::vector<int> valid_candidates;
            for (int c : candidates) {
                if (c != -1 && c != state.reject_action_id()) {
                    valid_candidates.push_back(c);
                }
            }

            if (valid_candidates.empty()) {
                valid_candidates = candidates;  // Fall back to all options if only failure/reject
            }

            std::uniform_int_distribution<std::size_t> dist(0, valid_candidates.size() - 1);
            int choice = valid_candidates[dist(rng_)];
            state = state.create_child(choice);
        }
        return state.compute_final_reward();
    }

    void backpropagate(std::shared_ptr<PureCppTreeNode> node, double reward) {
        while (node) {
            node->visit_times += 1;
            if (!std::isinf(reward)) {
                node->value_sum += reward;
            }
            node = node->parent;
        }
    }

    std::shared_ptr<PureCppTreeNode> best_child(const std::shared_ptr<PureCppTreeNode>& node, bool is_exploration) {
        std::shared_ptr<PureCppTreeNode> best;
        double best_score = -std::numeric_limits<double>::infinity();

        for (const auto& child : node->children) {
            if (child->visit_times == 0) {
                continue;
            }
            double exploitation = child->value_sum / static_cast<double>(child->visit_times);
            double exploration = 0.0;
            if (is_exploration) {
                exploration = exploration_constant_ *
                              std::sqrt(std::log(static_cast<double>(node->visit_times)) /
                                        static_cast<double>(child->visit_times));
            }
            double score = exploitation + exploration;
            if (score > best_score) {
                best_score = score;
                best = child;
            }
        }
        return best;
    }

    int computation_budget_;
    double exploration_constant_;
    std::mt19937 rng_;
};

class MctsEngine {
public:
    MctsEngine(int computation_budget, double exploration_constant, std::optional<unsigned int> seed)
        : computation_budget_(computation_budget),
          exploration_constant_(exploration_constant),
          rng_(seed ? *seed : std::random_device{}()) {}

    std::vector<int> solve(const State& root_state, int num_virtual_nodes) {
        auto root = std::make_shared<TreeNode>(root_state);
        std::vector<int> placements;
        placements.reserve(num_virtual_nodes);

        for (int step = 0; step < num_virtual_nodes; ++step) {
            auto next_node = search(root);
            if (!next_node) {
                return {};
            }

            int selected = next_node->state.physical_node_choice();
            if (selected == -1) {
                return {};
            }

            placements.push_back(selected);
            root = std::move(next_node);
            root->parent.reset();
        }

        return placements;
    }

private:
    std::shared_ptr<TreeNode> search(const std::shared_ptr<TreeNode>& root) {
        for (int i = 0; i < computation_budget_; ++i) {
            auto leaf = select_and_expand(root);
            if (!leaf) {
                break;
            }
            double reward = simulate(leaf->state);
            backpropagate(leaf, reward);
        }
        return best_child(root, /*is_exploration=*/false);
    }

    std::shared_ptr<TreeNode> select_and_expand(std::shared_ptr<TreeNode> node) {
        while (!node->state.is_terminal()) {
            if (node->is_fully_expanded()) {
                auto best = best_child(node, /*is_exploration=*/true);
                if (!best) {
                    return nullptr;
                }
                node = std::move(best);
            } else {
                return expand(node);
            }
        }
        return node;
    }

    std::shared_ptr<TreeNode> expand(const std::shared_ptr<TreeNode>& node) {
        std::vector<int> tried;
        tried.reserve(node->children.size());
        for (const auto& child : node->children) {
            tried.push_back(child->state.physical_node_choice());
        }
        State child_state = node->state.random_select_next_state(rng_, tried);
        auto child = std::make_shared<TreeNode>(child_state, node);
        node->children.push_back(child);
        return child;
    }

    double simulate(State state) {
        while (!state.is_terminal()) {
            std::vector<int> tried;
            state = state.random_select_next_state(rng_, tried);
        }
        return state.compute_final_reward();
    }

    void backpropagate(std::shared_ptr<TreeNode> node, double reward) {
        while (node) {
            node->visit_times += 1;
            if (!std::isinf(reward)) {
                node->value_sum += reward;
            }
            node = node->parent;
        }
    }

    std::shared_ptr<TreeNode> best_child(const std::shared_ptr<TreeNode>& node, bool is_exploration) {
        std::shared_ptr<TreeNode> best;
        double best_score = -std::numeric_limits<double>::infinity();

        for (const auto& child : node->children) {
            if (child->visit_times == 0) {
                continue;
            }
            double exploitation = child->value_sum / static_cast<double>(child->visit_times);
            double exploration = 0.0;
            if (is_exploration) {
                exploration = exploration_constant_ *
                              std::sqrt(std::log(static_cast<double>(node->visit_times)) /
                                        static_cast<double>(child->visit_times));
            }
            double score = exploitation + exploration;
            if (score > best_score) {
                best_score = score;
                best = child;
            }
        }
        return best;
    }

    int computation_budget_;
    double exploration_constant_;
    std::mt19937 rng_;
};

}  // namespace

py::list run_mcts(py::object controller,
                  py::object counter,
                  py::object v_net,
                  py::object p_net,
                  int computation_budget,
                  double exploration_constant,
                  std::optional<unsigned int> seed,
                  const std::string& shortest_method,
                  int k_shortest) {
    // Extract data WITH GIL
    std::shared_ptr<NetworkCache> cache;
    PureCppState root_state = [&]() {
        py::gil_scoped_acquire gil;
        cache = std::make_shared<NetworkCache>(
            extract_network_data(v_net, p_net, controller, shortest_method, k_shortest));
        return PureCppState(cache);
    }();

    // RUN ENTIRE MCTS WITHOUT GIL!
    std::vector<int> placements;
    {
        py::gil_scoped_release release;  // Release GIL for entire search
        PureCppMctsEngine engine(computation_budget, exploration_constant, seed);
        placements = engine.solve(root_state, cache->num_v_nodes);
        // NO GIL REACQUISITION DURING SEARCH!
    }

    // Return results WITH GIL
    py::gil_scoped_acquire gil_return;
    py::list result;
    for (int value : placements) {
        result.append(py::int_(value));
    }
    return result;
}

PYBIND11_MODULE(mcts_cpp_core, m) {
    m.doc() = "High-performance MCTS backend for the heuristic solver";
    m.def("run_mcts", &run_mcts,
          py::arg("controller"),
          py::arg("counter"),
          py::arg("v_net"),
          py::arg("p_net"),
          py::arg("computation_budget"),
          py::arg("exploration_constant"),
          py::arg("seed") = py::none(),
          py::arg("shortest_method") = std::string("bfs_shortest"),
          py::arg("k_shortest") = 1,
          "Execute the Monte Carlo Tree Search and return the chosen physical node ids.");
}
