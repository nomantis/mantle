import OSLog
#if canImport(CSkia)
import CSkia
#endif

public class Canvas {
    var handle: OpaquePointer
    public var pixels: UnsafeMutableRawPointer
    public var imageInfo: ImageInfo

    public init(_ handle: OpaquePointer, _ pixels: UnsafeMutableRawPointer, _ imageInfo: ImageInfo) {
        self.handle = handle
        self.pixels = pixels
        self.imageInfo = imageInfo
    }

    deinit {
        os_log("Freeing canvas")
        free(pixels)
        sk_canvas_destroy(handle)
    }

    public static func RasterDirect(_ imageInfo: ImageInfo, _ pixels: UnsafeMutableRawPointer, _ rowBytes: Int) -> Canvas {
        let info = imageInfo
        let handle = sk_canvas_new_raster_direct(info.toNative(), pixels, rowBytes, nil)
        return Canvas(handle!, pixels, imageInfo)
    }

    public func clear(color: ColorUInt) {
        sk_canvas_clear(handle, color.color)
    }

    public func drawPath(path: SkPath, color: ColorUInt) {
        sk_canvas_draw_path(handle, path.handle, color.color)
    }

    public func drawFilledPath(path: SkPath, color: ColorUInt) {
        sk_canvas_draw_filled_path(handle, path.handle, color.color)
    }
}
