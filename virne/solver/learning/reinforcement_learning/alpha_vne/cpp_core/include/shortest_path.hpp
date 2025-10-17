#pragma once

#include "network.hpp"

#include <string>
#include <unordered_map>
#include <vector>

namespace azsfc {

class VNRState;

class ShortestPathFinder {
public:
    struct Path {
        std::vector<int> nodes;
        double cost{0.0};
    };

    std::vector<Path> find_paths(const Network& net,
                                 const VNRState& state,
                                 int source,
                                 int target,
                                 int k,
                                 const std::unordered_map<std::string, double>& link_demands,
                                 const std::string& method) const;
};

}  // namespace azsfc
