import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracking/Constants.dart';
import 'package:expense_tracking/models/trip_model.dart';
import 'package:expense_tracking/utils/general_services.dart';
import 'package:expense_tracking/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/HandleDatetime.dart';
import '../shared/display_image.dart';

class OngoingTripTab extends StatefulWidget {
  final List<DocumentSnapshot> docs;
  const OngoingTripTab({super.key, required this.docs});

  @override
  State<OngoingTripTab> createState() => _OngoingTripTabState();
}

class _OngoingTripTabState extends State<OngoingTripTab> {
  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot> docs = widget.docs;
    return Expanded(
      child: ListView.builder(
        itemCount: docs.length,
        itemBuilder: (context, index) => _card(docs[index]),
      ),
    );
  }

  Widget _card(DocumentSnapshot doc) {
    Trip trip = Trip.fromDocumentSnapshot(doc);
    double paddingOfImages = -30;
    Color color = Colors.grey.shade700;
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: DisplayImage.display(
                  context: context,
                  url: trip.image,
                  defaultImage: ProjectPaths.tripDefaultImage,
                height: 200,
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trip Tite.
                Text(
                  trip.tripName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // Number of persons and date.
                Row(
                  children: [
                    Icon(
                      Icons.groups_outlined,
                      color: color,
                    ),
                    Text(
                      " ${trip.participants.length} Persons | ",
                      style: TextStyle(color: color),
                    ),
                    Icon(
                      Icons.calendar_today,
                      size: 15,
                      color: color,
                    ),
                    Text(HandleDatetime.formatDateTime(trip.tripStarts),
                        style: TextStyle(color: color)),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),

                // Pictures...
                Stack(
                  children: List.generate(
                      trip.participants.length > 5
                          ? 5
                          : trip.participants.length, (index) {
                    String phone = trip.participants[index];
                    paddingOfImages += 30;
                    return Container(
                      padding: EdgeInsets.only(left: paddingOfImages),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: ProjectColors.bg, width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ClipOval(
                          child: CircleAvatar(
                            child: FutureBuilder(
                                future:
                                    Storage().getProfileImageFromPhone(phone),
                                builder: (context, AsyncSnapshot snap) {
                                  if (snap.hasData) {
                                    if (snap.data == "") {
                                      return Image.asset(
                                        ProjectPaths.profilePlaceholderImage,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        fit: BoxFit.cover,
                                      );
                                    }
                                    return CachedNetworkImage(
                                        imageUrl: snap.data,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        fit: BoxFit.cover,
                                        placeholder: (_, __) =>
                                            const CupertinoActivityIndicator(),
                                        errorWidget: (_, __, ___) {
                                          return Image.asset(
                                            ProjectPaths
                                                .profilePlaceholderImage,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            fit: BoxFit.cover,
                                          );
                                        });

                                    //   Image.network(snap.data,
                                    // width: MediaQuery.of(context).size.width,
                                    //   height: MediaQuery.of(context).size.height,
                                    //   fit: BoxFit.cover,
                                    // );
                                  } else {
                                    return const CupertinoActivityIndicator();
                                  }
                                }),
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                //Total Expense
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Expense",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),

                      // Total Expense: $ 300 USD
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: ProjectColors.shadow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "\$ 300 USD",
                          style: TextStyle(
                            color: ProjectColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          ProjectColors.primaryColor,
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          ProjectColors.secondary,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "View Details",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
