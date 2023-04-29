#include "sk_surface.h"
#include "include/core/SkSurface.h"
#include "sk_types_priv.h"

void sk_surface_unref(sk_surface_t* surface) {
    SkSafeUnref(AsSurface(surface));
}

#include "include/core/SkSurfaceProps.h"

sk_surfaceprops_t* sk_surfaceprops_new(uint32_t flags, sk_pixelgeometry_t geometry) {
    return ToSurfaceProps(new SkSurfaceProps(flags, static_cast<SkPixelGeometry>(geometry)));
}

void sk_surfaceprops_delete(sk_surfaceprops_t* props) {
    delete AsSurfaceProps(props);
}
