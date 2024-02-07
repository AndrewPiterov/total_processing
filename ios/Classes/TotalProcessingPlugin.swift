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
            if transaction?.type == .synchronous {
                // If a transaction is synchronous, just request the payment status
                // You can use transaction.resourcePath or just checkout ID to do it
                // Error is no more an decisive factor for transaction termination
                
//                item["isErrored"] = result.isErrored
//                var paymentError: [String: Any?] = [:]
//                paymentError["errorCode"] = result.paymentError?.errorCode.map { String($0) }
//                paymentError["errorInfo"] = result.paymentError?.errorInfo
//                paymentError["errorMessage"] = result.paymentError?.errorMessage
//                item["paymentError"] = paymentError
          
//
//                var transaction: [String: Any?] = [:]
//                transaction["transactionType"] = result.transaction?.transactionType.map { String($0) }
//                var paymentParams: [String: Any?] = [:]
//                paymentParams["checkoutId"] = result.transaction?.paymentParams?.checkoutId
//                paymentParams["paymentBrand"] = result.transaction?.paymentParams?.paymentBrand
//                paymentParams["shopperResultUrl"] = result.transaction?.paymentParams?.shopperResultUrl
//                transaction["paymentParams"] = paymentParams
//                transaction["brandSpecificInfo"] = result.transaction?.brandSpecificInfo.map { $0.description }
//                transaction["redirectUrl"] = result.transaction?.redirectUrl.map { $0.description }
//                transaction["threeDS2Info"] = result.transaction?.threeDS2Info.map { $0.description }
//                transaction["threeDS2MethodRedirectUrl"] = result.transaction?.threeDS2MethodRedirectUrl.map { $0.description }
//                transaction["yooKassaInfo"] = result.transaction?.yooKassaInfo.map { $0.description }
//                item["transaction"] = transaction
                if ((transaction?.resourcePath) != nil) {
                     // get the payment status using the resourcePath
                    item["resourcePath"] = transaction?.resourcePath
                }
            } else if transaction?.type == .asynchronous {
                // The SDK opens transaction.redirectUrl in a browser
                // See 'Asynchronous Payments' guide for more details
            }
        }, cancelHandler: {
            // Executed if the shopper closes the payment page prematurely
            item["isCanceled"] = true
        })
        
    }
    
}
