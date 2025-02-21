// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum WeQuizAsset {
  public enum Assets {
    public static let accentColor = WeQuizColors(name: "AccentColor")
    public static let authenticationOnboardingBackground = WeQuizImages(name: "authentication_onboarding_background")
    public static let authenticationOnboardingLogo = WeQuizImages(name: "authentication_onboarding_logo")
    public static let authenticationFinish = WeQuizImages(name: "authentication_finish")
    public static let bronzeGrade = WeQuizImages(name: "BronzeGrade")
    public static let goldGrade = WeQuizImages(name: "GoldGrade")
    public static let noRank = WeQuizImages(name: "NoRank")
    public static let silverGrade = WeQuizImages(name: "SilverGrade")
    public static let homeEmptyQuestion = WeQuizImages(name: "home_empty_question")
    public static let homeLogo = WeQuizImages(name: "home_logo")
    public static let profileImage = WeQuizImages(name: "profileImage")
    public static let quizMakeSuccess = WeQuizImages(name: "quiz_make_success")
    public static let quizResult01 = WeQuizImages(name: "quiz_result_01")
    public static let quizResult02 = WeQuizImages(name: "quiz_result_02")
    public static let quizResult03 = WeQuizImages(name: "quiz_result_03")
    public static let quizResult04 = WeQuizImages(name: "quiz_result_04")
    public static let quizResult05 = WeQuizImages(name: "quiz_result_05")
    public static let quizSolveBackground = WeQuizImages(name: "quiz_solve_background")
    public static let quizSolveThumbnail = WeQuizImages(name: "quiz_solve_thumbnail")
  }
  public enum PreviewAssets {
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class WeQuizColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension WeQuizColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: WeQuizColors) {
    let bundle = WeQuizResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: WeQuizColors) {
    let bundle = WeQuizResources.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct WeQuizImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = WeQuizResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension WeQuizImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the WeQuizImages.image property")
  convenience init?(asset: WeQuizImages) {
    #if os(iOS) || os(tvOS)
    let bundle = WeQuizResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: WeQuizImages) {
    let bundle = WeQuizResources.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: WeQuizImages, label: Text) {
    let bundle = WeQuizResources.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: WeQuizImages) {
    let bundle = WeQuizResources.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
