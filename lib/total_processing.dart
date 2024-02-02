import 'package:flutter/services.dart';

class TotalProcessing {
  final methodChannel = const MethodChannel('total_processing');

  ///Request Checkout ID
  ///Your app should request a checkout ID from your server.
  /// ex:amount=48.99 & currency=EUR & paymentType=DB
  Future<String?> requestCheckoutId(
      {required String amount,
      required String currency,
      required String paymentType}) {
    return methodChannel.invokeMethod('requestCheckoutId',
        {'amount': amount, 'currency': currency, 'paymentType': paymentType});
  }

  ///Configure the Checkout Settings
  ///Initialize CheckoutSettings with received checkout ID,
  ///it controls the information that is shown to the shopper.
  void _checkoutSettings(
      {required String checkoutId,
      required List<String> paymentBrands,
      required TotalProcessingMode mode}) {
    methodChannel.invokeMethod('checkoutSettings', {
      'checkoutId': checkoutId,
      'paymentBrands': paymentBrands,
      'mode': mode
    });
  }

  ///Present the Checkout Page
  void startCheckout(
      {required String checkoutId,
      required List<String> paymentBrands,
      required TotalProcessingMode mode}) {
    _checkoutSettings(
        checkoutId: checkoutId, paymentBrands: paymentBrands, mode: mode);
    methodChannel.invokeMethod(
      'startCheckout',
    );
  }

  ///Get the Payment Status
  Future<String?> requestPaymentStatus() {
    return methodChannel.invokeMethod(
      'requestPaymentStatus',
    );
  }

  ///Handle Checkout Result
  final EventChannel _handleCheckoutResult =
      const EventChannel('handleCheckoutResult');
  Stream get handleCheckoutResultStream => _handleCheckoutResult
      .receiveBroadcastStream(_handleCheckoutResult.name)
      .cast();
}

enum TotalProcessingMode { live, test }
