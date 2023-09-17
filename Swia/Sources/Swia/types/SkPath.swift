#if canImport(CSkia)
import CSkia
#endif

public class SkPath {
    public static func create() -> SkPath {
        return SkPath(sk_path_new())
    }

    var handle: OpaquePointer

    public init(_ handle: OpaquePointer) {
        self.handle = handle
    }

    public func moveTo(x: Float, y: Float) -> SkPath {
        sk_path_move_to(handle, x, y)
        return self
    }

    public func relativeMoveTo(x: Float, y: Float) -> SkPath {
        sk_path_relative_move_to(handle, x, y)
        return self
    }

    public func lineTo(x: Float, y: Float) -> SkPath {
        sk_path_line_to(handle, x, y)
        return self
    }

    public func relativeLineTo(x: Float, y: Float) -> SkPath {
        sk_path_relative_line_to(handle, x, y)
        return self
    }

    public func addCircle(x: Float, y: Float, r: Float) -> SkPath {
        sk_path_add_circle(handle, x, y, r)
        return self
    }

    public func close() -> SkPath {
        sk_path_close(handle)
        return self
    }

    deinit {
        sk_path_delete(handle)
    }
}
