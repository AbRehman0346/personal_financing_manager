import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracking/models/trip_model.dart';
import 'package:expense_tracking/route_generator.dart';
import 'package:expense_tracking/screens/shared/custom_progressbar.dart';
import 'package:expense_tracking/screens/shared/trip_listview_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../services/firestore/firestore.dart';

class RecentTrip extends StatelessWidget {
  final List<DocumentSnapshot>? docs;
  const RecentTrip({super.key, this.docs});

  @override
  Widget build(BuildContext context) {
    TripListViewItem item = TripListViewItem();
    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      height: docs == null ? 275 : null,
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
          docs == null ? const SizedBox(
              height: 200,
              child: Center(child: CupertinoActivityIndicator())) :
          docs!.isEmpty
              ? const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text("No Recent Trips"),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Trip trip = Trip.fromDocumentSnapshot(docs![index]);
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            RouteGenerator.generateRoute(
                              RouteSettings(
                                  name: Routes.tripDetails, arguments: trip),
                            ),
                          );
                        },
                        child: item.build(context, trip));
                  }),
        ],
      ),
    );
  }
}
