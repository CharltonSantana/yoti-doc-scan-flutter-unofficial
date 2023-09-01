import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'yoti_flutter_method_channel.dart';

abstract class YotiFlutterPlatform extends PlatformInterface {
  /// Constructs a YotiFlutterPlatform.
  YotiFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static YotiFlutterPlatform _instance = MethodChannelYotiFlutter();

  /// The default instance of [YotiFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelYotiFlutter].
  static YotiFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [YotiFlutterPlatform] when
  /// they register themselves.
  static set instance(YotiFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<int?> startYoti(String sessionId, String sessionToken) {
    throw UnimplementedError('startYoti() has not been implemented.');
  }
}
