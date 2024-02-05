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

  ///Handle Checkout Result
  final EventChannel _handleCheckoutResult =
      const EventChannel('handleCheckoutResult');
  Stream get handleCheckoutResultStream => _handleCheckoutResult
      .receiveBroadcastStream(_handleCheckoutResult.name)
      .cast();
}
