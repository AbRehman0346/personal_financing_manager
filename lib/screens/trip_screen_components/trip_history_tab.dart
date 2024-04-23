import 'package:expense_tracking/screens/shared/custom_progressbar.dart';
import 'package:flutter/material.dart';

import '../shared/trip_listview_item.dart';

class TripHistoryTab extends StatelessWidget {
  const TripHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: null,
      builder: (_, AsyncSnapshot snap){
        if(snap.hasData){
          return SizedBox();
        //   return Expanded(
        //       child: ListView(
        //       children: List.generate(
        //       10,
        //   (index) => TripListViewItem().build(context, index),
        // ),
        // ),);
        }else{
          return Center(
            child: CustomProgressBar.defaultProgressbar(),
          );
        }
      },
      );
  }
}
