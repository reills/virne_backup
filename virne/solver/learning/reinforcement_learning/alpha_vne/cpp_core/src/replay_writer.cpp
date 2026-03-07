#include "replay_writer.hpp"

#include <algorithm>
#include <chrono>
#include <cstdint>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <cmath>
#include <random>
#include <string>
#include <unistd.h>

namespace azsfc {
namespace {

template <typename T>
void write_indent(std::ostream& os, T indent) {
    for (T i = 0; i < indent; ++i) {
        os.put(' ');
    }
}

void write_string(std::ostream& os, const std::string& value) {
    os.put('\"');
    for (char c : value) {
        switch (c) {
        case '\"':
            os << "\\\"";
            break;
        case '\\':
            os << "\\\\";
            break;
        case '\b':
            os << "\\b";
            break;
        case '\f':
            os << "\\f";
            break;
        case '\n':
            os << "\\n";
            break;
        case '\r':
            os << "\\r";
            break;
        case '\t':
            os << "\\t";
            break;
        default:
            if (static_cast<unsigned char>(c) < 0x20) {
                os << "\\u" << std::hex << std::setw(4) << std::setfill('0')
                   << static_cast<int>(static_cast<unsigned char>(c)) << std::dec;
            } else {
                os.put(c);
            }
        }
    }
    os.put('\"');
}

void write_float(std::ostream& os, double value) {
    if (std::isfinite(value)) {
        os.setf(std::ios::fmtflags(0), std::ios::floatfield);
        os << std::setprecision(15) << value;
    } else if (std::isnan(value)) {
        os << "null";
    } else if (value > 0) {
        os << "1e309";
    } else {
        os << "-1e309";
    }
}

void write_bool(std::ostream& os, bool value) {
    os << (value ? "true" : "false");
}

void write_tensor_flat(std::ostream& os, const torch::Tensor& tensor) {
    auto cpu = tensor.to(torch::kCPU).contiguous();
    auto flat = cpu.view({-1});
    os.put('[');
    if (flat.numel() > 0) {
        if (flat.scalar_type() == torch::kInt64) {
            auto acc = flat.accessor<std::int64_t, 1>();
            for (int64_t i = 0; i < flat.numel(); ++i) {
                if (i) os << ", ";
                os << acc[i];
            }
        } else if (flat.scalar_type() == torch::kBool) {
            auto acc = flat.accessor<bool, 1>();
            for (int64_t i = 0; i < flat.numel(); ++i) {
                if (i) os << ", ";
                write_bool(os, acc[i]);
            }
        } else {
            auto acc = flat.accessor<float, 1>();
            for (int64_t i = 0; i < flat.numel(); ++i) {
                if (i) os << ", ";
                write_float(os, acc[i]);
            }
        }
    }
    os.put(']');
}

void write_tensor_2d(std::ostream& os, const torch::Tensor& tensor) {
    auto cpu = tensor.to(torch::kCPU).contiguous();
    auto sizes = cpu.sizes();
    if (sizes.size() != 2) {
        write_tensor_flat(os, cpu);
        return;
    }
    const int64_t rows = sizes[0];
    const int64_t cols = sizes[1];
    os.put('[');
    for (int64_t r = 0; r < rows; ++r) {
        if (r) os << ", ";
        os.put('[');
        for (int64_t c = 0; c < cols; ++c) {
            if (c) os << ", ";
            if (cpu.scalar_type() == torch::kInt64) {
                os << cpu.index({r, c}).item<std::int64_t>();
            } else if (cpu.scalar_type() == torch::kBool) {
                write_bool(os, cpu.index({r, c}).item<bool>());
            } else {
                write_float(os, cpu.index({r, c}).item<float>());
            }
        }
        os.put(']');
    }
    os.put(']');
}

void write_tensor_3d(std::ostream& os, const torch::Tensor& tensor) {
    auto cpu = tensor.to(torch::kCPU).contiguous();
    auto sizes = cpu.sizes();
    if (sizes.size() != 3) {
        write_tensor_flat(os, cpu);
        return;
    }
    const int64_t d0 = sizes[0];
    const int64_t d1 = sizes[1];
    const int64_t d2 = sizes[2];
    os.put('[');
    for (int64_t i = 0; i < d0; ++i) {
        if (i) os << ", ";
        os.put('[');
        for (int64_t j = 0; j < d1; ++j) {
            if (j) os << ", ";
            os.put('[');
            for (int64_t k = 0; k < d2; ++k) {
                if (k) os << ", ";
                write_float(os, cpu.index({i, j, k}).item<float>());
            }
            os.put(']');
        }
        os.put(']');
    }
    os.put(']');
}

void write_observation(std::ostream& os, const Observation& obs, int indent) {
    write_indent(os, indent);
    os << "{\n";

    write_indent(os, indent + 2);
    write_string(os, "p_net");
    os << ": {\n";

    write_indent(os, indent + 4);
    write_string(os, "x");
    os << ": ";
    write_tensor_2d(os, obs.p_net_x);
    os << ",\n";

    write_indent(os, indent + 4);
    write_string(os, "edge_index");
    os << ": ";
    write_tensor_2d(os, obs.p_net_edge_index);
    os << ",\n";

    write_indent(os, indent + 4);
    write_string(os, "edge_attr");
    os << ": ";
    if (obs.p_net_edge_attr.defined()) {
        write_tensor_2d(os, obs.p_net_edge_attr);
    } else {
        os << "null";
    }
    os << ",\n";

    write_indent(os, indent + 4);
    write_string(os, "num_nodes");
    os << ": " << obs.p_net_num_nodes << "\n";

    write_indent(os, indent + 2);
    os << "},\n";

    write_indent(os, indent + 2);
    write_string(os, "history_features");
    os << ": ";
    write_tensor_3d(os, obs.history_features);
    os << ",\n";

    write_indent(os, indent + 2);
    write_string(os, "encoder_outputs");
    os << ": ";
    write_tensor_3d(os, obs.encoder_outputs);
    os << ",\n";

    write_indent(os, indent + 2);
    write_string(os, "curr_v_node_id");
    os << ": ";
    write_tensor_flat(os, obs.curr_v_node_id);
    os << ",\n";

    write_indent(os, indent + 2);
    write_string(os, "vnfs_remaining");
    os << ": ";
    write_tensor_flat(os, obs.vnfs_remaining);
    os << ",\n";

    write_indent(os, indent + 2);
    write_string(os, "action_mask");
    os << ": ";
    write_tensor_2d(os, obs.action_mask);
    os << ",\n";

    write_indent(os, indent + 2);
    write_string(os, "v_net_x");
    os << ": ";
    write_tensor_3d(os, obs.v_net_x);
    os << "\n";

    write_indent(os, indent);
    os << "}";
}

void write_static_environment(std::ostream& os, const StaticEnvironment& env, int indent) {
    write_indent(os, indent);
    os << "{\n";

    write_indent(os, indent + 2);
    write_string(os, "physical_network");
    os << ": {\n";

    write_indent(os, indent + 4);
    write_string(os, "nodes");
    os << ": [";
    for (std::size_t i = 0; i < env.physical_nodes.size(); ++i) {
        if (i) os << ", ";
        const auto& node = env.physical_nodes[i];
        os << "{";
        write_string(os, "id");
        os << ": " << node.id << ", ";
        write_string(os, "max_cpu");
        os << ": ";
        write_float(os, node.value);
        os << "}";
    }
    os << "],\n";

    write_indent(os, indent + 4);
    write_string(os, "links");
    os << ": [";
    for (std::size_t i = 0; i < env.physical_links.size(); ++i) {
        if (i) os << ", ";
        const auto& link = env.physical_links[i];
        os << "{";
        write_string(os, "source");
        os << ": " << link.source << ", ";
        write_string(os, "target");
        os << ": " << link.target << ", ";
        write_string(os, "max_bw");
        os << ": ";
        write_float(os, link.value);
        os << "}";
    }
    os << "]\n";
    write_indent(os, indent + 2);
    os << "},\n";

    write_indent(os, indent + 2);
    write_string(os, "sfc_request");
    os << ": {\n";

    write_indent(os, indent + 4);
    write_string(os, "nodes");
    os << ": [";
    for (std::size_t i = 0; i < env.sfc_nodes.size(); ++i) {
        if (i) os << ", ";
        const auto& node = env.sfc_nodes[i];
        os << "{";
        write_string(os, "id");
        os << ": " << node.id << ", ";
        write_string(os, "cpu_demand");
        os << ": ";
        write_float(os, node.value);
        os << "}";
    }
    os << "],\n";

    write_indent(os, indent + 4);
    write_string(os, "links");
    os << ": [";
    for (std::size_t i = 0; i < env.sfc_links.size(); ++i) {
        if (i) os << ", ";
        const auto& link = env.sfc_links[i];
        os << "{";
        write_string(os, "source");
        os << ": " << link.source << ", ";
        write_string(os, "target");
        os << ": " << link.target << ", ";
        write_string(os, "bw_demand");
        os << ": ";
        write_float(os, link.value);
        os << "}";
    }
    os << "]\n";

    write_indent(os, indent + 2);
    os << "}\n";

    write_indent(os, indent);
    os << "}";
}

void write_policy_model(std::ostream& os, const ReplayEpisode& episode, int indent) {
    write_indent(os, indent);
    write_string(os, "model");
    os << ": {\n";
    write_indent(os, indent + 2);
    write_string(os, "policy_path");
    os << ": ";
    if (episode.policy_path.empty()) {
        os << "null";
    } else {
        write_string(os, episode.policy_path);
    }
    os << ",\n";

    write_indent(os, indent + 2);
    write_string(os, "sha256");
    os << ": ";
    if (episode.policy_sha.has_value()) {
        write_string(os, episode.policy_sha.value());
    } else {
        os << "null";
    }
    os << ",\n";

    write_indent(os, indent + 2);
    write_string(os, "mtime");
    os << ": ";
    if (episode.policy_mtime.has_value()) {
        write_float(os, episode.policy_mtime.value());
    } else {
        os << "null";
    }
    os << "\n";
    write_indent(os, indent);
    os << "}";
}

ReplayWriteResult write_episode_file(const ReplayEpisode& episode, const std::string& replay_dir) {
    ReplayWriteResult result;
    try {
        std::filesystem::create_directories(replay_dir);
    } catch (const std::exception& exc) {
        result.error = exc.what();
        return result;
    }

    auto now = std::chrono::high_resolution_clock::now().time_since_epoch();
    auto ns = std::chrono::duration_cast<std::chrono::nanoseconds>(now).count();
    std::random_device rd;
    std::mt19937 rng(rd());
    std::uniform_int_distribution<int> dist(0, 15);
    std::string random_hex;
    random_hex.reserve(32);
    for (int i = 0; i < 32; ++i) {
        int v = dist(rng);
        random_hex.push_back("0123456789abcdef"[v]);
    }

    std::string tmp_name = "episode_" + std::to_string(ns) + "_tmp.json";
    std::string tmp_path = (std::filesystem::path(replay_dir) / tmp_name).string();
    std::ofstream out(tmp_path, std::ios::out | std::ios::trunc);
    if (!out.is_open()) {
        result.error = "Failed to open temp file for replay episode.";
        return result;
    }

    out << "{\n";
    write_indent(out, 2);
    write_string(out, "static_environment");
    out << ": ";
    write_static_environment(out, episode.static_env, 2);
    out << ",\n";

    write_indent(out, 2);
    write_string(out, "trajectory");
    out << ": [\n";
    for (std::size_t i = 0; i < episode.trajectory.size(); ++i) {
        if (i) out << ",\n";
        const auto& step = episode.trajectory[i];
        write_indent(out, 4);
        out << "{\n";
        write_indent(out, 6);
        write_string(out, "observation");
        out << ": ";
        write_observation(out, step.observation, 6);
        out << ",\n";

        write_indent(out, 6);
        write_string(out, "pi");
        out << ": [";
        for (std::size_t j = 0; j < step.pi.size(); ++j) {
            if (j) out << ", ";
            write_float(out, step.pi[j]);
        }
        out << "],\n";

        write_indent(out, 6);
        write_string(out, "v_root");
        out << ": ";
        write_float(out, step.v_root);
        out << ",\n";

        write_indent(out, 6);
        write_string(out, "a_taken");
        out << ": " << step.a_taken << ",\n";

        write_indent(out, 6);
        write_string(out, "mask");
        out << ": [";
        for (std::size_t j = 0; j < step.mask.size(); ++j) {
            if (j) out << ", ";
            write_bool(out, step.mask[j]);
        }
        out << "]\n";

        write_indent(out, 4);
        out << "}";
    }
    out << "\n";
    write_indent(out, 2);
    out << "],\n";

    write_indent(out, 2);
    write_string(out, "final_reward");
    out << ": ";
    write_float(out, episode.final_reward);
    out << ",\n";

    write_indent(out, 2);
    write_string(out, "final_reward_raw");
    out << ": ";
    write_float(out, episode.final_reward);
    out << ",\n";

    write_indent(out, 2);
    write_string(out, "accepted");
    out << ": ";
    write_bool(out, episode.accepted);
    out << ",\n";

    write_indent(out, 2);
    write_string(out, "total_cost");
    out << ": ";
    if (episode.total_cost.has_value()) {
        write_float(out, episode.total_cost.value());
    } else {
        out << "null";
    }
    out << ",\n";

    write_indent(out, 2);
    write_string(out, "total_revenue");
    out << ": ";
    if (episode.total_revenue.has_value()) {
        write_float(out, episode.total_revenue.value());
    } else {
        out << "null";
    }
    out << ",\n";

    write_indent(out, 2);
    write_string(out, "value_target");
    out << ": ";
    if (episode.value_target.has_value()) {
        write_float(out, episode.value_target.value());
    } else {
        out << "null";
    }
    out << ",\n";

    write_policy_model(out, episode, 2);
    out << "\n";
    out << "}\n";
    out.flush();
    out.close();

    std::string final_name = "episode_" + std::to_string(ns) + "_" + std::to_string(::getpid()) + "_" + random_hex + ".json";
    std::string final_path = (std::filesystem::path(replay_dir) / final_name).string();

    try {
        std::filesystem::rename(tmp_path, final_path);
    } catch (const std::exception& exc) {
        result.error = exc.what();
        try {
            std::filesystem::remove(tmp_path);
        } catch (...) {
        }
        return result;
    }

    result.written = true;
    result.path = final_path;
    return result;
}

void cleanup_replay_buffer(const std::string& replay_dir, int keep) {
    if (keep <= 0) {
        return;
    }
    std::vector<std::filesystem::directory_entry> entries;
    try {
        for (const auto& entry : std::filesystem::directory_iterator(replay_dir)) {
            if (!entry.is_regular_file()) {
                continue;
            }
            auto path = entry.path();
            if (path.extension() == ".json") {
                entries.push_back(entry);
            }
        }
    } catch (...) {
        return;
    }
    if (static_cast<int>(entries.size()) <= keep) {
        return;
    }
    std::sort(entries.begin(), entries.end(), [](const auto& a, const auto& b) {
        return a.path().filename().string() < b.path().filename().string();
    });
    int to_remove = static_cast<int>(entries.size()) - keep;
    for (int i = 0; i < to_remove; ++i) {
        try {
            std::filesystem::remove(entries[static_cast<std::size_t>(i)].path());
        } catch (...) {
        }
    }
}

}  // namespace

StaticEnvironment build_static_environment(const Network& physical, const Network& virtual_net) {
    StaticEnvironment env;
    env.physical_nodes.reserve(static_cast<std::size_t>(physical.num_nodes));
    for (int i = 0; i < physical.num_nodes; ++i) {
        double value = 0.0;
        auto it = physical.node_attrs[i].find("max_cpu");
        if (it != physical.node_attrs[i].end()) {
            value = it->second;
        } else {
            it = physical.node_attrs[i].find("cpu");
            if (it != physical.node_attrs[i].end()) {
                value = it->second;
            }
        }
        env.physical_nodes.push_back({i, value});
    }
    env.physical_links.reserve(physical.edges.size());
    for (const auto& edge : physical.edges) {
        int edge_id = -1;
        auto it = physical.edge_index.find(edge);
        if (it != physical.edge_index.end()) {
            edge_id = it->second;
        }
        double value = 0.0;
        if (edge_id >= 0 && edge_id < static_cast<int>(physical.edge_attrs.size())) {
            auto it_attr = physical.edge_attrs[edge_id].find("max_bw");
            if (it_attr != physical.edge_attrs[edge_id].end()) {
                value = it_attr->second;
            } else {
                it_attr = physical.edge_attrs[edge_id].find("bw");
                if (it_attr != physical.edge_attrs[edge_id].end()) {
                    value = it_attr->second;
                }
            }
        }
        env.physical_links.push_back({edge.first, edge.second, value});
    }

    env.sfc_nodes.reserve(static_cast<std::size_t>(virtual_net.num_nodes));
    for (int i = 0; i < virtual_net.num_nodes; ++i) {
        double value = 0.0;
        auto it = virtual_net.node_attrs[i].find("cpu");
        if (it != virtual_net.node_attrs[i].end()) {
            value = it->second;
        }
        env.sfc_nodes.push_back({i, value});
    }
    env.sfc_links.reserve(virtual_net.edges.size());
    for (const auto& edge : virtual_net.edges) {
        int edge_id = -1;
        auto it = virtual_net.edge_index.find(edge);
        if (it != virtual_net.edge_index.end()) {
            edge_id = it->second;
        }
        double value = 0.0;
        if (edge_id >= 0 && edge_id < static_cast<int>(virtual_net.edge_attrs.size())) {
            auto it_attr = virtual_net.edge_attrs[edge_id].find("bw");
            if (it_attr != virtual_net.edge_attrs[edge_id].end()) {
                value = it_attr->second;
            }
        }
        env.sfc_links.push_back({edge.first, edge.second, value});
    }
    return env;
}

ReplayWriteResult write_replay_episode(const ReplayEpisode& episode, const std::string& replay_dir, int max_buffer_size) {
    ReplayWriteResult result = write_episode_file(episode, replay_dir);
    if (result.written && max_buffer_size > 0) {
        cleanup_replay_buffer(replay_dir, max_buffer_size);
    }
    return result;
}

}  // namespace azsfc
