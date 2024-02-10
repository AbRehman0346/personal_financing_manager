import 'package:expense_tracking/Constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget background = SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        ProjectPaths.SPLASH_SCREEN_BG,
        fit: BoxFit.cover,
      ),
    );
    Widget middle = const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Track Your Expense",
            style: TextStyle(
                fontSize: 30,
                letterSpacing: 4,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: ProjectFonts.Protest),
          ),
          Text(
            "Your Personal Finance Manager",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
    Widget version = const Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        ProjectData.APP_VERSION,
        style: TextStyle(
            color: Colors.white, letterSpacing: 1, fontWeight: FontWeight.bold),
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
          background,
          middle,
          version,
        ],
      ),
    );
  }
}
