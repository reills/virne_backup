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

    # Conda's CUDA toolkit is often installed under:
    #   $CONDA_PREFIX/targets/x86_64-linux
    # rather than directly under $CONDA_PREFIX. Point FindCUDA there by default
    # so Torch's CMake checks can locate CUDA headers/libraries.
    if(DEFINED ENV{CONDA_PREFIX})
        set(_CONDA_CUDA_ROOT "$ENV{CONDA_PREFIX}/targets/x86_64-linux")
        if(EXISTS "${_CONDA_CUDA_ROOT}/include/cuda.h")
            set(_CUDA_ROOT_HAS_HEADERS FALSE)
            if(DEFINED CUDAToolkit_ROOT AND EXISTS "${CUDAToolkit_ROOT}/include/cuda.h")
                set(_CUDA_ROOT_HAS_HEADERS TRUE)
            elseif(DEFINED CUDA_TOOLKIT_ROOT_DIR AND EXISTS "${CUDA_TOOLKIT_ROOT_DIR}/include/cuda.h")
                set(_CUDA_ROOT_HAS_HEADERS TRUE)
            endif()

            if((NOT DEFINED CUDA_TOOLKIT_ROOT_DIR OR "${CUDA_TOOLKIT_ROOT_DIR}" STREQUAL "")
               OR (NOT DEFINED CUDAToolkit_ROOT OR "${CUDAToolkit_ROOT}" STREQUAL "")
               OR (NOT _CUDA_ROOT_HAS_HEADERS))
                set(CUDA_TOOLKIT_ROOT_DIR "${_CONDA_CUDA_ROOT}" CACHE PATH "CUDA toolkit root directory" FORCE)
                set(CUDAToolkit_ROOT "${_CONDA_CUDA_ROOT}" CACHE PATH "CUDA toolkit root directory for CMake" FORCE)
            endif()
            if(NOT DEFINED CUDA_INCLUDE_DIRS OR "${CUDA_INCLUDE_DIRS}" STREQUAL "")
                set(CUDA_INCLUDE_DIRS "${_CONDA_CUDA_ROOT}/include" CACHE PATH "CUDA include directory" FORCE)
            endif()
        endif()
    endif()
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

# Kept for backward compatibility with older build scripts.
# The current C++ core is single-threaded and does not contain OpenMP kernels.
option(USE_OPENMP "Deprecated: OpenMP is not used by this target" OFF)
if(USE_OPENMP)
    message(WARNING "USE_OPENMP is enabled, but alpha_zero_cpp_core has no OpenMP regions; flag is ignored.")
endif()

# Allow the caller to point at a LibTorch installation explicitly. Users can pass:
#   cmake -DTorch_DIR=/path/to/libtorch/share/cmake/Torch ..
if(DEFINED ENV{LIBTORCH_PATH} AND NOT Torch_DIR)
    set(Torch_DIR "$ENV{LIBTORCH_PATH}/share/cmake/Torch")
endif()

find_package(Torch REQUIRED)

# Recent Conda CUDA packages provide NVTX through libnvtx3interop rather than
# libnvToolsExt. Torch may still request CUDA::nvToolsExt through imported
# targets, so provide a compatibility target when CMake does not define one.
if(ALPHA_ZERO_CPP_ENABLE_CUDA AND NOT TARGET CUDA::nvToolsExt)
    set(_NVTX_SEARCH_ROOTS "")
    if(DEFINED CUDAToolkit_ROOT AND NOT "${CUDAToolkit_ROOT}" STREQUAL "")
        list(APPEND _NVTX_SEARCH_ROOTS "${CUDAToolkit_ROOT}")
    endif()
    if(DEFINED CUDA_TOOLKIT_ROOT_DIR AND NOT "${CUDA_TOOLKIT_ROOT_DIR}" STREQUAL "")
        list(APPEND _NVTX_SEARCH_ROOTS "${CUDA_TOOLKIT_ROOT_DIR}")
    endif()
    if(DEFINED ENV{CONDA_PREFIX})
        list(APPEND _NVTX_SEARCH_ROOTS "$ENV{CONDA_PREFIX}" "$ENV{CONDA_PREFIX}/targets/x86_64-linux")
    endif()

    find_library(NVTOOLSEXT_LIBRARY
        NAMES nvToolsExt
        PATH_SUFFIXES lib lib64
        PATHS ${_NVTX_SEARCH_ROOTS}
        NO_DEFAULT_PATH
    )

    if(NVTOOLSEXT_LIBRARY)
        add_library(CUDA::nvToolsExt SHARED IMPORTED)
        set_target_properties(CUDA::nvToolsExt PROPERTIES IMPORTED_LOCATION "${NVTOOLSEXT_LIBRARY}")
    else()
        find_library(NVTX3INTEROP_LIBRARY
            NAMES nvtx3interop
            PATH_SUFFIXES lib lib64
            PATHS ${_NVTX_SEARCH_ROOTS}
            NO_DEFAULT_PATH
        )
        if(NOT NVTX3INTEROP_LIBRARY)
            find_file(NVTX3INTEROP_LIBRARY
                NAMES libnvtx3interop.so.1 libnvtx3interop.so.1.0.0
                PATH_SUFFIXES lib lib64
                PATHS ${_NVTX_SEARCH_ROOTS}
                NO_DEFAULT_PATH
            )
        endif()
        if(NVTX3INTEROP_LIBRARY)
            add_library(CUDA::nvToolsExt SHARED IMPORTED)
            set_target_properties(CUDA::nvToolsExt PROPERTIES IMPORTED_LOCATION "${NVTX3INTEROP_LIBRARY}")
            message(WARNING "Using ${NVTX3INTEROP_LIBRARY} as CUDA::nvToolsExt compatibility fallback.")
        endif()
    endif()
endif()

# Try to locate pybind11 via its modern CMake package. Users can pass:
#   cmake -Dpybind11_DIR=/path/to/pybind11/share/cmake/pybind11 ..
find_package(pybind11 CONFIG REQUIRED)
find_package(Python3 COMPONENTS Interpreter REQUIRED)

# Torch's Python bindings live in libtorch_python. Older Torch CMake exports
# populate TORCH_PYTHON_LIBRARY, but recent releases ship the library without
# emitting that variable or an imported target. Discover it explicitly so we
# can link against it and avoid undefined symbols like THPDeviceType at import.
if(NOT DEFINED TORCH_PYTHON_LIBRARY OR TORCH_PYTHON_LIBRARY STREQUAL "")
    find_library(TORCH_PYTHON_LIBRARY
        NAMES torch_python
        HINTS
            "${TORCH_INSTALL_PREFIX}/lib"
            "${TORCH_INSTALL_PREFIX}/../torch/lib"
        NO_DEFAULT_PATH
    )
endif()

execute_process(
    COMMAND "${Python3_EXECUTABLE}" "-c"
            "import sysconfig; print(sysconfig.get_path('include'))"
    OUTPUT_VARIABLE Python3_INCLUDE_DIR
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

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
    src/replay_writer.cpp
    src/solver.cpp
    src/bindings.cpp
)

add_library(alpha_zero_cpp_core MODULE ${CPP_CORE_SOURCES} ${CPP_CORE_HEADERS})

if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    # Silence a GCC 12+ false-positive in pybind11/torch headers.
    target_compile_options(alpha_zero_cpp_core PRIVATE -Wno-stringop-overread)
    # LTO can surface the same warning at link time; silence there too.
    target_link_options(alpha_zero_cpp_core PRIVATE -Wno-stringop-overread)
endif()

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

# Torch moved the Python bindings into the Torch::Python target and no longer
# always populates TORCH_PYTHON_LIBRARY. Link against the modern target when
# available and fall back to the legacy variable otherwise.
if(TARGET Torch::Python)
    target_link_libraries(alpha_zero_cpp_core PRIVATE Torch::Python)
elseif(DEFINED TORCH_PYTHON_LIBRARY AND TORCH_PYTHON_LIBRARY)
    target_link_libraries(alpha_zero_cpp_core PRIVATE ${TORCH_PYTHON_LIBRARY})
endif()

if(TARGET pybind11::lto)
    target_link_libraries(alpha_zero_cpp_core PRIVATE pybind11::lto)
endif()

if(TARGET pybind11::windows_extras)
    target_link_libraries(alpha_zero_cpp_core PRIVATE pybind11::windows_extras)
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
