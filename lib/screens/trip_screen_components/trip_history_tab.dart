import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracking/screens/shared/custom_progressbar.dart';
import 'package:flutter/material.dart';

import '../../models/trip_model.dart';
import '../shared/trip_listview_item.dart';

class TripHistoryTab extends StatelessWidget {
  List<DocumentSnapshot> docs;
  TripHistoryTab({super.key, required this.docs});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: List.generate(
          docs.length,
              (index) {
            Trip trip = Trip.fromDocumentSnapshot(docs[index]);
            return TripListViewItem().build(context, trip);
          },
        ),
      ),);
  }
}
