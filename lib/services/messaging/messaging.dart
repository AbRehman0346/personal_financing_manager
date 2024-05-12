import 'dart:convert';
import 'dart:developer';
import 'package:expense_tracking/services/notification/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class Messaging {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final String _serverMessagingKey = "AAAAF8M0gCk:APA91bHjfwFNlEQjasto1gtaFE0De0eDwmdgTWFH9IkfuG1PbnFEkgRAvl3MaqtOKY1b0zBRjj2qazG1yDFdTwVnirdroY9NLzJDSzt8f5y6O2-aSV-M9L09MibxDTAcwiYmqOvsLg_Y";

  Future<void> init() async {
    var settings = await _messaging.requestPermission(
      sound: true,
      provisional: true,
      criticalAlert: true,
      carPlay: true,
      badge: true,
      announcement: true,
      alert: true,
    );

    var authorization = settings.authorizationStatus;
    var enable = AppleNotificationSetting.enabled;
    NotificationSettings(
      alert: enable,
      announcement: enable,
      authorizationStatus: authorization,
      badge: enable,
      carPlay: enable,
      lockScreen: enable,
      notificationCenter: enable,
      showPreviews: AppleShowPreviewSetting.always,
      timeSensitive: enable,
      criticalAlert: enable,
      sound: enable,
    );
    String? token = await getToken();
    log("Device Token: $token");
    onMessage();
  }

  Future<String?> getToken() async {
    // log("Getting token now");
    refreshToken();
    return await _messaging.getToken();
  }

  Future<void> refreshToken() async {
    _messaging.onTokenRefresh.listen((event) {
      // TODO: Need to send that refreshed token to database and replace the old token there.
      // log("Token Refreshed");
    });
  }

  void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        String title = message.notification!.title.toString();
        String content = message.notification!.body.toString();
        // log("Title: $title");
        // log("Content: $content");
        NotificationService()
            .createNotification(title: title, content: content);
      } else {
        log("Error: Notification is null");
      }
    });
  }

  void sendNotificationToDevice(
      String title, String body, List<String> deviceIds) async {
    var data = {
      "registration_ids": deviceIds,
      "priority": "high",
      "notification": {
        "title": title,
        "body": body,
      },
      // "data": {"type": "none"}
    };
    await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization":
              'key=$_serverMessagingKey',
        });
  }
}
