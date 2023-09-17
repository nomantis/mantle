#ifndef SK_PAINT_H
#define SK_PAINT_H

#include "sk_types.h"

SK_C_PLUS_PLUS_BEGIN_GUARD

sk_paint_t* sk_paint_new(void);
sk_paint_t* sk_paint_clone(sk_paint_t* paint);
void sk_paint_delete(sk_paint_t* paint);
void sk_paint_reset(sk_paint_t* paint);
BOOL sk_paint_is_antialias(const sk_paint_t*);
void sk_paint_set_antialias(sk_paint_t* paint, BOOL antialias);
sk_color_t sk_paint_get_color(sk_paint_t* paint);
void sk_paint_set_color(sk_paint_t* paint, sk_color_t color);
float sk_paint_get_stroke_width(const sk_paint_t* paint);
void sk_paint_set_stroke_width(sk_paint_t* paint, float width);
float sk_paint_get_stroke_miter(const sk_paint_t* paint);
void sk_paint_set_stroke_miter(sk_paint_t* paint, float miter);

SK_C_PLUS_PLUS_END_GUARD

#endif
