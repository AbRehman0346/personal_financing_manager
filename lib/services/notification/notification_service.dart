import 'package:app_settings/app_settings.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService{
    static String notificationKey = "basic-notification";
    static Future<void> init()async {
        AwesomeNotifications noti = AwesomeNotifications();
        noti.initialize(null, [
            NotificationChannel(
                channelKey: notificationKey,
                channelName: "basic",
                channelDescription: "basic notifications",
                importance: NotificationImportance.Max,
            ),
        ],
        debug: true,
        );

        bool isAllowed = await noti.isNotificationAllowed();

        if (!isAllowed){
            await noti.requestPermissionToSendNotifications();
            bool isAllowed = await noti.isNotificationAllowed();
            if (!isAllowed){
                AppSettings.openAppSettings(type: AppSettingsType.notification);
            }
        }
    }

    Future<void> createNotification ({
        int id = 1,
        required String title,
        required String content,
    })async{
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: id,
                channelKey: notificationKey,
                title: title,
                body: content,
            ),
        );
    }
}