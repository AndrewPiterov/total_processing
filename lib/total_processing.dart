import 'package:flutter/services.dart';

class TotalProcessing {
  final methodChannel = const MethodChannel('total_processing');

  Future<String?> requestCheckoutId() {
    return methodChannel.invokeMethod(
      'requestCheckoutId',
    );
  }

  void _checkoutSettings() {
    methodChannel.invokeMethod(
      'checkoutSettings',
    );
  }

  void startCheckout() {
    methodChannel.invokeMethod(
      'startCheckout',
    );
  }

  Future<String?> requestPaymentStatus() {
    return methodChannel.invokeMethod(
      'requestPaymentStatus',
    );
  }

  final EventChannel _handleCheckoutResult =
      const EventChannel('handleCheckoutResult');
  Stream get handleCheckoutResultStream => _handleCheckoutResult
      .receiveBroadcastStream(_handleCheckoutResult.name)
      .cast();
}
