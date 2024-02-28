import 'package:expense_tracking/route_generator.dart';
import 'package:expense_tracking/screens/shared/trip_listview_item.dart';
import 'package:flutter/material.dart';

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
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        RouteGenerator.generateRoute(
                          const RouteSettings(name: Routes.tripDetails),
                        ),
                      );
                    },
                    child: TripListViewItem().build(context, index));
              })
        ],
      ),
    );
  }
}
