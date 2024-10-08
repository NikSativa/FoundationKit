#if canImport(UIKit)
import UIKit

public extension UIColor {
    /// compress 4 cases to 2
    enum Style: Equatable {
        case light
        case dark
    }

    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
        assert(0...255 ~= red, "Invalid red component")
        assert(0...255 ~= green, "Invalid green component")
        assert(0...255 ~= blue, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: alpha)
    }

    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(red: Int(hex & 0xFF0000) >> 16,
                  green: Int(hex & 0x00FF00) >> 8,
                  blue: Int(hex & 0x0000FF) >> 0,
                  alpha: alpha)
    }

    convenience init(hexWithAlpha hex: UInt) {
        self.init(red: Int(hex & 0xFF000000) >> 24,
                  green: Int(hex & 0x00FF0000) >> 16,
                  blue: Int(hex & 0x0000FF00) >> 8,
                  alpha: CGFloat(Int(hex & 0x000000FF) >> 0) / 255)
    }

    #if !os(watchOS)
    static func colorWith(dynamicProvider provider: @escaping (Style) -> UIColor) -> UIColor {
        return .init(dynamicProvider: { traits in
            switch traits.userInterfaceStyle {
            case .dark:
                return provider(.dark)
            case .light,
                 .unspecified:
                return provider(.light)
            @unknown default:
                return provider(.light)
            }
        })
    }

    static func colorWith(light: UInt,
                          dark: UInt? = nil,
                          hexWithAlpha: Bool = false,
                          alpha: CGFloat = 1.0) -> UIColor {
        return colorWith(dynamicProvider: { style in
            switch (hexWithAlpha, style) {
            case (true, .light):
                return .init(hexWithAlpha: light)
            case (false, .light):
                return .init(hex: light, alpha: alpha)
            case (true, .dark):
                let hex = dark ?? light
                return .init(hexWithAlpha: hex)
            case (false, .dark):
                let hex = dark ?? light
                return .init(hex: hex, alpha: alpha)
            }
        })
    }
    #endif
}

public extension UIColor {
    struct Components {
        fileprivate var _base: UIColor

        public var rgba: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0

            _base.getRed(&r, green: &g, blue: &b, alpha: &a)
            return (r, g, b, a)
        }

        public var hsva: (h: CGFloat, s: CGFloat, v: CGFloat, a: CGFloat) {
            var h: CGFloat = 0
            var s: CGFloat = 0
            var v: CGFloat = 0
            var a: CGFloat = 0

            _base.getHue(&h, saturation: &s, brightness: &v, alpha: &a)
            return (h, s, v, a)
        }

        public var hex: UInt {
            let rgba = rgba
            let irgba: (r: Int, g: Int, b: Int, a: Int) = (Int(rgba.r * 255) & 0xFF,
                                                           Int(rgba.g * 255) & 0xFF,
                                                           Int(rgba.b * 255) & 0xFF,
                                                           Int(rgba.a * 255) & 0xFF)
            let urgba: (r: Int, g: Int, b: Int, a: Int) = (irgba.r << 24,
                                                           irgba.r << 16,
                                                           irgba.r << 8,
                                                           irgba.r << 0)
            return UInt(urgba.r | urgba.g | urgba.b | urgba.a)
        }
    }

    var components: UIColor.Components {
        return Components(_base: self)
    }
}
#endif
