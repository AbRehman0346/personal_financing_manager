/*
* Shared In
* Home
* Trip
*
* */

import 'package:expense_tracking/screens/temp_tests/test_route_generator.dart';
import 'package:expense_tracking/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Constants.dart';
import '../../route_generator.dart';

PreferredSizeWidget cAppBar({required BuildContext context, required String title}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontFamily: ProjectFonts.protest,
        color: ProjectColors.primaryColor,
      ),
    ),
    actions: [
      GestureDetector(
        onTap: (){
          Navigator.push(context, RouteGenerator.generateRoute(RouteSettings(name: Routes.testScreen)));
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: ProjectColors.shadow,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            Icons.notifications_none,
            color: ProjectColors.primaryColor,
          ),
        ),
      ),
    ],
  );
}
