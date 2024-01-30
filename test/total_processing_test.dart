import 'package:flutter_test/flutter_test.dart';
import 'package:total_processing/total_processing.dart';
import 'package:total_processing/total_processing_platform_interface.dart';
import 'package:total_processing/total_processing_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTotalProcessingPlatform
    with MockPlatformInterfaceMixin
    implements TotalProcessingPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TotalProcessingPlatform initialPlatform = TotalProcessingPlatform.instance;

  test('$MethodChannelTotalProcessing is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTotalProcessing>());
  });

  test('getPlatformVersion', () async {
    TotalProcessing totalProcessingPlugin = TotalProcessing();
    MockTotalProcessingPlatform fakePlatform = MockTotalProcessingPlatform();
    TotalProcessingPlatform.instance = fakePlatform;

    expect(await totalProcessingPlugin.getPlatformVersion(), '42');
  });
}
