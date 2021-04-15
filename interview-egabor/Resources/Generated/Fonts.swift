// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
public typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum Fonts {
  public enum LibreFranklin {
    public static let black = FontConvertible(name: "LibreFranklin-Black", family: "Libre Franklin", path: "LibreFranklin-Black.ttf")
    public static let blackItalic = FontConvertible(name: "LibreFranklin-BlackItalic", family: "Libre Franklin", path: "LibreFranklin-BlackItalic.ttf")
    public static let bold = FontConvertible(name: "LibreFranklin-Bold", family: "Libre Franklin", path: "LibreFranklin-Bold.ttf")
    public static let boldItalic = FontConvertible(name: "LibreFranklin-BoldItalic", family: "Libre Franklin", path: "LibreFranklin-BoldItalic.ttf")
    public static let extraBold = FontConvertible(name: "LibreFranklin-ExtraBold", family: "Libre Franklin", path: "LibreFranklin-ExtraBold.ttf")
    public static let extraBoldItalic = FontConvertible(name: "LibreFranklin-ExtraBoldItalic", family: "Libre Franklin", path: "LibreFranklin-ExtraBoldItalic.ttf")
    public static let extraLight = FontConvertible(name: "LibreFranklin-ExtraLight", family: "Libre Franklin", path: "LibreFranklin-ExtraLight.ttf")
    public static let extraLightItalic = FontConvertible(name: "LibreFranklin-ExtraLightItalic", family: "Libre Franklin", path: "LibreFranklin-ExtraLightItalic.ttf")
    public static let italic = FontConvertible(name: "LibreFranklin-Italic", family: "Libre Franklin", path: "LibreFranklin-Italic.ttf")
    public static let light = FontConvertible(name: "LibreFranklin-Light", family: "Libre Franklin", path: "LibreFranklin-Light.ttf")
    public static let lightItalic = FontConvertible(name: "LibreFranklin-LightItalic", family: "Libre Franklin", path: "LibreFranklin-LightItalic.ttf")
    public static let medium = FontConvertible(name: "LibreFranklin-Medium", family: "Libre Franklin", path: "LibreFranklin-Medium.ttf")
    public static let mediumItalic = FontConvertible(name: "LibreFranklin-MediumItalic", family: "Libre Franklin", path: "LibreFranklin-MediumItalic.ttf")
    public static let regular = FontConvertible(name: "LibreFranklin-Regular", family: "Libre Franklin", path: "LibreFranklin-Regular.ttf")
    public static let semiBold = FontConvertible(name: "LibreFranklin-SemiBold", family: "Libre Franklin", path: "LibreFranklin-SemiBold.ttf")
    public static let semiBoldItalic = FontConvertible(name: "LibreFranklin-SemiBoldItalic", family: "Libre Franklin", path: "LibreFranklin-SemiBoldItalic.ttf")
    public static let thin = FontConvertible(name: "LibreFranklin-Thin", family: "Libre Franklin", path: "LibreFranklin-Thin.ttf")
    public static let thinItalic = FontConvertible(name: "LibreFranklin-ThinItalic", family: "Libre Franklin", path: "LibreFranklin-ThinItalic.ttf")
    public static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extraBold, extraBoldItalic, extraLight, extraLightItalic, italic, light, lightItalic, medium, mediumItalic, regular, semiBold, semiBoldItalic, thin, thinItalic]
  }
  public enum Merriweather {
    public static let black = FontConvertible(name: "Merriweather-Black", family: "Merriweather", path: "Merriweather-Black.ttf")
    public static let blackItalic = FontConvertible(name: "Merriweather-BlackItalic", family: "Merriweather", path: "Merriweather-BlackItalic.ttf")
    public static let bold = FontConvertible(name: "Merriweather-Bold", family: "Merriweather", path: "Merriweather-Bold.ttf")
    public static let boldItalic = FontConvertible(name: "Merriweather-BoldItalic", family: "Merriweather", path: "Merriweather-BoldItalic.ttf")
    public static let italic = FontConvertible(name: "Merriweather-Italic", family: "Merriweather", path: "Merriweather-Italic.ttf")
    public static let light = FontConvertible(name: "Merriweather-Light", family: "Merriweather", path: "Merriweather-Light.ttf")
    public static let lightItalic = FontConvertible(name: "Merriweather-LightItalic", family: "Merriweather", path: "Merriweather-LightItalic.ttf")
    public static let regular = FontConvertible(name: "Merriweather-Regular", family: "Merriweather", path: "Merriweather-Regular.ttf")
    public static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, italic, light, lightItalic, regular]
  }
  public static let allCustomFonts: [FontConvertible] = [LibreFranklin.all, Merriweather.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct FontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(OSX)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

public extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
