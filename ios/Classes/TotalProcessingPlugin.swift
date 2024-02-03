import Flutter
import OPPWAMobile
import UIKit

public class TotalProcessingPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    static let handleCheckoutResultEvent = "handleCheckoutResult"
    private var handleCheckoutResultSink:FlutterEventSink?
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        switch arguments as? String{
        case TotalProcessingPlugin.handleCheckoutResultEvent:
            handleCheckoutResultSink = events
        default: 
            break
        }
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil;
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "total_processing", binaryMessenger: registrar.messenger())
    let instance = TotalProcessingPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "checkoutSettings":
        if let args = call.arguments as? [String:Any]{
            let paymentBrands = args["paymentBrands"] as! Array<String>
            checkoutSettings.paymentBrands = paymentBrands
            
            let shopperResultURL = args["shopperResultURL"] as! String
            checkoutSettings.shopperResultURL = shopperResultURL
        }else{
            result(FlutterError(code: "InvalidArgumentt", message: "Invalid argument for 'bmac',", details: nil))
        }
    case "startCheckout":
        if let args = call.arguments as? [String:Any]{
            let checkoutID = args["checkoutID"] as! String
            startCheckout(checkoutID: checkoutID)
        }else{
            result(FlutterError(code: "InvalidArgumentt", message: "Invalid argument for 'bmac',", details: nil))
        }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    let provider = OPPPaymentProvider(mode: OPPProviderMode.test)
    let checkoutSettings = OPPCheckoutSettings()
    
    
    
    
    private func startCheckout(checkoutID: String) {
        let checkoutProvider = OPPCheckoutProvider(paymentProvider: provider, checkoutID: checkoutID, settings: checkoutSettings)
        
        // Since version 2.13.0
        checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
            if transaction?.type == .synchronous {
                // If a transaction is synchronous, just request the payment status
                // You can use transaction.resourcePath or just checkout ID to do it
                // Error is no more an decisive factor for transaction termination
                if ((transaction?.resourcePath) != nil) {
                     // get the payment status using the resourcePath
                }
            } else if transaction?.type == .asynchronous {
                // The SDK opens transaction.redirectUrl in a browser
                // See 'Asynchronous Payments' guide for more details
            }
        }, cancelHandler: {
            // Executed if the shopper closes the payment page prematurely
        })
        
    }
    
}
