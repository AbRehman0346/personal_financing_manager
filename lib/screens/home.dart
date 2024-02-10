import 'dart:developer';
import 'package:expense_tracking/Constants.dart';
import 'package:expense_tracking/screens/home_screen_components/cappbar.dart';
import 'package:expense_tracking/screens/shared/footer.dart';
import 'package:expense_tracking/screens/home_screen_components/middle_cards.dart';
import 'package:expense_tracking/screens/home_screen_components/recent_trip.dart';
import 'package:expense_tracking/screens/home_screen_components/uppper_main_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appbar = cAppBar();
    double appbarHeight = appbar.preferredSize.height;
    double topHeight = MediaQuery.of(context).padding.top;
    double footerSize = 48;

    return Scaffold(
      backgroundColor: ProjectColors.bg,
      appBar: appbar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height -
                appbarHeight -
                topHeight -
                footerSize,
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  // Upper main Box
                  UpperMainBox(),

                  SizedBox(height: 20),

                  //   Middle Cards (My Share, I paid and I Owed)
                  MiddleCards(),

                  SizedBox(height: 20),

                  //   Recent Tips
                  RecentTrip(),
                ],
              ),
            ),
          ),

          // Footer
          SizedBox(
            height: footerSize,
            child: Footer(),
          )
        ],
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 50),
        width: 120,
        decoration: BoxDecoration(
          color: ProjectColors.primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              weight: 5,
            ),
            Text(
              "New Trip",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
