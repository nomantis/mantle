#include "sk_types_priv.h"
#include "sk_canvas.h"
#include "include/core/SkCanvas.h"

sk_canvas_t* sk_canvas_new_raster_direct(const sk_imageinfo_t info, void* pixels, size_t rowBytes, const sk_surfaceprops_t* props) {
    return ToCanvas(SkCanvas::MakeRasterDirect(AsImageInfo(info), pixels, rowBytes, AsSurfaceProps(props)).release());
}

void sk_canvas_clear(sk_canvas_t* canvas, sk_color_t color) {
    AsCanvas(canvas)->clear(color);
}
