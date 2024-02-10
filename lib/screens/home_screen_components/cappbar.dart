import 'package:flutter/material.dart';

import '../../Constants.dart';

PreferredSizeWidget cAppBar(){
  return AppBar(
    title: Text(
      "Expense Tracking",
      style: TextStyle(
        fontFamily: ProjectFonts.Protest,
        color: ProjectColors.primaryColor,
      ),
    ),
    actions: [
      Container(
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
    ],
  );
}
