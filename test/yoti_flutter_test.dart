import 'package:flutter_test/flutter_test.dart';
import 'package:yoti_flutter/yoti_flutter_platform_interface.dart';
import 'package:yoti_flutter/yoti_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockYotiFlutterPlatform
    with MockPlatformInterfaceMixin
    implements YotiFlutterPlatform {
  @override
  Future<int?> startYoti(String sessionId, String sessionToken) =>
      Future.value(42);
}

void main() {
  final YotiFlutterPlatform initialPlatform = YotiFlutterPlatform.instance;

  test('$MethodChannelYotiFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelYotiFlutter>());
  });
}
