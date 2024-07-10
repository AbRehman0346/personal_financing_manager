import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracking/services/storage.dart';
import '../../Constants.dart';
import '../../models/trip_model.dart';
import '../../models/upload/TripUploadModel.dart';
import '../services_helper_functions.dart';
import 'firebase_collections.dart';
class Firestore extends Collections{
  static QuerySnapshot? _query;
  static bool forceReloadDocs = false;


  Future<bool> createTrip(TripUploadModel trip) async {
    try{
      String? imageDownloadURL;
      if (trip.image != null){
        imageDownloadURL = await Storage().uploadTripImage(trip.image!);
      }
      await tripsReference.add(trip.uploadData(imageDownloadURL));
      return true;
    }catch(e){
      throw Exception(e);
    }
  }
  
  Future<bool> addTripPayment(TripPayment payment, String docId) async {
    TripModelFields f = TripModelFields();
    await tripsReference.doc(docId).update(
      {
        f.paymentField: FieldValue.arrayUnion([payment.toMap()])
      }
    );
    return true;
  }


  Future<QuerySnapshot> getNotificationTokens(List<String> phones)async {
    QuerySnapshot query = await notificationReference.where("id", whereIn: phones).get();
    return query;
  }

  Future<bool> updateBudget(String budget, String docId) async {
    TripModelFields f = TripModelFields();
    await tripsReference.doc(docId).update(
        {
          f.estimatedBudget: budget
        }
    );
    return true;
  }

  Future<bool> endTrip(String docId) async {
    TripModelFields f = TripModelFields();
    await tripsReference.doc(docId).update(
        {
          f.endDateField: DateTime.now().toString()
        }
    );
    return true;
  }

  Future<Trip> getTripById(docId) async{
    DocumentSnapshot doc = await tripsReference.doc(docId).get();
    Trip trip = Trip.fromDocumentSnapshot(doc);
    return trip;
  }

  Future<QuerySnapshot> getTrips()async{
    TripModelFields f = TripModelFields();
    if (ProjectData.authuser == null){
      throw Exception("User data not found");
    }

    if(_query != null && !forceReloadDocs){
      return _query!;
    }

    String phone = ServicesHelperFunction().convertEmailToPhone(ProjectData.authuser!.email!);
    _query = await tripsReference.where(f.participantsField, arrayContains: phone).get();
    forceReloadDocs = false;
    return _query!;
  }

  Future<bool> deleteTrip(Trip trip) async {
    if(trip.image != null){
      await Storage().deleteTripImage(trip.image ?? "");
    }
    await tripsReference.doc(trip.tripId).delete();
    return true;
  }
}