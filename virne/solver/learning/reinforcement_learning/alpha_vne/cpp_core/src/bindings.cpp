#include "mcts_engine.hpp"
#include "policy_network.hpp"
#include "network.hpp"
#include "solver.hpp"
#include "vnr_state.hpp"
#include "state.hpp"

#include <pybind11/functional.h>
#include <pybind11/pybind11.h>
#include <pybind11/stl.h>
#include <pybind11/stl_bind.h>
#include <torch/extension.h>

namespace py = pybind11;

namespace azsfc {
namespace {

StateView::TensorMap dict_to_tensor_map(const py::dict& dict) {
    StateView::TensorMap result;
    for (const auto& item : dict) {
        auto key = item.first.cast<std::string>();
        auto tensor = item.second.cast<torch::Tensor>();
        result.emplace(std::move(key), std::move(tensor));
    }
    return result;
}

py::dict tensor_map_to_dict(const StateView::TensorMap& map) {
    py::dict dict;
    for (const auto& [key, tensor] : map) {
        dict[py::str(key)] = tensor;
    }
    return dict;
}

}  // namespace
}  // namespace azsfc

PYBIND11_MODULE(alpha_zero_cpp_core, m) {
    namespace az = azsfc;

    py::class_<az::StateView, std::shared_ptr<az::StateView>>(m, "StateView")
        .def(py::init<>())
        .def(py::init<std::int64_t>(), py::arg("id"))
        .def_readwrite("id", &az::StateView::id)
        .def_readwrite("step_index", &az::StateView::step_index)
        .def_readwrite("curr_v_node_override", &az::StateView::curr_v_node_override)
        .def_property("features",
            [](az::StateView& self) { return azsfc::tensor_map_to_dict(self.features); },
            [](az::StateView& self, const py::dict& dict) { self.features = azsfc::dict_to_tensor_map(dict); })
        .def_property("action_mask",
            [](az::StateView& self) { return self.action_mask; },
            [](az::StateView& self, const torch::Tensor& tensor) { self.action_mask = tensor; })
        .def_property("policy_logits",
            [](az::StateView& self) { return self.policy_logits; },
            [](az::StateView& self, const torch::Tensor& tensor) { self.policy_logits = tensor; })
        .def_property("value",
            [](az::StateView& self) { return self.value; },
            [](az::StateView& self, const torch::Tensor& tensor) { self.value = tensor; })
        .def("num_actions", &az::StateView::num_actions)
        .def_readwrite("domain_state", &az::StateView::domain_state);

    py::class_<az::Network, std::shared_ptr<az::Network>>(m, "Network")
        .def(py::init<>())
        .def_readwrite("num_nodes", &az::Network::num_nodes)
        .def_readwrite("num_edges", &az::Network::num_edges)
        .def_readwrite("directed", &az::Network::directed)
        .def_readwrite("reverse_edge_pairs_share_capacity", &az::Network::reverse_edge_pairs_share_capacity)
        .def("set_num_nodes", &az::Network::set_num_nodes, py::arg("num_nodes"))
        .def("set_edges", &az::Network::set_edges, py::arg("edges"), py::arg("is_directed") = false)
        .def("set_node_attrs", &az::Network::set_node_attrs, py::arg("attrs"))
        .def("set_edge_attrs", &az::Network::set_edge_attrs, py::arg("attrs"))
        .def_readonly("adjacency", &az::Network::adjacency)
        .def_readonly("edges", &az::Network::edges)
        .def_readonly("edge_index", &az::Network::edge_index);

    py::class_<az::VNRConfig>(m, "VNRConfig")
        .def(py::init<>())
        .def_readwrite("node_resource_names", &az::VNRConfig::node_resource_names)
        .def_readwrite("link_resource_names", &az::VNRConfig::link_resource_names)
        .def_readwrite("node_attr_benchmarks", &az::VNRConfig::node_attr_benchmarks)
        .def_readwrite("link_attr_benchmarks", &az::VNRConfig::link_attr_benchmarks)
        .def_readwrite("link_sum_attr_benchmarks", &az::VNRConfig::link_sum_attr_benchmarks)
        .def_readwrite("node_constraint_names", &az::VNRConfig::node_constraint_names)
        .def_readwrite("hard_constraint_names", &az::VNRConfig::hard_constraint_names)
        .def_readwrite("feature_use_node_status_flags", &az::VNRConfig::feature_use_node_status_flags)
        .def_readwrite("feature_use_aggregated_link_attrs", &az::VNRConfig::feature_use_aggregated_link_attrs)
        .def_readwrite("feature_use_degree_metric", &az::VNRConfig::feature_use_degree_metric)
        .def_readwrite("feature_use_more_topological_metrics", &az::VNRConfig::feature_use_more_topological_metrics)
        .def_readwrite("allow_rejection", &az::VNRConfig::allow_rejection)
        .def_readwrite("reject_penalty", &az::VNRConfig::reject_penalty)
        .def_readwrite("shortest_method", &az::VNRConfig::shortest_method)
        .def_readwrite("k_shortest", &az::VNRConfig::k_shortest);

    py::class_<az::VNRState, std::shared_ptr<az::VNRState>>(m, "VNRState")
        .def(py::init<std::shared_ptr<const az::Network>,
                      std::shared_ptr<const az::Network>,
                      az::VNRConfig>(),
             py::arg("physical"),
             py::arg("virtual_net"),
             py::arg("config"))
        .def("get_candidate_nodes", &az::VNRState::get_candidate_nodes, py::call_guard<py::gil_scoped_release>())
        .def("build_candidate_feature_tensor", &az::VNRState::build_candidate_feature_tensor, py::call_guard<py::gil_scoped_release>())
        .def("candidate_feature_dim", &az::VNRState::candidate_feature_dim)
        .def("is_terminal", &az::VNRState::is_terminal)
        .def("compute_final_reward", &az::VNRState::compute_final_reward)
        .def("create_child", &az::VNRState::create_child, py::call_guard<py::gil_scoped_release>())
        .def("get_available_node_resource", &az::VNRState::get_available_node_resource)
        .def("get_available_link_resource",
             py::overload_cast<int, const std::string&>(&az::VNRState::get_available_link_resource, py::const_))
        .def("get_available_link_resource",
             py::overload_cast<int, int, const std::string&>(&az::VNRState::get_available_link_resource, py::const_))
        .def("get_allocated_node_resources", &az::VNRState::get_allocated_node_resources)
        .def("get_allocated_link_resources", &az::VNRState::get_allocated_link_resources)
        .def("debug_find_paths", &az::VNRState::debug_find_paths)
        .def_property_readonly("selected_physical_nodes", &az::VNRState::selected_physical_nodes)
        .def_property_readonly("virtual_order", &az::VNRState::virtual_order)
        .def_property_readonly("current_virtual_index", &az::VNRState::current_virtual_index)
        .def_property_readonly("last_physical_node", &az::VNRState::last_physical_node)
        .def_property_readonly("rejected", &az::VNRState::rejected);

    py::class_<az::EvaluationResult>(m, "EvaluationResult")
        .def_readwrite("policy_logits", &az::EvaluationResult::policy_logits)
        .def_readwrite("value", &az::EvaluationResult::value);

    py::class_<az::SearchConfig>(m, "SearchConfig")
        .def(py::init<>())
        .def_readwrite("simulations", &az::SearchConfig::simulations)
        .def_readwrite("c_puct", &az::SearchConfig::c_puct)
        .def_readwrite("dirichlet_alpha", &az::SearchConfig::dirichlet_alpha)
        .def_readwrite("dirichlet_epsilon", &az::SearchConfig::dirichlet_epsilon)
        .def_readwrite("top_k_candidates", &az::SearchConfig::top_k_candidates)
        .def_readwrite("virtual_loss", &az::SearchConfig::virtual_loss)
        .def_readwrite("add_root_noise", &az::SearchConfig::add_root_noise)
        .def_readwrite("use_neural_network", &az::SearchConfig::use_neural_network)
        .def_readwrite("rollout_depth_limit", &az::SearchConfig::rollout_depth_limit)
        .def_readwrite("eval_batch_size", &az::SearchConfig::eval_batch_size)
        .def_readwrite("value_normalization", &az::SearchConfig::value_normalization)
        .def_readwrite("value_scale", &az::SearchConfig::value_scale);

    py::class_<az::SearchResult>(m, "SearchResult")
        .def_readonly("visit_counts", &az::SearchResult::visit_counts)
        .def_readonly("policy", &az::SearchResult::policy)
        .def_readonly("root_priors", &az::SearchResult::root_priors)
        .def_readonly("value", &az::SearchResult::value);

    py::class_<az::MCTSEngine>(m, "MCTSEngine")
        .def(py::init<az::SearchConfig>())
        .def("set_callbacks", [](az::MCTSEngine& engine,
                                  py::function expand,
                                  py::function evaluate,
                                  py::function terminal_value,
                                  py::function terminal_check) {
                engine.set_expand_callback([expand](const std::shared_ptr<az::StateView>& state) {
                    py::gil_scoped_acquire gil;
                    py::object result = expand(state);
                    std::vector<std::pair<int64_t, std::shared_ptr<az::StateView>>> out;
                    for (auto item : result) {
                        auto tuple = item.cast<py::tuple>();
                        int64_t action = tuple[0].cast<int64_t>();
                        auto child_state = tuple[1].cast<std::shared_ptr<az::StateView>>();
                        out.emplace_back(action, std::move(child_state));
                    }
                    return out;
                });

                engine.set_evaluate_callback([evaluate](const std::shared_ptr<az::StateView>& state) {
                    py::gil_scoped_acquire gil;
                    auto result = evaluate(state).cast<py::tuple>();
                    az::EvaluationResult eval;
                    eval.policy_logits = result[0].cast<torch::Tensor>();
                    eval.value = result[1].cast<torch::Tensor>();
                    return eval;
                });

                engine.set_terminal_value_callback([terminal_value](const std::shared_ptr<az::StateView>& state) {
                    py::gil_scoped_acquire gil;
                    return terminal_value(state).cast<float>();
                });

                engine.set_terminal_check_callback([terminal_check](const std::shared_ptr<az::StateView>& state) {
                    py::gil_scoped_acquire gil;
                    return terminal_check(state).cast<bool>();
                });
            })
        .def("run_search",
            [](az::MCTSEngine& engine, const std::shared_ptr<az::StateView>& root_state, py::object seed_obj) {
                std::optional<unsigned int> seed;
                if (!seed_obj.is_none()) {
                    seed = seed_obj.cast<unsigned int>();
                }
                py::gil_scoped_release release;
                return engine.run_search(root_state, seed);
            },
            py::arg("root_state"),
            py::arg("seed") = py::none())
        .def("reset_tree", &az::MCTSEngine::reset_tree, py::arg("root_state"))
        .def("clear_tree", &az::MCTSEngine::clear_tree)
        .def("advance_tree", &az::MCTSEngine::advance_tree, py::arg("action"))
        .def("tree_root_state", &az::MCTSEngine::tree_root_state)
        .def("run_search_tree",
            [](az::MCTSEngine& engine, py::object seed_obj) {
                std::optional<unsigned int> seed;
                if (!seed_obj.is_none()) {
                    seed = seed_obj.cast<unsigned int>();
                }
                py::gil_scoped_release release;
                return engine.run_search_tree(seed);
            },
            py::arg("seed") = py::none());

    py::class_<az::PolicyNetwork>(m, "PolicyNetwork")
        .def(py::init<>())
        .def(py::init<const std::string&, torch::Device>())
        .def("load",
             [](az::PolicyNetwork& self, const std::string& model_path, py::object device_obj) {
                 torch::Device device = torch::kCUDA;
                 if (!device_obj.is_none()) {
                     device = device_obj.cast<torch::Device>();
                 }
                 self.load(model_path, device);
             },
             py::arg("model_path"),
             py::arg("device") = py::none())
        .def("evaluate", &az::PolicyNetwork::evaluate, py::arg("features"))
        .def("encode", &az::PolicyNetwork::encode, py::arg("v_net_x"));

    m.def(
        "solve",
        [](const std::vector<std::unordered_map<std::string, double>>& p_node_attrs,
           const std::vector<std::pair<int, int>>& p_edges,
           const std::vector<std::unordered_map<std::string, double>>& p_edge_attrs,
           bool p_directed,
           bool p_reverse_edge_pairs_share_capacity,
           const std::vector<std::unordered_map<std::string, double>>& v_node_attrs,
           const std::vector<std::pair<int, int>>& v_edges,
           const std::vector<std::unordered_map<std::string, double>>& v_edge_attrs,
           bool v_directed,
           bool v_reverse_edge_pairs_share_capacity,
           az::VNRConfig vnr_config,
           az::SearchConfig search_config,
           const std::string& policy_path,
           const std::string& policy_meta_path,
           const std::string& device,
           py::object seed_obj,
           float temperature,
           int temperature_move_threshold,
           float temperature_after_threshold,
           float replay_policy_temperature,
           bool use_nn_policy,
           bool use_nn_value,
           bool write_replay,
           const std::string& replay_dir,
           int max_buffer_size) {
            az::Network p_net;
            p_net.set_num_nodes(static_cast<int>(p_node_attrs.size()));
            p_net.set_edges(p_edges, p_directed);
            p_net.reverse_edge_pairs_share_capacity = p_reverse_edge_pairs_share_capacity;
            p_net.set_node_attrs(p_node_attrs);
            if (!p_edge_attrs.empty()) {
                p_net.set_edge_attrs(p_edge_attrs);
            }

            az::Network v_net;
            v_net.set_num_nodes(static_cast<int>(v_node_attrs.size()));
            v_net.set_edges(v_edges, v_directed);
            v_net.reverse_edge_pairs_share_capacity = v_reverse_edge_pairs_share_capacity;
            v_net.set_node_attrs(v_node_attrs);
            if (!v_edge_attrs.empty()) {
                v_net.set_edge_attrs(v_edge_attrs);
            }

            std::optional<unsigned int> seed;
            if (!seed_obj.is_none()) {
                seed = seed_obj.cast<unsigned int>();
            }

            auto result = az::solve_vnr(
                p_net,
                v_net,
                vnr_config,
                search_config,
                policy_path,
                policy_meta_path,
                device,
                seed,
                temperature,
                temperature_move_threshold,
                temperature_after_threshold,
                replay_policy_temperature,
                use_nn_policy,
                use_nn_value,
                write_replay,
                replay_dir,
                max_buffer_size
            );

            py::dict out;
            out["actions"] = result.actions;
            out["policies"] = result.policies;
            out["visit_counts"] = result.visit_counts;
            out["values"] = result.values;
            out["rejected"] = result.rejected;
            out["place_result"] = result.place_result;
            out["route_result"] = result.route_result;
            out["node_slots"] = result.node_slots;
            out["place_info"] = result.place_info;
            out["place_v_node_id"] = result.place_v_node_id;
            out["place_p_node_id"] = result.place_p_node_id;
            out["final_reward"] = result.final_reward;
            out["total_cost"] = result.total_cost;
            out["total_revenue"] = result.total_revenue;
            out["value_target"] = result.value_target;
            out["replay_written"] = result.replay_written;
            out["replay_path"] = result.replay_path;
            out["replay_error"] = result.replay_error;
            py::dict link_paths;
            py::dict link_paths_info;
            for (const auto& record : result.link_mapping) {
                py::tuple v_key = py::make_tuple(record.v_src, record.v_dst);
                py::list p_links;
                for (std::size_t i = 0; i < record.p_links.size(); ++i) {
                    const auto& p_link = record.p_links[i];
                    py::tuple p_key = py::make_tuple(p_link.first, p_link.second);
                    p_links.append(p_key);
                    if (i < record.p_link_resources.size()) {
                        py::tuple info_key = py::make_tuple(v_key, p_key);
                        link_paths_info[info_key] = record.p_link_resources[i];
                    }
                }
                link_paths[v_key] = p_links;
            }
            out["link_paths"] = link_paths;
            out["link_paths_info"] = link_paths_info;
            py::dict metrics;
            metrics["total_simulations"] = result.metrics.total_simulations;
            metrics["steps"] = result.metrics.steps;
            metrics["total_time_ms"] = result.metrics.total_time_ms;
            metrics["encode_ms"] = result.metrics.encode_ms;
            metrics["build_inputs_ms"] = result.metrics.build_inputs_ms;
            metrics["policy_eval_ms"] = result.metrics.policy_eval_ms;
            metrics["mcts_ms"] = result.metrics.mcts_ms;
            metrics["postprocess_ms"] = result.metrics.postprocess_ms;
            out["metrics"] = metrics;
            return out;
        },
        py::arg("p_node_attrs"),
        py::arg("p_edges"),
        py::arg("p_edge_attrs"),
        py::arg("p_directed"),
        py::arg("p_reverse_edge_pairs_share_capacity") = false,
        py::arg("v_node_attrs"),
        py::arg("v_edges"),
        py::arg("v_edge_attrs"),
        py::arg("v_directed"),
        py::arg("v_reverse_edge_pairs_share_capacity") = false,
        py::arg("vnr_config"),
        py::arg("search_config"),
        py::arg("policy_path"),
        py::arg("policy_meta_path") = "",
        py::arg("device") = "cpu",
        py::arg("seed") = py::none(),
        py::arg("temperature") = 1.0f,
        py::arg("temperature_move_threshold") = -1,
        py::arg("temperature_after_threshold") = 0.0f,
        py::arg("replay_policy_temperature") = 1.0f,
        py::arg("use_nn_policy") = true,
        py::arg("use_nn_value") = true,
        py::arg("write_replay") = false,
        py::arg("replay_dir") = "",
        py::arg("max_buffer_size") = 0
    );

    m.def(
        "debug_build_observation",
        [](const std::vector<std::unordered_map<std::string, double>>& p_node_attrs,
           const std::vector<std::pair<int, int>>& p_edges,
           const std::vector<std::unordered_map<std::string, double>>& p_edge_attrs,
           bool p_directed,
           bool p_reverse_edge_pairs_share_capacity,
           const std::vector<std::unordered_map<std::string, double>>& v_node_attrs,
           const std::vector<std::pair<int, int>>& v_edges,
           const std::vector<std::unordered_map<std::string, double>>& v_edge_attrs,
           bool v_directed,
           bool v_reverse_edge_pairs_share_capacity,
           az::VNRConfig vnr_config,
           const std::string& policy_path,
           const std::string& device) {
            az::Network p_net;
            p_net.set_num_nodes(static_cast<int>(p_node_attrs.size()));
            p_net.set_edges(p_edges, p_directed);
            p_net.reverse_edge_pairs_share_capacity = p_reverse_edge_pairs_share_capacity;
            p_net.set_node_attrs(p_node_attrs);
            if (!p_edge_attrs.empty()) {
                p_net.set_edge_attrs(p_edge_attrs);
            }

            az::Network v_net;
            v_net.set_num_nodes(static_cast<int>(v_node_attrs.size()));
            v_net.set_edges(v_edges, v_directed);
            v_net.reverse_edge_pairs_share_capacity = v_reverse_edge_pairs_share_capacity;
            v_net.set_node_attrs(v_node_attrs);
            if (!v_edge_attrs.empty()) {
                v_net.set_edge_attrs(v_edge_attrs);
            }

            auto obs = az::debug_build_observation(p_net, v_net, vnr_config, policy_path, device);
            py::dict out;
            out["p_net_x"] = obs.p_net_x;
            out["p_net_edge_index"] = obs.p_net_edge_index;
            out["p_net_edge_attr"] = obs.p_net_edge_attr;
            out["history_features"] = obs.history_features;
            out["encoder_outputs"] = obs.encoder_outputs;
            out["curr_v_node_id"] = obs.curr_v_node_id;
            out["vnfs_remaining"] = obs.vnfs_remaining;
            out["action_mask"] = obs.action_mask;
            out["candidate_features"] = obs.candidate_features;
            out["v_net_x"] = obs.v_net_x;
            return out;
        },
        py::arg("p_node_attrs"),
        py::arg("p_edges"),
        py::arg("p_edge_attrs"),
        py::arg("p_directed"),
        py::arg("p_reverse_edge_pairs_share_capacity") = false,
        py::arg("v_node_attrs"),
        py::arg("v_edges"),
        py::arg("v_edge_attrs"),
        py::arg("v_directed"),
        py::arg("v_reverse_edge_pairs_share_capacity") = false,
        py::arg("vnr_config"),
        py::arg("policy_path"),
        py::arg("device") = "cpu"
    );

    m.def(
        "debug_build_observation_after_actions",
        [](const std::vector<std::unordered_map<std::string, double>>& p_node_attrs,
           const std::vector<std::pair<int, int>>& p_edges,
           const std::vector<std::unordered_map<std::string, double>>& p_edge_attrs,
           bool p_directed,
           bool p_reverse_edge_pairs_share_capacity,
           const std::vector<std::unordered_map<std::string, double>>& v_node_attrs,
           const std::vector<std::pair<int, int>>& v_edges,
           const std::vector<std::unordered_map<std::string, double>>& v_edge_attrs,
           bool v_directed,
           bool v_reverse_edge_pairs_share_capacity,
           az::VNRConfig vnr_config,
           const std::vector<int>& actions,
           const std::string& policy_path,
           const std::string& device) {
            az::Network p_net;
            p_net.set_num_nodes(static_cast<int>(p_node_attrs.size()));
            p_net.set_edges(p_edges, p_directed);
            p_net.reverse_edge_pairs_share_capacity = p_reverse_edge_pairs_share_capacity;
            p_net.set_node_attrs(p_node_attrs);
            if (!p_edge_attrs.empty()) {
                p_net.set_edge_attrs(p_edge_attrs);
            }

            az::Network v_net;
            v_net.set_num_nodes(static_cast<int>(v_node_attrs.size()));
            v_net.set_edges(v_edges, v_directed);
            v_net.reverse_edge_pairs_share_capacity = v_reverse_edge_pairs_share_capacity;
            v_net.set_node_attrs(v_node_attrs);
            if (!v_edge_attrs.empty()) {
                v_net.set_edge_attrs(v_edge_attrs);
            }

            auto obs = az::debug_build_observation_after_actions(p_net, v_net, vnr_config, actions, policy_path, device);
            py::dict out;
            out["p_net_x"] = obs.p_net_x;
            out["p_net_edge_index"] = obs.p_net_edge_index;
            out["p_net_edge_attr"] = obs.p_net_edge_attr;
            out["history_features"] = obs.history_features;
            out["encoder_outputs"] = obs.encoder_outputs;
            out["curr_v_node_id"] = obs.curr_v_node_id;
            out["vnfs_remaining"] = obs.vnfs_remaining;
            out["action_mask"] = obs.action_mask;
            out["candidate_features"] = obs.candidate_features;
            out["v_net_x"] = obs.v_net_x;
            return out;
        },
        py::arg("p_node_attrs"),
        py::arg("p_edges"),
        py::arg("p_edge_attrs"),
        py::arg("p_directed"),
        py::arg("p_reverse_edge_pairs_share_capacity") = false,
        py::arg("v_node_attrs"),
        py::arg("v_edges"),
        py::arg("v_edge_attrs"),
        py::arg("v_directed"),
        py::arg("v_reverse_edge_pairs_share_capacity") = false,
        py::arg("vnr_config"),
        py::arg("actions"),
        py::arg("policy_path"),
        py::arg("device") = "cpu"
    );

    m.def(
        "debug_evaluate_root",
        [](const std::vector<std::unordered_map<std::string, double>>& p_node_attrs,
           const std::vector<std::pair<int, int>>& p_edges,
           const std::vector<std::unordered_map<std::string, double>>& p_edge_attrs,
           bool p_directed,
           bool p_reverse_edge_pairs_share_capacity,
           const std::vector<std::unordered_map<std::string, double>>& v_node_attrs,
           const std::vector<std::pair<int, int>>& v_edges,
           const std::vector<std::unordered_map<std::string, double>>& v_edge_attrs,
           bool v_directed,
           bool v_reverse_edge_pairs_share_capacity,
           az::VNRConfig vnr_config,
           const std::string& policy_path,
           const std::string& device) {
            az::Network p_net;
            p_net.set_num_nodes(static_cast<int>(p_node_attrs.size()));
            p_net.set_edges(p_edges, p_directed);
            p_net.reverse_edge_pairs_share_capacity = p_reverse_edge_pairs_share_capacity;
            p_net.set_node_attrs(p_node_attrs);
            if (!p_edge_attrs.empty()) {
                p_net.set_edge_attrs(p_edge_attrs);
            }

            az::Network v_net;
            v_net.set_num_nodes(static_cast<int>(v_node_attrs.size()));
            v_net.set_edges(v_edges, v_directed);
            v_net.reverse_edge_pairs_share_capacity = v_reverse_edge_pairs_share_capacity;
            v_net.set_node_attrs(v_node_attrs);
            if (!v_edge_attrs.empty()) {
                v_net.set_edge_attrs(v_edge_attrs);
            }

            auto eval = az::debug_evaluate_root(p_net, v_net, vnr_config, policy_path, device);
            py::dict out;
            out["policy_logits"] = eval.policy_logits;
            out["value"] = eval.value;
            return out;
        },
        py::arg("p_node_attrs"),
        py::arg("p_edges"),
        py::arg("p_edge_attrs"),
        py::arg("p_directed"),
        py::arg("p_reverse_edge_pairs_share_capacity") = false,
        py::arg("v_node_attrs"),
        py::arg("v_edges"),
        py::arg("v_edge_attrs"),
        py::arg("v_directed"),
        py::arg("v_reverse_edge_pairs_share_capacity") = false,
        py::arg("vnr_config"),
        py::arg("policy_path"),
        py::arg("device") = "cpu"
    );

    m.def(
        "debug_evaluate_after_actions",
        [](const std::vector<std::unordered_map<std::string, double>>& p_node_attrs,
           const std::vector<std::pair<int, int>>& p_edges,
           const std::vector<std::unordered_map<std::string, double>>& p_edge_attrs,
           bool p_directed,
           bool p_reverse_edge_pairs_share_capacity,
           const std::vector<std::unordered_map<std::string, double>>& v_node_attrs,
           const std::vector<std::pair<int, int>>& v_edges,
           const std::vector<std::unordered_map<std::string, double>>& v_edge_attrs,
           bool v_directed,
           bool v_reverse_edge_pairs_share_capacity,
           az::VNRConfig vnr_config,
           const std::vector<int>& actions,
           const std::string& policy_path,
           const std::string& device) {
            az::Network p_net;
            p_net.set_num_nodes(static_cast<int>(p_node_attrs.size()));
            p_net.set_edges(p_edges, p_directed);
            p_net.reverse_edge_pairs_share_capacity = p_reverse_edge_pairs_share_capacity;
            p_net.set_node_attrs(p_node_attrs);
            if (!p_edge_attrs.empty()) {
                p_net.set_edge_attrs(p_edge_attrs);
            }

            az::Network v_net;
            v_net.set_num_nodes(static_cast<int>(v_node_attrs.size()));
            v_net.set_edges(v_edges, v_directed);
            v_net.reverse_edge_pairs_share_capacity = v_reverse_edge_pairs_share_capacity;
            v_net.set_node_attrs(v_node_attrs);
            if (!v_edge_attrs.empty()) {
                v_net.set_edge_attrs(v_edge_attrs);
            }

            auto eval = az::debug_evaluate_after_actions(p_net, v_net, vnr_config, actions, policy_path, device);
            py::dict out;
            out["policy_logits"] = eval.policy_logits;
            out["value"] = eval.value;
            return out;
        },
        py::arg("p_node_attrs"),
        py::arg("p_edges"),
        py::arg("p_edge_attrs"),
        py::arg("p_directed"),
        py::arg("p_reverse_edge_pairs_share_capacity") = false,
        py::arg("v_node_attrs"),
        py::arg("v_edges"),
        py::arg("v_edge_attrs"),
        py::arg("v_directed"),
        py::arg("v_reverse_edge_pairs_share_capacity") = false,
        py::arg("vnr_config"),
        py::arg("actions"),
        py::arg("policy_path"),
        py::arg("device") = "cpu"
    );

    m.def(
        "debug_search_after_actions",
        [](const std::vector<std::unordered_map<std::string, double>>& p_node_attrs,
           const std::vector<std::pair<int, int>>& p_edges,
           const std::vector<std::unordered_map<std::string, double>>& p_edge_attrs,
           bool p_directed,
           bool p_reverse_edge_pairs_share_capacity,
           const std::vector<std::unordered_map<std::string, double>>& v_node_attrs,
           const std::vector<std::pair<int, int>>& v_edges,
           const std::vector<std::unordered_map<std::string, double>>& v_edge_attrs,
           bool v_directed,
           bool v_reverse_edge_pairs_share_capacity,
           az::VNRConfig vnr_config,
           az::SearchConfig search_config,
           const std::vector<int>& actions,
           const std::string& policy_path,
           const std::string& device) {
            az::Network p_net;
            p_net.set_num_nodes(static_cast<int>(p_node_attrs.size()));
            p_net.set_edges(p_edges, p_directed);
            p_net.reverse_edge_pairs_share_capacity = p_reverse_edge_pairs_share_capacity;
            p_net.set_node_attrs(p_node_attrs);
            if (!p_edge_attrs.empty()) {
                p_net.set_edge_attrs(p_edge_attrs);
            }

            az::Network v_net;
            v_net.set_num_nodes(static_cast<int>(v_node_attrs.size()));
            v_net.set_edges(v_edges, v_directed);
            v_net.reverse_edge_pairs_share_capacity = v_reverse_edge_pairs_share_capacity;
            v_net.set_node_attrs(v_node_attrs);
            if (!v_edge_attrs.empty()) {
                v_net.set_edge_attrs(v_edge_attrs);
            }

            return az::debug_search_after_actions(p_net, v_net, vnr_config, search_config, actions, policy_path, device);
        },
        py::arg("p_node_attrs"),
        py::arg("p_edges"),
        py::arg("p_edge_attrs"),
        py::arg("p_directed"),
        py::arg("p_reverse_edge_pairs_share_capacity") = false,
        py::arg("v_node_attrs"),
        py::arg("v_edges"),
        py::arg("v_edge_attrs"),
        py::arg("v_directed"),
        py::arg("v_reverse_edge_pairs_share_capacity") = false,
        py::arg("vnr_config"),
        py::arg("search_config"),
        py::arg("actions"),
        py::arg("policy_path"),
        py::arg("device") = "cpu"
    );
}
