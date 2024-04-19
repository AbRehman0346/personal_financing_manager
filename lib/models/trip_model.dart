import 'dart:typed_data';

class TripModelFields{
  // String idField = "id";
  String tripNameField = "trip_name";
  String participantsField = "participants";
  String imageField = "image";
  String tripStartField = "trip_starts";
  String isEnded = "is_ended";
}

class TripModel{
  String? tripId;
  String tripName;
  List<String> participants;
  String image;
  String? tripStarts;


  TripModel({
    this.tripId,
    required this.tripName,
    required this.image,
    required this.participants,
    this.tripStarts,
  });



  Map toMap(){
        TripModelFields f = TripModelFields();
        return {
          f.tripNameField: tripName,
          f.participantsField: participants,
          f.imageField: image,
          f.tripStartField: tripStarts,
        };
  }
}