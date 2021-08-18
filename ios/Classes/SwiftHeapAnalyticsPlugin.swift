import Flutter
import UIKit

public class SwiftHeapAnalyticsPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "heap_analytics", binaryMessenger: registrar.messenger())
        let instance = SwiftHeapAnalyticsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initHeap":
            initHeap(arguments: call.arguments as! NSDictionary, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func initHeap(arguments: NSDictionary, result: @escaping FlutterResult) {
        if(arguments["appId"] != nil) {
            let appId = arguments["appId"] as! String
            let options = HeapOptions()
            options.disableTouchAutocapture = true
            options.disableTextCapture = true
            Heap.initialize(appId, with: options)
        } else {
            result(FlutterError.init(code: "BAD_ARGS",
                                     message: "No appId provided",
                                     details: nil))
        }
    }
    
}
