import 'package:expense_tracking/screens/temp_tests/test_route_generator.dart';
import 'package:expense_tracking/services/auth.dart';
import 'package:expense_tracking/services/firestore.dart';
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
          Firestore().isAppUser("+9230637635868");
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

  void signoutHandler(){
    Auth().signout();
  }

  void getFastContactsHandler(){
    Navigator.push(context, TestRouteGenerator.testGenerateRoute(const RouteSettings(name: TestRoutes.testFastContactScreen)));
  }
}
