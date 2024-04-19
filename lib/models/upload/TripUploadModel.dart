import 'dart:typed_data';

import '../trip_model.dart';

class TripUploadModel{
  String? tripId;
  String tripName;
  List<String> participants;
  Uint8List? image;


  TripUploadModel({
    this.tripId,
    required this.tripName,
    this.image,
    required this.participants,
  });



  Map<String, dynamic> uploadData(String? imageURL){
    TripModelFields f = TripModelFields();
    return {
      f.tripNameField: tripName,
      f.participantsField: participants,
      f.imageField: imageURL,
      f.tripStartField: DateTime.now().toString(),
      f.isEnded: false,
    };
  }
}