cmake_minimum_required(VERSION 3.15)

set(${CMAKE_CURRENT_SOURCE_DIR}/ios.toolchain.cmake)

project(mantleda)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 17)

add_subdirectory(lib)
add_subdirectory(cskia)
