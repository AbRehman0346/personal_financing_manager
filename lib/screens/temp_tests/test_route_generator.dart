import 'package:expense_tracking/screens/create_trip_screen.dart';
import 'package:expense_tracking/screens/home.dart';
import 'package:expense_tracking/screens/login_signup.dart';
import 'package:expense_tracking/screens/temp_tests/getContactsScreen.dart';
import 'package:expense_tracking/screens/temp_tests/temp_tests_home.dart';
import 'package:expense_tracking/screens/trip_details.dart';
import 'package:expense_tracking/screens/trip_screen.dart';
import 'package:flutter/material.dart';

class TestRoutes {
  static const String testContactScreen = "/";
}

class TestRouteGenerator {
  static Route<dynamic> testGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case TestRoutes.testContactScreen:
        return MaterialPageRoute(builder: (_)=>const GetContacts());
      default: //Error Screen
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
    }
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Route Couldn't Found!",
        style: TextStyle(fontSize: 20),
        maxLines: 3,
      ),
    );
  }
}
