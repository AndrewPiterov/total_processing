import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'total_processing_platform_interface.dart';

/// An implementation of [TotalProcessingPlatform] that uses method channels.
class MethodChannelTotalProcessing extends TotalProcessingPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('total_processing');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
