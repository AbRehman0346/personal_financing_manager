/*
* Shared In
* Home Screen
* Trip Screen
* */

import 'package:flutter/material.dart';

class TripListViewItem {
  ListTile build(BuildContext context, int index) {
    return ListTile(
      leading: ClipOval(
        child: CircleAvatar(
          child: Image.asset(
            "assets/images/paris.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        "Trip to Paris ${index + 1}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          const Icon(
            Icons.groups_outlined,
            color: Colors.grey,
          ),
          Text(
            " 6 Persons | ",
            style: TextStyle(color: Colors.grey.shade900),
          ),
          Icon(
            Icons.calendar_today,
            size: 18,
            color: Colors.grey,
          ),
          Text(
            " October 20",
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
