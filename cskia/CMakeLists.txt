project(cskia)

add_library(cskia STATIC
    src/sk_surface.cc
    src/sk_canvas.cc)

add_dependencies(cskia skia)

get_property(SKIA_INCLUDE_DIRS
    TARGET skia
    PROPERTY INTERFACE_INCLUDE_DIRECTORIES)

target_include_directories(cskia
    PRIVATE
    ${SKIA_INCLUDE_DIRS}
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include)

target_link_libraries(cskia
    PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/libcskia.a)
