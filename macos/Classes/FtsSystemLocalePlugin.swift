import Cocoa
import FlutterMacOS

public class FtsSystemLocalePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "fts_system_locale", binaryMessenger: registrar.messenger)
    let instance = FtsSystemLocalePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    case "setLocale":
      let arguments = call.arguments as! Dictionary<String, Any>
      let locale = arguments["locale"] as! String
      let userDefaults = UserDefaults.standard
      userDefaults.set([locale], forKey: "AppleLanguages")
//       userDefaults.synchronize()
      result("Locale set to \(locale)")
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
