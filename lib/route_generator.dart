import 'package:expense_tracking/models/trip_model.dart';
import 'package:expense_tracking/screens/create_trip_screen/create_trip_screen.dart';
import 'package:expense_tracking/screens/home.dart';
import 'package:expense_tracking/screens/login_signup.dart';
import 'package:expense_tracking/screens/temp_tests/temp_tests_home.dart';
import 'package:expense_tracking/screens/trip_details.dart';
import 'package:expense_tracking/screens/trip_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String homeScreen = "/";
  static const String tripScreen = "/trip";
  static const String createTrip = "/create trip";
  static const String tripDetails = "/trip_details";
  static const String signin_signup = "/signin_signup";
  static const String testScreen = "test-screen";
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.homeScreen: //HomeScreen
        return MaterialPageRoute(builder: (_) => const Home());
      case Routes.tripScreen:
        return MaterialPageRoute(builder: (_) => const TripScreen());
      case Routes.createTrip:
        return MaterialPageRoute(builder: (_) => CreateTripScreen());
      case Routes.tripDetails:
        return MaterialPageRoute(builder: (_) => TripDetails(trip: args as Trip,));
      case Routes.signin_signup:
        return MaterialPageRoute(builder: (_) => const LoginSignup());
      case Routes.testScreen:
        return MaterialPageRoute(builder: (_)=>const TempTestsHome());
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
