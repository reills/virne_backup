#pragma once

#include "network.hpp"

#include <functional>
#include <string>
#include <unordered_map>
#include <vector>

namespace azsfc {

class ShortestPathFinder {
public:
    struct Path {
        std::vector<int> nodes;
        double cost{0.0};
    };

    using LinkCapacityFn = std::function<double(int, const std::string&)>;

    std::vector<Path> find_paths(const Network& net,
                                 int source,
                                 int target,
                                 int k,
                                 const std::unordered_map<std::string, double>& link_demands,
                                 const std::string& method,
                                 const LinkCapacityFn& capacity_fn) const;
};

}  // namespace azsfc
