import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static void initialize() {
    // for ios and web
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((event) {
      print('A new onMessage event was published!');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  static Future<String?> getToken() async {
    return FirebaseMessaging.instance.getToken(
        vapidKey:
            "BF9Wt8KBjxHLyqt5L9gaiCb5fv7y3eE0hNnnWZYqZm8FBLmHL3ArfNzxoia9RtSykylkSiShsUEDujGp0uJS97o");
  }
}
