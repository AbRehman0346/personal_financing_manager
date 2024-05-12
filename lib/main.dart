import 'dart:developer';
import 'package:expense_tracking/screens/splash_screen.dart';
import 'package:expense_tracking/services/messaging/messaging.dart';
import 'package:expense_tracking/services/notification/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();
  await Messaging().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundNotificationHandler);
  runApp(const MyApp());
}

@pragma("vm:entry-point")
Future<void> _firebaseBackgroundNotificationHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (message.notification != null){
    String title = message.notification!.title.toString();
    String content = message.notification!.body.toString();
    log("Title: $title");
    log("Content: $content");
    NotificationService().createNotification(title: title, content: content);
  }else{
    log("Error: Notification is null");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
