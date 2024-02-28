import 'package:flutter/material.dart';

import '../shared/trip_listview_item.dart';

class TripHistoryTab extends StatelessWidget {
  const TripHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: List.generate(
          10,
          (index) => TripListViewItem().build(context, index),
        ),
      ),
    );
  }
}
