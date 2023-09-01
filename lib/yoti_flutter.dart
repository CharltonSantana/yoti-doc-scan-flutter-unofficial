import 'yoti_flutter_platform_interface.dart';

class YotiFlutter {
  Future<int?> startYoti(String sessionId, String sessionToken) {
    return YotiFlutterPlatform.instance.startYoti(sessionId, sessionToken);
  }
}
