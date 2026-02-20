cmake_minimum_required(VERSION 3.14)
project(mcts_cpp_core LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

find_package(pybind11 CONFIG REQUIRED)
find_package(Python3 COMPONENTS Interpreter REQUIRED)

execute_process(
    COMMAND "${Python3_EXECUTABLE}" "-c"
            "import sysconfig; print(sysconfig.get_path('include'))"
    OUTPUT_VARIABLE Python3_INCLUDE_DIR
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

set(MCTS_CPP_CORE_SOURCES
    src/mcts_core.cpp
)

add_library(mcts_cpp_core MODULE ${MCTS_CPP_CORE_SOURCES})

target_include_directories(mcts_cpp_core
    PRIVATE
        ${Python3_INCLUDE_DIR}
)

target_link_libraries(mcts_cpp_core
    PRIVATE
        pybind11::module
)

if(TARGET pybind11::lto)
    target_link_libraries(mcts_cpp_core PRIVATE pybind11::lto)
endif()

if(TARGET pybind11::windows_extras)
    target_link_libraries(mcts_cpp_core PRIVATE pybind11::windows_extras)
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    target_compile_options(mcts_cpp_core PRIVATE -Wall -Wextra -Wno-unknown-pragmas)
endif()

set_target_properties(mcts_cpp_core PROPERTIES
    OUTPUT_NAME "mcts_cpp_core"
    PREFIX ""
)

