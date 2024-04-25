import 'dart:typed_data';

import '../trip_model.dart';

class TripUploadModel{
  String? tripId;
  String tripName;
  List<String> participants;
  String owner;
  Uint8List? image;
  String estimatedBudget;


  TripUploadModel({
    this.tripId,
    required this.tripName,
    required this.owner,
    required this.participants,
    required this.estimatedBudget,
    this.image,
  });



  Map<String, dynamic> uploadData(String? imageURL){
    TripModelFields f = TripModelFields();
    return {
      f.tripNameField: tripName,
      f.participantsField: participants,
      f.imageField: imageURL,
      f.tripStartField: DateTime.now().toString(),
      f.paymentField: [],
      f.endDateField: null,
      f.owner: owner,
      f.estimatedBudget: estimatedBudget,
    };
  }
}