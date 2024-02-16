import 'package:flutter/services.dart';
import 'package:total_processing/src/total_processing_checkout_settings.dart';

class TotalProcessingPlugin {
  final methodChannel = const MethodChannel('total_processing');

  ///Start the Checkout Page
  /// and
  ///Configure the Checkout Settings
  ///it controls the information that is shown to the shopper.
  void startCheckout({
    required String checkoutId,
    required TotalProcessingCheckoutSettings settings,
  }) {
    methodChannel.invokeMethod('startCheckout', {
      'checkoutId': checkoutId,
      'shopperResultURL': settings.shopperResultURL,
      'paymentBrands': settings.paymentBrands
    });
  }

  void customUIPay({
    required String checkoutID,
    required String cardHolder,
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvc,
    required String cardBrand,
    required String shopperResultUrl,
  }) {
    methodChannel.invokeMethod('customUIPay', {
      'checkoutId': checkoutID,
      'cardHolder': cardHolder,
      'cardNumber': cardNumber,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'cvc': cvc,
      'cardBrand': cardBrand,
      'shopperResultUrl': shopperResultUrl,
    });
  }

  ///Handle Checkout Result
  final EventChannel _handleCheckoutResult =
      const EventChannel('handleCheckoutResult');
  Stream get handleCheckoutResultStream => _handleCheckoutResult
      .receiveBroadcastStream(_handleCheckoutResult.name)
      .cast();

  ///Handle Custom UI Result
  final EventChannel _customUIResult = const EventChannel('customUIResult');
  Stream get customUIResultStream =>
      _customUIResult.receiveBroadcastStream(_customUIResult.name).cast();
}
