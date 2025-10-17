cmake_minimum_required(VERSION 3.18)
project(alpha_zero_cpp_core LANGUAGES CXX)

option(ALPHA_ZERO_CPP_ENABLE_CUDA "Build against CUDA-enabled LibTorch" ON)

if(ALPHA_ZERO_CPP_ENABLE_CUDA)
    if(NOT DEFINED CMAKE_CUDA_HOST_COMPILER)
        # Prefer GCC 12 when available because newer GCC releases trigger nvcc
        # compatibility checks. Users can override this by passing
        # -DCMAKE_CUDA_HOST_COMPILER=<path>.
        if(EXISTS "/usr/bin/g++-12")
            set(CMAKE_CUDA_HOST_COMPILER "/usr/bin/g++-12" CACHE FILEPATH "Host compiler for nvcc" FORCE)
        endif()
    endif()

    # PyTorch's CMake package enables CUDA when it is available.  Modern CMake
    # versions require CUDA architectures to be specified explicitly, otherwise
    # configuration stops with "CUDA_ARCHITECTURES is empty".  Respect any list
    # provided by PyTorch users via TORCH_CUDA_ARCH_LIST, and fall back to a broad
    # baseline that covers Pascal->Ampere so builds succeed even when no explicit
    # value is supplied.
    if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
        if(DEFINED ENV{TORCH_CUDA_ARCH_LIST} AND NOT "$ENV{TORCH_CUDA_ARCH_LIST}" STREQUAL "")
            set(CMAKE_CUDA_ARCHITECTURES "$ENV{TORCH_CUDA_ARCH_LIST}")
        else()
            set(CMAKE_CUDA_ARCHITECTURES 60 70 75 80 86)
        endif()
    endif()

    # Conda often bundles recent GCC releases, which nvcc refuses by default.
    # Allow it explicitly so the Torch CUDA check can succeed even with GCC 13+.
    set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -allow-unsupported-compiler" CACHE STRING "nvcc flags" FORCE)
else()
    # Skip CUDA discovery entirely so CPU-only builds work with new GCC toolchains.
    set(CMAKE_DISABLE_FIND_PACKAGE_CUDA TRUE)
endif()

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

option(USE_OPENMP "Enable OpenMP parallelism" ON)

# Allow the caller to point at a LibTorch installation explicitly. Users can pass:
#   cmake -DTorch_DIR=/path/to/libtorch/share/cmake/Torch ..
if(DEFINED ENV{LIBTORCH_PATH} AND NOT Torch_DIR)
    set(Torch_DIR "$ENV{LIBTORCH_PATH}/share/cmake/Torch")
endif()

find_package(Torch REQUIRED)

# Try to locate pybind11 via its modern CMake package. Users can pass:
#   cmake -Dpybind11_DIR=/path/to/pybind11/share/cmake/pybind11 ..
find_package(pybind11 CONFIG REQUIRED)
find_package(Python3 COMPONENTS Interpreter REQUIRED)

execute_process(
    COMMAND "${Python3_EXECUTABLE}" "-c"
            "import sysconfig; print(sysconfig.get_path('include'))"
    OUTPUT_VARIABLE Python3_INCLUDE_DIR
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

if(USE_OPENMP)
    find_package(OpenMP)
endif()

file(GLOB CPP_CORE_HEADERS CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp"
)

set(CPP_CORE_SOURCES
    src/network.cpp
    src/shortest_path.cpp
    src/vnr_state.cpp
    src/state.cpp
    src/node.cpp
    src/mcts_engine.cpp
    src/policy_network.cpp
    src/bindings.cpp
)

add_library(alpha_zero_cpp_core MODULE ${CPP_CORE_SOURCES} ${CPP_CORE_HEADERS})

target_include_directories(alpha_zero_cpp_core
    PRIVATE
        ${Python3_INCLUDE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_link_libraries(alpha_zero_cpp_core
    PRIVATE
        pybind11::module
        ${TORCH_LIBRARIES}
)

if(TARGET pybind11::lto)
    target_link_libraries(alpha_zero_cpp_core PRIVATE pybind11::lto)
endif()

if(TARGET pybind11::windows_extras)
    target_link_libraries(alpha_zero_cpp_core PRIVATE pybind11::windows_extras)
endif()

if(OpenMP_CXX_FOUND)
    target_link_libraries(alpha_zero_cpp_core PRIVATE OpenMP::OpenMP_CXX)
    target_compile_definitions(alpha_zero_cpp_core PRIVATE -DUSE_OPENMP)
endif()

# Torch headers trigger a lot of warnings; silence them to avoid noisy builds.
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    target_compile_options(alpha_zero_cpp_core PRIVATE -Wall -Wextra -Wno-unknown-pragmas)
endif()

# pybind11 expects the extension name to match the module name.
set_target_properties(alpha_zero_cpp_core PROPERTIES
    OUTPUT_NAME "alpha_zero_cpp_core"
    PREFIX ""
)

if(MSVC)
    target_compile_definitions(alpha_zero_cpp_core PRIVATE -D_CRT_SECURE_NO_WARNINGS)
endif()
