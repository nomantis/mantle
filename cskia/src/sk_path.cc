#include "sk_path.h"
#include "include/core/SkPath.h"
#include "sk_types_priv.h"

sk_path_t* sk_path_new(void) {
    return ToPath(new SkPath());
}

void sk_path_move_to(sk_path_t* path, float x, float y) {
    AsPath(path)->moveTo(x, y);
}

void sk_path_relative_move_to(sk_path_t* path, float x, float y) {
    AsPath(path)->rMoveTo(x, y);
}

void sk_path_line_to(sk_path_t* path, float x, float y) {
    AsPath(path)->lineTo(x, y);
}

void sk_path_relative_line_to(sk_path_t* path, float x, float y) {
    AsPath(path)->rLineTo(x, y);
}

void sk_path_add_circle(sk_path_t* path, float x, float y, float r) {
    AsPath(path)->addCircle(x, y, r, SkPathDirection::kCW);
}

void sk_path_close(sk_path_t* path) {
    AsPath(path)->close();
}

void sk_path_delete(sk_path_t* path) {
    delete AsPath(path);
}
