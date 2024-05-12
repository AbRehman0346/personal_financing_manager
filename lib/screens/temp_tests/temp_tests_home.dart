import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracking/route_generator.dart';
import 'package:expense_tracking/screens/temp_tests/test_route_generator.dart';
import 'package:expense_tracking/screens/temp_tests/testscreen2.dart';
import 'package:expense_tracking/services/auth.dart';
import 'package:expense_tracking/services/firestore/firestore.dart';
import 'package:expense_tracking/services/firestore/firestore_auth.dart';
import 'package:expense_tracking/services/messaging/messaging.dart';
import 'package:expense_tracking/services/notification/notification_service.dart';
import 'package:expense_tracking/utils/general_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class TempTestsHome extends StatefulWidget {
  const TempTestsHome({super.key});

  @override
  State<TempTestsHome> createState() => _TempTestsHomeState();
}

class _TempTestsHomeState extends State<TempTestsHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test Screen"),
      actions: [
        TextButton(onPressed: (){
          log(GeneralServices().getIdFromPhone("+92 303 3372287"));
        }
            , child:Text("Tap to Test"))
      ],

      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Sign out"),
            onTap: signoutHandler,
          ),
          ListTile(
            title: const Text("Get Contacts"),
            onTap: getContactsHandler,
          ),
          ListTile(
            title: const Text("Fast Contacts"),
            onTap: getFastContactsHandler,
          ),

          ListTile(
            title: const Text("Show Notification"),
            onTap: notificationHandler,
          ),

          ListTile(
            title: const Text("Get Messaging Device Token"),
            onTap: getFirebaseMessagingDeviceToken,
          ),

          ListTile(
            title: const Text("Test screen 2"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => TestScreen2()));
            },
          ),

          ListTile(
            title: const Text("Send Notification to device"),
            onTap: sendNotificationToDevice,
          ),

          ListTile(
            title: const Text("Get Tokens"),
            subtitle: const Text("Get Notification Tokens stored in accounts"),
            onTap: getnotificationtokens,
          ),

        ],
      ),
    );
  }

  void getContactsHandler(){
        Navigator.push(context, TestRouteGenerator.testGenerateRoute(const RouteSettings(name: TestRoutes.testContactScreen)));
  }

  void signoutHandler() async {
    await Auth().signout();
    Navigator.pushAndRemoveUntil(context, RouteGenerator.generateRoute(RouteSettings(name: Routes.signin_signup)), (route) => false);
  }

  void getFastContactsHandler(){
    Navigator.push(context, TestRouteGenerator.testGenerateRoute(const RouteSettings(name: TestRoutes.testFastContactScreen)));
  }

  void notificationHandler(){
    NotificationService().createNotification(title: "This is title", content: "This is content");
  }

  void getFirebaseMessagingDeviceToken() async{

    String? token = await Messaging().getToken();
    log(token??"no token found!");
  }

  Future<void> sendNotificationToDevice() async {
    String? token = await Messaging().getToken();
    if (token == null) return;
    log("Notification sent");
    Messaging().sendNotificationToDevice(
        "notification to device",
        "send this notification to the same device in which I am in..",
        [token],
    );
  }


  Future<void> getnotificationtokens() async {
    QuerySnapshot query = await Firestore().getNotificationTokens(["923033372287"]);
    List<DocumentSnapshot> docs = query.docs;
    for (int i=0; i<docs.length; i++){
      log(docs[i].get("id"));
      log(docs[i].get("token"));
    }
  }
}


