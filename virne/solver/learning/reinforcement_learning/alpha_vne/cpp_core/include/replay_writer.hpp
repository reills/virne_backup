#pragma once

#include "network.hpp"

#include <optional>
#include <string>
#include <vector>

#include <torch/torch.h>

namespace azsfc {

struct StaticEnvironmentNode {
    int id{0};
    double value{0.0};
};

struct StaticEnvironmentLink {
    int source{0};
    int target{0};
    double value{0.0};
};

struct StaticEnvironment {
    std::vector<StaticEnvironmentNode> physical_nodes;
    std::vector<StaticEnvironmentLink> physical_links;
    std::vector<StaticEnvironmentNode> sfc_nodes;
    std::vector<StaticEnvironmentLink> sfc_links;
};

struct Observation {
    torch::Tensor p_net_x;
    torch::Tensor p_net_edge_index;
    torch::Tensor p_net_edge_attr;
    int p_net_num_nodes{0};
    torch::Tensor history_features;
    torch::Tensor encoder_outputs;
    torch::Tensor curr_v_node_id;
    torch::Tensor vnfs_remaining;
    torch::Tensor action_mask;
    torch::Tensor candidate_features;
    torch::Tensor v_net_x;
};

struct ReplayStep {
    Observation observation;
    std::vector<float> pi;
    float v_root{0.0f};
    int a_taken{-1};
    std::vector<bool> mask;
};

struct ReplayEpisode {
    StaticEnvironment static_env;
    std::vector<ReplayStep> trajectory;
    double final_reward{0.0};
    bool accepted{false};
    std::optional<double> total_cost;
    std::optional<double> total_revenue;
    std::optional<double> value_target;
    std::string policy_path;
    std::optional<std::string> policy_sha;
    std::optional<double> policy_mtime;
};

struct ReplayWriteResult {
    bool written{false};
    std::string path;
    std::string error;
};

StaticEnvironment build_static_environment(const Network& physical, const Network& virtual_net);

ReplayWriteResult write_replay_episode(const ReplayEpisode& episode, const std::string& replay_dir, int max_buffer_size = 0);

}  // namespace azsfc
