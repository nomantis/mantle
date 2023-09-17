#ifndef SK_IMAGEINFO_H
#define SK_IMAGEINFO_H

#include "sk_types.h"

SK_C_PLUS_PLUS_BEGIN_GUARD

sk_imageinfo_t sk_imageinfo_make(int width, int height, sk_colortype_t colorType, sk_alphatype_t alphaType);
sk_imageinfo_t sk_imageinfo_make_wh(const sk_imageinfo_t info, int width, int height);

SK_C_PLUS_PLUS_END_GUARD

#endif
