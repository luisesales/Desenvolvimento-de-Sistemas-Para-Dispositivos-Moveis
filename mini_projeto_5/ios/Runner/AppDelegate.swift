import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  dependencies: [
    .package(url: "https://github.com/SwiftOnTheServer/SwiftDotenv.git", from: "2.0.0")
]
  override func application(  
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  GMSServices.provideAPIKey(API_KEY)
    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: -> Bool {
    GMSServices.provideAPIKey(API_KEY)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
