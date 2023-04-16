project(skia)

if(${PLATFORM} STREQUAL "OS64")
    set(SKIA_TARGET_OS ios)
    set(SKIA_TARGET_CPU arm64)
    set(SKIA_USE_SIMULATOR false)
elseif(${PLATFORM} STREQUAL "SIMULATOR64")
    set(SKIA_TARGET_OS ios)
    set(SKIA_TARGET_CPU x86_64)
    set(SKIA_USE_SIMULATOR true)
elseif(${PLATFORM} STREQUAL "SIMULATORARM64")
    set(SKIA_TARGET_OS ios)
    set(SKIA_TARGET_CPU arm64)
    set(SKIA_USE_SIMULATOR true)
elseif(${PLATFORM} STREQUAL "MAC")
    set(SKIA_TARGET_OS mac)
    set(SKIA_TARGET_CPU x86_64)
    set(SKIA_USE_SIMULATOR false)
elseif(${PLATFORM} STREQUAL "MAC_ARM64")
    set(SKIA_TARGET_OS mac)
    set(SKIA_TARGET_CPU arm64)
    set(SKIA_USE_SIMULATOR false)
else()
    message(FATAL "Can't build for that platform.")
endif()

add_custom_target(skia-pre-config
    COMMAND ./tools/git-sync-deps
    WORKING_DIRECTORY ${SKIA_SRC_DIR}
    COMMENT "Configure dependencies for Skia"
    USES_TERMINAL)

if(${SKIA_USE_SIMULATOR})
    set(SKIA_SIM_STR "sim")
else()
    set(SKIA_SIM_STR)
endif()

string(JOIN _ SKIA_SUFFIX ${SKIA_TARGET_OS} ${SKIA_TARGET_CPU} ${SKIA_SIM_STR})
string(JOIN _ SKIA_OUT_DIR out ${SKIA_SUFFIX})

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/skia_cmd.sh.in
    ${CMAKE_CURRENT_SOURCE_DIR}/.build/skia_cmd_${SKIA_SUFFIX}.sh
    @ONLY)

add_custom_target(skia-generate
    COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/.build/skia_cmd_${SKIA_SUFFIX}.sh
    WORKING_DIRECTORY ${SKIA_SRC_DIR}
    COMMENT "Generating Skia for ${SKIA_TARGET_OS} ${SKIA_TARGET_CPU} ${SKIA_SIM_STR}"
    USES_TERMINAL)

set_property(TARGET ${SKIA_GENERATE_TARGET}
    APPEND
    PROPERTY ADDITIONAL_CLEAN_FILES ${SKIA_SRC_DIR}/${SKIA_OUT_DIR})

add_dependencies(skia-generate skia-pre-config)

add_custom_target(skia-build
    COMMAND ninja -C ${SKIA_OUT_DIR} libskia.a
    COMMAND ${CMAKE_COMMAND} -E copy
        ${SKIA_OUT_DIR}/libskia.a
        ${CMAKE_CURRENT_BINARY_DIR}/libskia_${SKIA_SUFFIX}.a
    WORKING_DIRECTORY ${SKIA_SRC_DIR}
    COMMENT "Building Skia for ${SKIA_TARGET_OS} ${SKIA_TARGET_CPU} ${SKIA_SIM_STR}"
    USES_TERMINAL)

set_property(TARGET skia-build
    APPEND
    PROPERTY ADDITIONAL_CLEAN_FILES ${CMAKE_CURRENT_BINARY_DIR}/libskia_${SKIA_SUFFIX}.a)

add_dependencies(skia-build skia-generate)

add_library(skia STATIC IMPORTED GLOBAL)

add_dependencies(skia skia-build)

target_include_directories(skia
    INTERFACE ${SKIA_SRC_DIR})

target_link_libraries(skia
    INTERFACE ${CMAKE_CURRENT_BINARY_DIR}/libskia_${SKIA_SUFFIX}.a)

set_property(TARGET skia
    APPEND
    PROPERTY IMPORTED_LOCATION ${CMAKE_CURRENT_BINARY_DIR}/libskia_${SKIA_SUFFIX}.a)
