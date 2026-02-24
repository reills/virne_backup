#pragma once

#include "state.hpp"

#include <torch/script.h>

#include <cstdint>
#include <memory>
#include <string>
#include <unordered_map>

namespace azsfc {

class PolicyNetwork {
public:
    PolicyNetwork() = default;

    explicit PolicyNetwork(const std::string& model_path, torch::Device device = torch::kCUDA);

    void load(const std::string& model_path, torch::Device device = torch::kCUDA);

    torch::Tensor encode(const torch::Tensor& v_net_x);
    torch::Tensor start_embedding();

    [[nodiscard]] bool is_loaded() const noexcept { return loaded_; }
    [[nodiscard]] torch::Device device() const noexcept { return device_; }

    EvaluationResult evaluate(const StateView::TensorMap& inputs);

private:
    torch::jit::Module module_;
    torch::Device device_{torch::kCPU};
    bool loaded_{false};
};

}  // namespace azsfc
