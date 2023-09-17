#ifndef SK_TYPES_PRIV_H
#define SK_TYPES_PRIV_H

#include "sk_types.h"
#include "include/core/SkTypes.h"

#define DEF_MAP_DECL(SkType, sk_type, Name, Declaration, Ns)            \
    Declaration;                                                        \
    static inline const Ns::SkType& As##Name(const sk_type& t) {        \
        return reinterpret_cast<const Ns::SkType&>(t);                  \
    }                                                                   \
    static inline const Ns::SkType* As##Name(const sk_type* t) {        \
        return reinterpret_cast<const Ns::SkType*>(t);                  \
    }                                                                   \
    static inline Ns::SkType& As##Name(sk_type& t) {                    \
        return reinterpret_cast<Ns::SkType&>(t);                        \
    }                                                                   \
    static inline Ns::SkType* As##Name(sk_type* t) {                    \
        return reinterpret_cast<Ns::SkType*>(t);                        \
    }                                                                   \
    static inline const sk_type& To##Name(const Ns::SkType& t) {        \
        return reinterpret_cast<const sk_type&>(t);                     \
    }                                                                   \
    static inline const sk_type* To##Name(const Ns::SkType* t) {        \
        return reinterpret_cast<const sk_type*>(t);                     \
    }                                                                   \
    static inline sk_type& To##Name(Ns::SkType& t) {                    \
        return reinterpret_cast<sk_type&>(t);                           \
    }                                                                   \
    static inline sk_type* To##Name(Ns::SkType* t) {                    \
        return reinterpret_cast<sk_type*>(t);                           \
    }

#define DEF_CLASS_MAP(SkType, sk_type, Name)                            \
    DEF_MAP_DECL(SkType, sk_type, Name, class SkType, )

#define DEF_CLASS_MAP_WITH_NS(Ns, SkType, sk_type, Name)                \
    DEF_MAP_DECL(Ns::SkType, sk_type, Name, class SkType, Ns)

#define DEF_STRUCT_MAP(SkType, sk_type, Name)                           \
    DEF_MAP_DECL(SkType, sk_type, Name, struct SkType, )

#define DEF_MAP(SkType, sk_type, Name)                                  \
    DEF_MAP_DECL(SkType, sk_type, Name, ,)


DEF_CLASS_MAP(SkSurface, sk_surface_t, Surface)
DEF_CLASS_MAP(SkSurfaceProps, sk_surfaceprops_t, SurfaceProps)
DEF_CLASS_MAP(SkCanvas, sk_canvas_t, Canvas)
DEF_CLASS_MAP(SkPaint, sk_paint_t, Paint)
DEF_CLASS_MAP(SkPath, sk_path_t, Path)

#include "include/core/SkImageInfo.h"
static inline SkImageInfo AsImageInfo(sk_imageinfo_t info) {
    return SkImageInfo::Make(info.width, info.height, (SkColorType) info.colorType, (SkAlphaType) info.alphaType);
}

static inline sk_imageinfo_t ToImageInfo(SkImageInfo info) {
    return {
        .width = info.width(),
        .height = info.height(),
        .colorType = (sk_colortype_t) info.colorType(),
        .alphaType = (sk_alphatype_t) info.alphaType()
    };
}

#endif
