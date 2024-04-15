import 'package:expense_tracking/screens/temp_tests/fast_contact_screen.dart';
import 'package:expense_tracking/screens/temp_tests/getContactsScreen.dart';
import 'package:flutter/material.dart';

class TestRoutes {
  static const String testContactScreen = "/";
  static const String testFastContactScreen = "/fast-contact-screen";
}

class TestRouteGenerator {
  static Route<dynamic> testGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case TestRoutes.testContactScreen:
        return MaterialPageRoute(builder: (_)=>const GetContacts());
      case TestRoutes.testFastContactScreen:
        return MaterialPageRoute(builder: (_)=> const FastContactsScreen());
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
