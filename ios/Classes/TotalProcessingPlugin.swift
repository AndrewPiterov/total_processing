import Flutter
import OPPWAMobile
import UIKit

public class TotalProcessingPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    static let handleCheckoutResultEvent = "handleCheckoutResult"
    private var handleCheckoutResultSink: FlutterEventSink?
    
    static let customUIResultEvent = "customUIResult"
    private var customUIResultSink: FlutterEventSink?
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        switch arguments as? String {
        case TotalProcessingPlugin.handleCheckoutResultEvent:
            self.handleCheckoutResultSink = events
        case TotalProcessingPlugin.customUIResultEvent:
            self.customUIResultSink = events
        default:
            break
        }
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "total_processing", binaryMessenger: registrar.messenger())
        let instance = TotalProcessingPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        let handleCheckoutResultChannel = FlutterEventChannel(name: handleCheckoutResultEvent, binaryMessenger: registrar.messenger())
        handleCheckoutResultChannel.setStreamHandler(instance)
        
        let customUIResultChannel = FlutterEventChannel(name: customUIResultEvent, binaryMessenger: registrar.messenger())
        customUIResultChannel.setStreamHandler(instance)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startCheckout":
            if let args = call.arguments as? [String: Any] {
                let checkoutID = args["checkoutId"] as! String
            
                let paymentBrands = args["paymentBrands"] as! [String]
                self.checkoutSettings.paymentBrands = paymentBrands
            
                let shopperResultURL = args["shopperResultURL"] as! String
                self.checkoutSettings.shopperResultURL = shopperResultURL
            
                self.startCheckout(checkoutID: checkoutID)
            } else {
                result(FlutterError(code: "InvalidArgumentt", message: "Invalid argument", details: nil))
            }
        case "customUIPay":
            if let args = call.arguments as? [String: Any] {
                let checkoutID = args["checkoutId"] as! String
                let cardHolder = args["cardHolder"] as! String
                let cardNumber = args["cardNumber"] as! String
                if !OPPCardPaymentParams.isNumberValid(cardNumber,luhnCheck: true) {
                    var item: [String: Any?] = [:]
                    item["isErrored"] = true
                    var paymentError: [String: Any?] = [:]
                    paymentError["errorCode"] = "cardNumber"
                    paymentError["errorInfo"] = "Invalid card number"
                    paymentError["errorMessage"] = "Invalid card number"
                    item["paymentError"] = paymentError
                    self.customUIResultSink?(item)
                } else {
                    let expiryMonth = args["expiryMonth"] as! String
                    let expiryYear = args["expiryYear"] as! String
                    let cvc = args["cvc"] as! String
                    let cardBrand = args["cardBrand"] as! String
                
                    let shopperResultURL = args["shopperResultUrl"] as! String
           
                    guard let transaction = self.createTransaction(checkoutID: checkoutID, cardHolder: cardHolder, cardNumber: cardNumber, expiryMonth: expiryMonth, expiryYear: expiryYear, cvc: cvc, cardBrand: cardBrand, shopperResultURL: shopperResultURL) else {
                        var item: [String: Any?] = [:]
                        item["isCanceled"] = true
                        self.customUIResultSink?(item)
                        return
                    }
                    
                    self.provider.submitTransaction(transaction, completionHandler: { transaction, error in
                        DispatchQueue.main.async {
                            var item: [String: Any?] = [:]
                            if error != nil {
                                item["isErrored"] = true
                                var paymentError: [String: Any?] = [:]
                                paymentError["errorCode"] = "401"
                                paymentError["errorInfo"] = "error"
                                paymentError["errorMessage"] = error?.localizedDescription
                                item["paymentError"] = paymentError
                                self.customUIResultSink?(item)
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
                            self.customUIResultSink?(item)
                        }
                    })
                }

            } else {
                result(FlutterError(code: "InvalidArgumentt", message: "Invalid argument", details: nil))
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    let provider = OPPPaymentProvider(mode: OPPProviderMode.live)
    let checkoutSettings = OPPCheckoutSettings()
    
    func createTransaction(checkoutID: String, cardHolder: String, cardNumber: String, expiryMonth: String, expiryYear: String, cvc: String, cardBrand: String, shopperResultURL: String) -> OPPTransaction? {
        var item: [String: Any?] = [:]
        do {
            let params = try OPPCardPaymentParams(checkoutID: checkoutID, paymentBrand: cardBrand, holder: cardHolder, number: cardNumber, expiryMonth: expiryMonth, expiryYear: "20\(expiryYear)", cvv: cvc)
            params.shopperResultURL = shopperResultURL
            return OPPTransaction(paymentParams: params)
        } catch let error as NSError {
            item["isErrored"] = true
            var paymentError: [String: Any?] = [:]
            paymentError["errorCode"] = "\(error.code)"
            paymentError["errorInfo"] = "\(error.domain)"
            paymentError["errorMessage"] = error.localizedDescription
            item["paymentError"] = paymentError
            self.customUIResultSink?(item)
            return nil
        }
    }
    
    private func startCheckout(checkoutID: String) {
        let checkoutProvider = OPPCheckoutProvider(paymentProvider: provider, checkoutID: checkoutID, settings: checkoutSettings)
        var item: [String: Any?] = [:]
        // Since version 2.13.0
        checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { transaction, error in
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
