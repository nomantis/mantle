#if canImport(CSkia)
import CSkia
#endif

public class Surface {
    var handle: OpaquePointer

    init(_ handle: OpaquePointer) {
        self.handle = handle
    }

    deinit {
        sk_surface_unref(handle)
    }
}
