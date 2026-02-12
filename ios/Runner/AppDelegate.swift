import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller = window?.rootViewController as! FlutterViewController
      
      // 创建与 Dart 端同名的 MethodChannel
      let channel = FlutterMethodChannel(
        name: "com.wallet.core/native",
        binaryMessenger: controller.binaryMessenger
      )
      
      // 设置方法调用处理器
      channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
          switch call.method {
          case "createWallet":
              print("调用了创建钱包")
              guard let wallet = HDWalletService().createWallet() else {
                  return(nil)
              }
              
              result(wallet) // 返回结果给 Flutter
          case "restoreWallet":
              debugPrint("调用了导入钱包")
              
              guard let mnemonic = call.arguments as? String else {
                  return
              }
              print("助记词====\(mnemonic)")
              result(mnemonic)
              
          default:
              result(FlutterMethodNotImplemented)
          }
      }
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
