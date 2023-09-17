#if canImport(CSkia)
import CSkia
#endif

public struct ColorUInt: ExpressibleByIntegerLiteral, CustomStringConvertible {
    public typealias IntegerLiteralType = UInt32
    public var color: UInt32

    public var r: UInt8 {
        return UInt8(color & 0xFF)
    }

    public var g: UInt8 {
        return UInt8((color >> 8) & 0xFF)
    }

    public var b: UInt8 {
        return UInt8((color >> 16) & 0xFF)
    }

    public var a: UInt8 {
        return UInt8((color >> 24) & 0xFF)
    }

    public init(r: UInt8, g: UInt8, b: UInt8, a: UInt8) {
        self.color = UInt32(a) << 24 | UInt32(b) << 16 | UInt32(g) << 8 | UInt32(r)
    }

    public init(integerLiteral value: UInt32) {
        self.color = value
    }

    public var description: String {
        return "Color(r: \(r), g: \(g), b: \(b), a: \(a))"
    }
}

public struct Color4Float: CustomStringConvertible {
    public var r: Float
    public var g: Float
    public var b: Float
    public var a: Float

    public var description: String {
        return "Color(r: \(r), g: \(g), b: \(b), a: \(a))"
    }

    public init(r: Float, g: Float, b: Float, a: Float) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
}
