#if canImport(CSkia)
import CSkia
#endif

public enum ColorType: UInt32 {
    /// Uninitialized
    case unknown = 0
    case alpha8
    case rgb565
    case argb4444
    case rgba8888
    case rgb888x
    case bgra8888
    case rgba1010102
    case bgra1010102
    case rgb101010X
    case bgr101010X
    case gray8
    case rgbaF16Normalized
    case rgbaF16
    case rgbaF32

    internal func toNative() -> sk_colortype_t {
        return sk_colortype_t.init(sk_colortype_t.RawValue(rawValue))
    }

    internal static func fromNative(_ x: sk_colortype_t) -> ColorType {
        return ColorType.init(rawValue: ColorType.RawValue(x.rawValue))!
    }
}

public enum AlphaType: UInt32 {
    /// Uninitialized
    case unknown = 0

    /// Pixel is opaque
    case opaque

    /// Pixel components are premultiplied by the alpha
    case premultiplied

    /// Pixel components are independent of the alpha
    case unpremultiplied

    internal func toNative() -> sk_alphatype_t {
        return sk_alphatype_t.init(sk_alphatype_t.RawValue(rawValue))
    }

    internal static func fromNative(_ x: sk_alphatype_t) -> AlphaType {
        return AlphaType.init(rawValue: AlphaType.RawValue(x.rawValue))!
    }
}
