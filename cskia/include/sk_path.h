#ifndef SK_PATH_H
#define SK_PATH_H

#include "sk_types.h"

SK_C_PLUS_PLUS_BEGIN_GUARD

sk_path_t* sk_path_new(void);

void sk_path_move_to(sk_path_t* path, float x, float y);
void sk_path_relative_move_to(sk_path_t* path, float x, float y);
void sk_path_relative_line_to(sk_path_t* path, float x, float y);
void sk_path_line_to(sk_path_t* path, float x, float y);
void sk_path_add_circle(sk_path_t* path, float x, float y, float r);
void sk_path_close(sk_path_t* path);

void sk_path_delete(sk_path_t* path);

SK_C_PLUS_PLUS_END_GUARD

#endif
