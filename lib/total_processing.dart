
import 'total_processing_platform_interface.dart';

class TotalProcessing {
  Future<String?> getPlatformVersion() {
    return TotalProcessingPlatform.instance.getPlatformVersion();
  }
}
