import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let nativeViewMehodChannel = FlutterMethodChannel(name: "appunite.flutter/nativeView",
                                                  binaryMessenger: controller.binaryMessenger)
        listenOn(methodChannel: nativeViewMehodChannel, controller: controller)
        
        let reg = registrar(forPlugin: "AppUnite")
        let flutterCounterViewFactory = FlutterCounterViewFactory(binaryMessenger: reg.messenger())
        let flutterButtonViewFactory = FlutterButtonViewFactory(binaryMessenger: reg.messenger())
        reg.register(flutterCounterViewFactory, withId: "nativeCounter")
        reg.register(flutterButtonViewFactory, withId: "nativeButton")
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func listenOn(methodChannel: FlutterMethodChannel, controller: FlutterViewController) {
        methodChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            guard call.method == "nativeView" else {
                result(FlutterMethodNotImplemented)
                return
            }
            
            DispatchQueue.main.async {
                self?.showNativeView(controller: controller)
            }
        })
    }
    
    private func showNativeView(controller: FlutterViewController) {
        let controller2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        controller.present(controller2, animated: true)
    }
}
