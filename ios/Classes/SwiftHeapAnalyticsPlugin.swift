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
        case "track":
            track(arguments: call.arguments as! NSDictionary, result: result)
        case "identify":
            identify(arguments: call.arguments as! NSDictionary, result: result)
        case "addUserProperties":
            addUserProperties(arguments: call.arguments as! NSDictionary, result: result)
        case "resetIdentity":
            resetIdentity(result: result)
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
            result(nil)
        } else {
            result(FlutterError.init(code: "BAD_ARGS",
                                     message: "No appId provided",
                                     details: nil))
        }
    }
    
    public func track(arguments: NSDictionary, result: @escaping FlutterResult) {
        if(arguments["event"] != nil && arguments["properties"] != nil) {
            let eventName = arguments["event"] as! String
            let properties = arguments["properties"] as! NSDictionary
            Heap.track(eventName, withProperties: properties as? [AnyHashable : Any])
            result(nil)
        } else {
            result(FlutterError.init(code: "BAD_ARGS",
                                     message: "e",
                                     details: nil))
        }
    }
    
    public func identify(arguments: NSDictionary, result: @escaping FlutterResult) {
        if(arguments["id"] != nil) {
            let id = arguments["id"] as! String
            Heap.identify(id)
            result(nil)
        }
        else {
            result(FlutterError.init(code: "BAD_ARGS",
                                     message: "No identity provided",
                                     details: nil))
        }
    }
    
    public func addUserProperties(arguments: NSDictionary, result: @escaping FlutterResult) {
        if(arguments["properties"] != nil) {
            let properties = arguments["properties"] as! NSDictionary
            Heap.addUserProperties(properties as! [AnyHashable : Any])
            result(nil)
        }
        else {
            result(FlutterError.init(code: "BAD_ARGS",
                                     message: "No properties provided",
                                     details: nil))
        }
    }
    
    public func resetIdentity(result: @escaping FlutterResult) {
        Heap.resetIdentity()
        result(nil)
    }
    
}
