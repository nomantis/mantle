#ifndef SK_CANVAS_H
#define SK_CANVAS_H

#include "sk_types.h"

SK_C_PLUS_PLUS_BEGIN_GUARD

sk_canvas_t* sk_canvas_new_raster_direct(const sk_imageinfo_t info, void* pixels, size_t rowBytes, const sk_surfaceprops_t* props);
void sk_canvas_destroy(sk_canvas_t* canvas);
void sk_canvas_clear(sk_canvas_t* canvas, sk_color_t color);
void sk_canvas_draw_path(sk_canvas_t* canvas, sk_path_t* path, sk_color_t color);
void sk_canvas_draw_filled_path(sk_canvas_t* canvas, sk_path_t* path, sk_color_t color);

SK_C_PLUS_PLUS_END_GUARD

#endif
