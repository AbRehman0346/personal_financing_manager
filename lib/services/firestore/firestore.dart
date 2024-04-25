import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracking/services/storage.dart';
import '../../Constants.dart';
import '../../models/trip_model.dart';
import '../../models/upload/TripUploadModel.dart';
import '../services_helper_functions.dart';
import 'firebase_collections.dart';
class Firestore extends Collections{
  Future<bool> createTrip(TripUploadModel trip) async {
    try{
      String? imageDownloadURL;
      if (trip.image != null){
        imageDownloadURL = await Storage().uploadTripImage(trip.image!);
      }
      await tripReference.add(trip.uploadData(imageDownloadURL));
      return true;
    }catch(e){
      throw Exception(e);
    }
  }
  
  Future<bool> addTripPayment(TripPayment payment, String docId) async {
    TripModelFields f = TripModelFields();
    await tripReference.doc(docId).update(
      {
        f.paymentField: FieldValue.arrayUnion([payment.toMap()])
      }
    );
    return true;
  }

  Future<bool> updateBudget(String budget, String docId) async {
    TripModelFields f = TripModelFields();
    await tripReference.doc(docId).update(
        {
          f.estimatedBudget: budget
        }
    );
    return true;
  }

  Future<bool> endTrip(String docId) async {
    TripModelFields f = TripModelFields();
    await tripReference.doc(docId).update(
        {
          f.endDateField: DateTime.now().toString()
        }
    );
    return true;
  }

  Future<Trip> getTripById(docId) async{
    DocumentSnapshot doc = await tripReference.doc(docId).get();
    Trip trip = Trip.fromDocumentSnapshot(doc);
    return trip;
  }

  Future<QuerySnapshot> getTrips()async{
    TripModelFields f = TripModelFields();
    log("Status: ${ProjectData.authuser == null}");

    if (ProjectData.authuser == null){
      throw Exception("User data not found");
    }

    String phone = ServicesHelperFunction().convertEmailToPhone(ProjectData.authuser!.email!);

    QuerySnapshot query = await tripReference.where(f.participantsField, arrayContains: phone).get();
    return query;
  }
}