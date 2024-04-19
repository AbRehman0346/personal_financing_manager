import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class TripModelFields {
  // String idField = "id";
  String tripNameField = "trip_name";
  String participantsField = "participants";
  String imageField = "image";
  String tripStartField = "trip_starts";
  String isEnded = "is_ended";
}

class TripModel {
  String? tripId;
  String tripName;
  List<String> participants;
  String image;
  String tripStarts;

  TripModel({
    this.tripId,
    required this.tripName,
    required this.image,
    required this.participants,
    required this.tripStarts,
  });

  factory TripModel.fromDocumentSnapshot(DocumentSnapshot snap) {
    TripModelFields f = TripModelFields();
    List<dynamic> s = snap.get(f.participantsField).map((item)=>item.toString()).toList();
    List<String> originalValue = [];
    for (dynamic item in s){
      originalValue.add(item.toString());
    }

    return TripModel(
      tripId: snap.id,
      tripName: snap[f.tripNameField],
      image: snap[f.imageField],
      participants: originalValue,
      tripStarts: snap[f.tripStartField],
    );
  }

  Map toMap() {
    TripModelFields f = TripModelFields();
    return {
      f.tripNameField: tripName,
      f.participantsField: participants,
      f.imageField: image,
      f.tripStartField: tripStarts,
    };
  }
}
