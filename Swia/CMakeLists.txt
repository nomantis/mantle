project(Swia)

get_property(SKIA_LINK_LIBRARIES
    TARGET skia
    PROPERTY INTERFACE_LINK_LIBRARIES)

get_property(CSKIA_LINK_LIBRARIES
    TARGET cskia
    PROPERTY LINK_LIBRARIES)

get_property(CSKIA_INCLUDE_DIRECTORIES
    TARGET cskia
    PROPERTY INTERFACE_INCLUDE_DIRECTORIES)

add_custom_target(Swia-configure ALL
    COMMAND libtool -static -o ${CMAKE_CURRENT_BINARY_DIR}/libcskia.a ${CSKIA_LINK_LIBRARIES} ${SKIA_LINK_LIBRARIES}
    COMMENT "Merging Skia and CSkia static libs"
    DEPENDS cskia
    USES_TERMINAL)

add_custom_target(Swia-framework ALL
    COMMAND xcodebuild -create-xcframework -library ${CMAKE_CURRENT_BINARY_DIR}/libcskia.a -headers ${CSKIA_INCLUDE_DIRECTORIES} -output ${CMAKE_CURRENT_SOURCE_DIR}/Frameworks/cskia.xcframework
    COMMENT "Creating CSkia framework"
    DEPENDS Swia-configure
    USES_TERMINAL)

set_property(TARGET Swia-framework
    APPEND
    PROPERTY ADDITIONAL_CLEAN_FILES ${CMAKE_CURRENT_SOURCE_DIR}/Frameworks/cskia.xcframework)
