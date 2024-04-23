import 'dart:developer';

import 'package:expense_tracking/route_generator.dart';
import 'package:expense_tracking/screens/temp_tests/test_route_generator.dart';
import 'package:expense_tracking/services/auth.dart';
import 'package:expense_tracking/services/firestore/firestore_auth.dart';
import 'package:expense_tracking/utils/general_services.dart';
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
}
