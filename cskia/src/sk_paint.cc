#include "sk_types_priv.h"
#include "sk_paint.h"

#include "include/core/SkPaint.h"

sk_paint_t* sk_paint_new(void) {
    return ToPaint(new SkPaint());
}

sk_paint_t* sk_paint_clone(sk_paint_t* paint) {
    return ToPaint(new SkPaint(AsPaint(*paint)));
}

void sk_paint_delete(sk_paint_t* paint) {
    delete AsPaint(paint);
}

void sk_paint_reset(sk_paint_t *paint) {
    AsPaint(paint)->reset();
}

BOOL sk_paint_is_antialias(const sk_paint_t *paint) {
    return AsPaint(paint)->isAntiAlias();
}

void sk_paint_set_antialias(sk_paint_t *paint, BOOL antialias) {
    AsPaint(paint)->setAntiAlias(antialias);
}

sk_color_t sk_paint_get_color(const sk_paint_t *paint) {
    return AsPaint(paint)->getColor();
}

void sk_paint_set_color(sk_paint_t *paint, sk_color_t color) {
    AsPaint(paint)->setColor(color);
}

float sk_paint_get_stroke_width(const sk_paint_t *paint) {
    return AsPaint(paint)->getStrokeWidth();
}

void sk_paint_set_stroke_width(sk_paint_t *paint, float width) {
    AsPaint(paint)->setStrokeWidth(width);
}

float sk_paint_get_stroke_miter(const sk_paint_t *paint) {
    return AsPaint(paint)->getStrokeMiter();
}

void sk_paint_set_stroke_miter(sk_paint_t *paint, float miter) {
    AsPaint(paint)->setStrokeMiter(miter);
}
