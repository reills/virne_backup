#include "policy_network.hpp"

#include <torch/torch.h>
#include <c10/core/InferenceMode.h>

#include <stdexcept>

namespace azsfc {

PolicyNetwork::PolicyNetwork(const std::string& model_path, torch::Device device) {
    load(model_path, device);
}

void PolicyNetwork::load(const std::string& model_path, torch::Device device) {
    module_ = torch::jit::load(model_path);
    device_ = device;
    module_.to(device_);
    module_.eval();
    loaded_ = true;
}

torch::Tensor PolicyNetwork::encode(const torch::Tensor& v_net_x) {
    if (!loaded_) {
        throw std::runtime_error("PolicyNetwork::encode called before load().");
    }
    c10::InferenceMode guard;
    auto output = module_.run_method("encode", v_net_x.to(device_));
    return output.toTensor().detach();
}

torch::Tensor PolicyNetwork::start_embedding() {
    if (!loaded_) {
        throw std::runtime_error("PolicyNetwork::start_embedding called before load().");
    }
    c10::InferenceMode guard;
    auto output = module_.run_method("get_start_embedding");
    return output.toTensor().detach();
}

EvaluationResult PolicyNetwork::evaluate(const StateView::TensorMap& inputs) {
    if (!loaded_) {
        throw std::runtime_error("PolicyNetwork::evaluate called before load().");
    }

    c10::InferenceMode guard;
    c10::Dict<std::string, torch::Tensor> dict;
    dict.reserve(inputs.size());
    for (const auto& [key, value] : inputs) {
        torch::Tensor tensor = value;
        if (tensor.device() != device_) {
            tensor = tensor.to(device_);
        }
        dict.insert(key, tensor);
    }

    auto output = module_.forward({dict});

    if (!output.isTuple()) {
        throw std::runtime_error("Expected TorchScript module to return a tuple(policy_logits, value).");
    }

    auto tuple = output.toTuple();
    auto policy = tuple->elements()[0].toTensor();
    auto value = tuple->elements()[1].toTensor();

    EvaluationResult result;
    result.policy_logits = policy.detach();
    result.value = value.detach();
    return result;
}

}  // namespace azsfc
