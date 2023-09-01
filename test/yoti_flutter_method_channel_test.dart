import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yoti_flutter/yoti_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelYotiFlutter platform = MethodChannelYotiFlutter();
  const MethodChannel channel = MethodChannel('yoti_flutter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return 42;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });
}
