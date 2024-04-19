import 'dart:developer';

import 'package:expense_tracking/services/storage.dart';

import '../../models/trip_model.dart';
import '../../models/upload/TripUploadModel.dart';
import 'firebase_collections.dart';
class Firestore extends Collections{
  Future<bool> createTrip(TripUploadModel trip) async {
    try{
      String? imageDownloadURL;
      if (trip.image != null){
        imageDownloadURL = await Storage().uploadProfileImage(trip.image!);
      }
      await tripReference.add(trip.uploadData(imageDownloadURL));
      return true;
    }catch(e){
      throw Exception(e);
    }
  }
}