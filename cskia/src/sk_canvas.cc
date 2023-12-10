#include "sk_types_priv.h"
#include "sk_canvas.h"
#include "include/core/SkCanvas.h"

sk_canvas_t* sk_canvas_new_raster_direct(const sk_imageinfo_t info, void* pixels, size_t rowBytes, const sk_surfaceprops_t* props) {
    return ToCanvas(SkCanvas::MakeRasterDirect(AsImageInfo(info), pixels, rowBytes, AsSurfaceProps(props)).release());
}

void sk_canvas_destroy(sk_canvas_t* canvas) {
    delete AsCanvas(canvas);
}

void sk_canvas_clear(sk_canvas_t* canvas, sk_color_t color) {
    AsCanvas(canvas)->clear(color);
}

void sk_canvas_draw_path(sk_canvas_t* canvas, sk_path_t* path, sk_color_t color) {
    SkPaint p;
    p.setColor(color);
    p.setStroke(true);
    p.setStrokeWidth(5.0f);
    AsCanvas(canvas)->drawPath(*AsPath(path), p);
}

void sk_canvas_draw_filled_path(sk_canvas_t* canvas, sk_path_t* path, sk_color_t color) {
    SkPaint p;
    p.setStyle(SkPaint::kFill_Style);
    p.setColor(color);
    AsCanvas(canvas)->drawPath(*AsPath(path), p);
}
