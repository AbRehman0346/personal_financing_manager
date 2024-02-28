import 'package:expense_tracking/screens/home.dart';
import 'package:expense_tracking/screens/login_signup.dart';
import 'package:expense_tracking/screens/splash_screen.dart';
import 'package:expense_tracking/screens/test_screen.dart';
import 'package:expense_tracking/screens/trip_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      home: StreamBuilder(stream: null, builder: (_, AsyncSnapshot snap){
        if (snap.hasData){
          return const Home();
        }else{
          return const LoginSignup();
        }
      }),
    );
  }
}
