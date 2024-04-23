import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracking/models/trip_model.dart';
import 'package:expense_tracking/route_generator.dart';
import 'package:expense_tracking/screens/shared/custom_progressbar.dart';
import 'package:expense_tracking/screens/shared/trip_listview_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../services/firestore/firestore.dart';

class RecentTrip extends StatelessWidget {
  const RecentTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      // height: 275,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 8, top: 8, bottom: 0),
            child: Text(
              "Recent Trips",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          FutureBuilder(future: Firestore().getTrips(), builder: (context, AsyncSnapshot snap){
            if(snap.hasData){
              List<DocumentSnapshot> docs = snap.data.docs;

              if (docs.isEmpty){
                return const SizedBox(
                    height: 200,
                    child: Center(
                      child: Text("No Recent Trips"),
                    ),
                );
              }


             return ListView.builder(
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
                 itemCount: docs.length,
                 itemBuilder: (BuildContext context, int index) {
                   Trip trip = Trip.fromDocumentSnapshot(docs[index]);
                   return GestureDetector(
                       onTap: () {
                         Navigator.push(
                           context,
                           RouteGenerator.generateRoute(
                             RouteSettings(name: Routes.tripDetails, arguments: trip),
                           ),
                         );
                       },
                       child: TripListViewItem().build(context, trip));
                 }
             );
            }else{
              return SizedBox(
                height: 200,
                child: Center(
                  child: CustomProgressBar.defaultProgressbar(),
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
