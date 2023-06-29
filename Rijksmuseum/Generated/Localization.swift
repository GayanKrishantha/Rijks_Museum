// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// First Maker: 
  public static let firstMaker = L10n.tr("Localizable", "first_maker")
  /// Loading..
  public static let loading = L10n.tr("Localizable", "loading")
  /// Medium: 
  public static let medium = L10n.tr("Localizable", "medium")

  public enum Alert {
    /// Cancel
    public static let cancelButton = L10n.tr("Localizable", "alert.cancel_button")
  }

  public enum Error {
    /// Bad Request
    public static let general = L10n.tr("Localizable", "error.general")
    /// Check the Connection
    public static let noInternet = L10n.tr("Localizable", "error.noInternet")
    /// No Result
    public static let notFound = L10n.tr("Localizable", "error.notFound")
    /// Internal Server Error
    public static let serverError = L10n.tr("Localizable", "error.serverError")
    /// Timeout
    public static let timeOut = L10n.tr("Localizable", "error.timeOut")
    /// Error!
    public static let title = L10n.tr("Localizable", "error.title")
  }

  public enum Label {
    /// Art collection
    public static let artCollection = L10n.tr("Localizable", "label.art_collection")
    /// NA
    public static let notAvailable = L10n.tr("Localizable", "label.not_available")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
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
