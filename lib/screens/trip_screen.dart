import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracking/models/trip_model.dart';
import 'package:expense_tracking/screens/shared/cappbar.dart';
import 'package:expense_tracking/screens/shared/footer.dart';
import 'package:expense_tracking/screens/shared/new_trip_floating_button.dart';
import 'package:expense_tracking/screens/shared/ongoing_history_trip_toggle_button.dart';
import 'package:expense_tracking/screens/trip_screen_components/ongoing_trip_tab.dart';
import 'package:expense_tracking/screens/trip_screen_components/trip_history_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';
import '../services/firestore/firestore.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  bool isFirstSelected = true;

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appbar = cAppBar(context:context, title:"Trip");
    double appbarSize = appbar.preferredSize.height;
    double defaultPadding = MediaQuery.of(context).padding.top;
    double footerHeight = FooterProperties().footerHeight;

    return Scaffold(
      backgroundColor: ProjectColors.white_shade2,
      appBar: appbar,
      body: FutureBuilder(
        future: Firestore().getTrips(),
        builder: (context, AsyncSnapshot snap){
          if (snap.hasData){
            List<DocumentSnapshot> docs = snap.data.docs;
            return Column(
              children: [
                // Toggle Button
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      appbarSize -
                      defaultPadding -
                      footerHeight,
                  child: Column(
                    children: [
                      const Divider(),

                      //   Toggle Button
                      OnGoingTripHistoryToggleButton().build(
                          context: context,
                          isFirstSelected: isFirstSelected,
                          onPressed: () {
                            setState(() {
                              isFirstSelected = !isFirstSelected;
                            });
                          }),
                      isFirstSelected
                          ? OngoingTripTab(docs: docs)
                          : TripHistoryTab(docs: docs),
                    ],
                  ),
                ),
                SizedBox(
                  height: footerHeight,
                  child: Footer(selectedIndex: 2),
                ),
              ],
            );
          }else{
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
      floatingActionButton: isFirstSelected
          ? null
          : NewTripFloatingButton().build(context: context),
    );
  }
}
