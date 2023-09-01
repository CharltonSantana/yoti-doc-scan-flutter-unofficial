import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'yoti_flutter_platform_interface.dart';

/// An implementation of [YotiFlutterPlatform] that uses method channels.
class MethodChannelYotiFlutter extends YotiFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('yoti_flutter');

  @override
  Future<int?> startYoti(String sessionId, String sessionToken) async {
    return await methodChannel.invokeMethod<int>(
        'startYoti', {'sessionId': sessionId, 'sessionToken': sessionToken});
  }
}
