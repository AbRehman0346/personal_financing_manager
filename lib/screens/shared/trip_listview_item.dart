/*
* Shared In
* Home Screen
* Trip Screen
* */

import 'package:expense_tracking/models/trip_model.dart';
import 'package:expense_tracking/screens/shared/display_image.dart';
import 'package:expense_tracking/utils/HandleDatetime.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Constants.dart';
import '../../utils/general_services.dart';

class TripListViewItem {
  ListTile build(BuildContext context, Trip trip) {
    return ListTile(
      leading: ClipOval(
        child: CircleAvatar(
          child: DisplayImage.display(context: context, url: trip.image, defaultImage: ProjectPaths.tripDefaultImage),
        ),
      ),
      title: Text(
        trip.tripName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          const Icon(
            Icons.groups_outlined,
            color: Colors.grey,
          ),
          Text(
            " ${trip.participants.length} Persons | ",
            style: TextStyle(color: Colors.grey.shade900),
          ),
          const Icon(
            Icons.calendar_today,
            size: 18,
            color: Colors.grey,
          ),
          Text(
            " ${HandleDatetime.formatDateTime(trip.tripStarts, format: "MMMM-dd")}",
            style: TextStyle(color: Colors.grey.shade900),
          )
          // Text("|"),
          // Text("data")
        ],
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 18,
      ),
    );
  }
}
