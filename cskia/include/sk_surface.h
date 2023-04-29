#ifndef SK_SURFACE_H
#define SK_SURFACE_H

#include "sk_types.h"

SK_C_PLUS_PLUS_BEGIN_GUARD

void sk_surface_unref(sk_surface_t* surface);

sk_surfaceprops_t* sk_surfaceprops_new(uint32_t flags, sk_pixelgeometry_t geometry);
void sk_surfaceprops_delete(sk_surfaceprops_t* props);

SK_C_PLUS_PLUS_END_GUARD

#endif
