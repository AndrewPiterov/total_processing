import 'package:flutter/services.dart';

class TotalProcessingPlugin {
  final methodChannel = const MethodChannel('total_processing');

  ///Configure the Checkout Settings
  ///Initialize CheckoutSettings with received checkout ID,
  ///it controls the information that is shown to the shopper.
  void checkoutSettings({
    required List<String> paymentBrands,
    required String shopperResultURL,
  }) {
    methodChannel.invokeMethod('checkoutSettings',
        {'shopperResultURL': shopperResultURL, 'paymentBrands': paymentBrands});
  }

  ///Present the Checkout Page
  void startCheckout({required String checkoutId}) {
    methodChannel.invokeMethod('startCheckout', {
      'checkoutId': checkoutId,
    });
  }

  ///Handle Checkout Result
  final EventChannel _handleCheckoutResult =
      const EventChannel('handleCheckoutResult');
  Stream get handleCheckoutResultStream => _handleCheckoutResult
      .receiveBroadcastStream(_handleCheckoutResult.name)
      .cast();
}
