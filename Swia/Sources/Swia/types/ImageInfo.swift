#if canImport(CSkia)
import CSkia
#endif

public struct ImageInfo {
    public var width: Int32
    public var height: Int32
    public var colorType: ColorType
    public var alphaType: AlphaType

    public init(width: Int32, height: Int32, colorType: ColorType, alphaType: AlphaType) {
        self.width = width
        self.height = height
        self.colorType = colorType
        self.alphaType = alphaType
    }

    func toNative() -> sk_imageinfo_t {
        return sk_imageinfo_t(
            width: self.width,
            height: self.height,
            colorType: self.colorType.toNative(),
            alphaType: self.alphaType.toNative())
    }

    static func fromNative(_ x: sk_imageinfo_t) -> ImageInfo {
        ImageInfo(
            width: x.width,
            height: x.height,
            colorType: ColorType.fromNative(x.colorType),
            alphaType: AlphaType.fromNative(x.alphaType))
    }

    public var bytesPerPixel: Int32 {
        switch colorType {
        case .unknown:
            return 0
        case .alpha8, .gray8:
            return 1
        case .rgb565, .argb4444:
            return 2
        case .rgba8888, .bgra8888, .rgb888x, .rgba1010102, .bgra1010102, .rgb101010X, .bgr101010X:
            return 4
        case .rgbaF16, .rgbaF16Normalized:
            return 8
        case .rgbaF32:
            return 16
        }
    }

    public var bytesSize: Int32 {
        width * height * bytesPerPixel
    }

    public var rowBytes: Int32 {
        width * bytesPerPixel
    }
}
