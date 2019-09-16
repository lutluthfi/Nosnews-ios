// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum Article: StoryboardType {
    internal static let storyboardName = "Article"

    internal static let initialScene = InitialSceneType<Nosnews.ArticleViewController>(storyboard: Article.self)

    internal static let articleViewController = SceneType<Nosnews.ArticleViewController>(storyboard: Article.self, identifier: "ArticleViewController")
  }
  internal enum Category: StoryboardType {
    internal static let storyboardName = "Category"

    internal static let initialScene = InitialSceneType<Nosnews.CategoryViewController>(storyboard: Category.self)

    internal static let categoryViewController = SceneType<Nosnews.CategoryViewController>(storyboard: Category.self, identifier: "CategoryViewController")
  }
  internal enum CountryCode: StoryboardType {
    internal static let storyboardName = "CountryCode"

    internal static let initialScene = InitialSceneType<Nosnews.CountryCodeViewController>(storyboard: CountryCode.self)

    internal static let countryCodeViewController = SceneType<Nosnews.CountryCodeViewController>(storyboard: CountryCode.self, identifier: "CountryCodeViewController")
  }
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum Main: StoryboardType {
    internal static let storyboardName = "Main"

    internal static let initialScene = InitialSceneType<UIKit.UINavigationController>(storyboard: Main.self)

    internal static let mainViewController = SceneType<Nosnews.MainViewController>(storyboard: Main.self, identifier: "MainViewController")
  }
  internal enum PostLaunchScreen: StoryboardType {
    internal static let storyboardName = "PostLaunchScreen"
  }
  internal enum Source: StoryboardType {
    internal static let storyboardName = "Source"

    internal static let sourceViewController = SceneType<Nosnews.SourceViewController>(storyboard: Source.self, identifier: "SourceViewController")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

private final class BundleToken {}