#ifndef SK_TYPES_H
#define SK_TYPES_H

#include <stdint.h>
#include <stddef.h>

#ifdef __cplusplus
    #define SK_C_PLUS_PLUS_BEGIN_GUARD  extern "C" {
    #define SK_C_PLUS_PLUS_END_GUARD    }
#else
    #define SK_C_PLUS_PLUS_BEGIN_GUARD
    #define SK_C_PLUS_PLUS_END_GUARD
#endif

SK_C_PLUS_PLUS_BEGIN_GUARD

typedef signed char BOOL;
typedef uint32_t sk_color_t;

typedef enum {
    UNKNOWN_SK_COLORTYPE = 0,
    ALPHA_8_SK_COLORTYPE,
    RGB_565_SK_COLORTYPE,
    ARGB_4444_SK_COLORTYPE,
    RGBA_8888_SK_COLORTYPE,
    RGB_888X_SK_COLORTYPE,
    BGRA_8888_SK_COLORTYPE,
    RGBA_1010102_SK_COLORTYPE,
    BGRA_1010102_SK_COLORTYPE,
    RGB_101010X_SK_COLORTYPE,
    BGR_101010X_SK_COLORTYPE,
    GRAY_8_SK_COLORTYPE,
    RGBA_F16_NORM_SK_COLORTYPE,
    RGBA_F16_SK_COLORTYPE,
    RGBA_F32_SK_COLORTYPE,

    // READONLY
    R8G8_UNORM_SK_COLORTYPE,
    A16_FLOAT_SK_COLORTYPE,
    R16G16_FLOAT_SK_COLORTYPE,
    A16_UNORM_SK_COLORTYPE,
    R16G16_UNORM_SK_COLORTYPE,
    R16G16B16A16_UNORM_SK_COLORTYPE,
} sk_colortype_t;

typedef enum {
    UNKNOWN_SK_ALPHATYPE = 0,
    OPAQUE_SK_ALPHATYPE,
    PREMUL_SK_ALPHATYPE,
    UNPREMUL_SK_ALPHATYPE,
} sk_alphatype_t;

typedef enum {
    UNKONWN_SK_PIXELGEOMETRY = 0,
    RGB_H_SK_PIXELGEOMETRY,
    BGR_H_SK_PIXELGEOMETRY,
    RGB_V_SK_PIXELGEOMETRY,
    BGR_V_SK_PIXELGEOMETRY,
} sk_pixelgeometry_t;

typedef struct sk_surfaceprops_t sk_surfaceprops_t;

typedef struct sk_canvas_t sk_canvas_t;
typedef struct sk_surface_t sk_surface_t;

typedef struct sk_imageinfo_t {
    int32_t width;
    int32_t height;
    sk_colortype_t colorType;
    sk_alphatype_t alphaType;
} sk_imageinfo_t;

typedef struct sk_color4f_t {
    float fR;
    float fG;
    float fB;
    float fA;
} sk_color4f_t;

SK_C_PLUS_PLUS_END_GUARD

#endif
