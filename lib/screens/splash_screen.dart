import 'dart:async';
import 'dart:developer';

import 'package:expense_tracking/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../route_generator.dart';
import '../services/firestore/firestore_auth.dart';
import '../services/services_helper_functions.dart';
import 'home.dart';
import 'login_signup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      FirebaseAuth.instance.authStateChanges().listen((data) {
        if (data == null){
          Navigator.pushAndRemoveUntil(
            context,
            RouteGenerator.generateRoute(
              const RouteSettings(name: Routes.signin_signup),
            ),
                (route) => false,
          );
        }

        User user = data!;
        ProjectData.authuser = user;
        FirestoreAuth().getUserData(
            ServicesHelperFunction().convertEmailToPhone(user.email!))
            .then((value) => ProjectData.user = value).catchError((e){
          log("Exception-Main: $e");
          // navigating to signup and signin
          Navigator.pushAndRemoveUntil(context, RouteGenerator.generateRoute(const RouteSettings(name: Routes.signin_signup)), (route) => false);
        });
        // navigating to home
        Navigator.pushAndRemoveUntil(context, RouteGenerator.generateRoute(const RouteSettings(name: Routes.homeScreen)), (route) => false);
      });
    });
  }


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
                fontFamily: ProjectFonts.protest),
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
