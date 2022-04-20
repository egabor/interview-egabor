// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Localized {

  public enum News {
    /// News
    public static let title = Localized.tr("Localizable", "news.title")
    public enum Alert {
      public enum Error {
        /// Dismiss
        public static let dismiss = Localized.tr("Localizable", "news.alert.error.dismiss")
        /// Something went wrong.
        public static let generalMessage = Localized.tr("Localizable", "news.alert.error.generalMessage")
        /// Error
        public static let title = Localized.tr("Localizable", "news.alert.error.title")
      }
    }
    public enum SearchField {
      /// Enter keywords
      public static let placeholder = Localized.tr("Localizable", "news.searchField.placeholder")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localized {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
