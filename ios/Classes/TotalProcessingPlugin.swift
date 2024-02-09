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
    let handleCheckoutResultChannel = FlutterEventChannel(name: handleCheckoutResultEvent, binaryMessenger: registrar.messenger())
    handleCheckoutResultChannel.setStreamHandler(instance)
  }
    

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "startCheckout":
        if let args = call.arguments as? [String:Any]{
            let checkoutID = args["checkoutId"] as! String
            
            let paymentBrands = args["paymentBrands"] as! Array<String>
            checkoutSettings.paymentBrands = paymentBrands
            
            let shopperResultURL = args["shopperResultURL"] as! String
            checkoutSettings.shopperResultURL = shopperResultURL
            
            startCheckout(checkoutID: checkoutID)
        }else{
            result(FlutterError(code: "InvalidArgumentt", message: "Invalid argument", details: nil))
        }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    let provider = OPPPaymentProvider(mode: OPPProviderMode.test)
    let checkoutSettings = OPPCheckoutSettings()
    
    
    private func startCheckout(checkoutID: String) {
        let checkoutProvider = OPPCheckoutProvider(paymentProvider: provider, checkoutID: checkoutID, settings: checkoutSettings)
        var item: [String: Any?] = [:]
        // Since version 2.13.0
        checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
            guard let transaction = transaction else {
                item["isErrored"] = true
                var paymentError: [String: Any?] = [:]
                paymentError["errorCode"] = "401"
                paymentError["errorInfo"] = "error"
                paymentError["errorMessage"] = error?.localizedDescription
                item["paymentError"] = paymentError
                self.handleCheckoutResultSink?(item)
                return
            }
            
            var trans: [String: Any?] = [:]
            if transaction.type == .synchronous {
                trans["transactionType"] = "synchronous"
            } else if transaction.type == .asynchronous {
                trans["transactionType"] = "asynchronous"
            }
            var paymentParams: [String: Any?] = [:]
            paymentParams["checkoutId"] = checkoutID
            trans["paymentParams"] = paymentParams
            trans["desc"] = transaction.description
            item["transaction"] = trans
            self.handleCheckoutResultSink?(item)
        }, cancelHandler: {
            // Executed if the shopper closes the payment page prematurely
            item["isCanceled"] = true
            self.handleCheckoutResultSink?(item)
        })
        
    }
    
}
