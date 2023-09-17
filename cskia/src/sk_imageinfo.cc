#include "sk_imageinfo.h"
#include "sk_types_priv.h"
#include "include/core/SkImageInfo.h"

sk_imageinfo_t sk_imageinfo_make(int width, int height, sk_colortype_t colorType, sk_alphatype_t alphaType) {
    return ToImageInfo(SkImageInfo::Make(width, height, (SkColorType) colorType, (SkAlphaType) alphaType));
}

sk_imageinfo_t sk_imageinfo_make_wh(const sk_imageinfo_t info, int width, int height) {
    return sk_imageinfo_make(width, height, info.colorType, info.alphaType);
}
