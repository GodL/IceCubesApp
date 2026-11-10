import Foundation

public enum AppInfo {
  public static let appStoreAppId = "6444915884"
  public static let clientName = "IceCubesApp"
  public static let scheme = "icecubesapp://"
  public static let scopes = "read write follow push"
  public static let weblink = "https://github.com/Dimillian/IceCubesApp"
  public static let revenueCatKey = "appl_JXmiRckOzXXTsHKitQiicXCvMQi"
  public static let defaultServer = "mastodon.social"
  /// Keychain access group shared by the app and its extensions.
  ///
  /// Read from the `KeychainGroup` Info.plist entry, which Xcode expands from
  /// `$(AppIdentifierPrefix)$(BUNDLE_ID_PREFIX).IceCubesApp` so that it always matches the
  /// `keychain-access-groups` entitlement of the signed targets. Returns `nil` when the
  /// entitlement is unavailable (simulator, unsigned build, or entitlement removed), and
  /// KeychainSwift then falls back to the target's default access group.
  public static let keychainGroup: String? = {
    guard
      let group = Bundle.main.object(forInfoDictionaryKey: "KeychainGroup") as? String,
      !group.isEmpty,
      !group.contains("$(")
    else { return nil }

    // `AppIdentifierPrefix` is only filled in for signed builds, so an unsigned build yields
    // something like `com.example.IceCubesApp`. Only accept `<10-char team id>.<bundle prefix>…`
    // and otherwise fall back to the target's default access group.
    let components = group.split(separator: ".", omittingEmptySubsequences: false)
    guard
      components.count >= 3,
      let prefix = components.first,
      prefix.count == 10,
      prefix.allSatisfy({ $0.isASCII && ($0.isLetter || $0.isNumber) })
    else { return nil }

    return group
  }()
}
