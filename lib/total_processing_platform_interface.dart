import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'total_processing_method_channel.dart';

abstract class TotalProcessingPlatform extends PlatformInterface {
  /// Constructs a TotalProcessingPlatform.
  TotalProcessingPlatform() : super(token: _token);

  static final Object _token = Object();

  static TotalProcessingPlatform _instance = MethodChannelTotalProcessing();

  /// The default instance of [TotalProcessingPlatform] to use.
  ///
  /// Defaults to [MethodChannelTotalProcessing].
  static TotalProcessingPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TotalProcessingPlatform] when
  /// they register themselves.
  static set instance(TotalProcessingPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
