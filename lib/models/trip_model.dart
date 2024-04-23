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
String owner = "owner";
  String endDateField = "end_date";
  String paymentField = "payments";
}

class Trip {
  String? tripId;
  String tripName;
  List<String> participants;
  String owner;
  String? image;
  String tripStarts;
  String? endDate;
  List<TripPayment> payments;

  Trip({
    this.tripId,
    required this.tripName,
    required this.image,
    required this.owner,
    required this.participants,
    required this.tripStarts,
    required this.payments,
    this.endDate,
  });

  double calcTripTotalExpense(){
    double totalExpense = 0;
    for (TripPayment payment in payments){
      totalExpense += payment.amount;
    }
    return totalExpense;
  }

  factory Trip.fromDocumentSnapshot(DocumentSnapshot snap) {
    TripModelFields f = TripModelFields();
    List<dynamic> s = snap.get(f.participantsField);
    List<String> originalValue = [];
    for (dynamic item in s){
      originalValue.add(item.toString());
    }

    _TripPaymentFields fields = _TripPaymentFields();
    List tripPaymentDynamic = snap.get(f.paymentField);
    List<TripPayment> payments = [];
    for (dynamic item in tripPaymentDynamic){
      payments.add(
          TripPayment(
              spentAt: item[fields.spendAt],
              amount: double.parse(item[fields.amount].toString()),
              payerNumber: item[fields.payer],
              epoch: item[fields.epoch],
              msg: item[fields.msg],
          )
      );
    }

    return Trip(
      tripId: snap.id,
      tripName: snap[f.tripNameField],
      image: snap[f.imageField],
      participants: originalValue,
      tripStarts: snap.get(f.tripStartField),
      payments: payments,
      endDate: snap.get(f.endDateField),
      owner: snap.get(f.owner),
    );
  }

  // Map toMap() {
  //   TripModelFields f = TripModelFields();
  //   return {
  //     f.tripNameField: tripName,
  //     f.participantsField: participants,
  //     f.imageField: image,
  //     f.tripStartField: tripStarts,
  // TODO: Need to update this.. according to new fields.
  //   };
  // }
}

class _TripPaymentFields{
  String spendAt = "spend_at";
  String amount = "amount";
  String payer = "payer";
  String epoch = "epoch";
  String msg = "msg";
}

class TripPayment{
  String spentAt;
  double amount;
  String payerNumber;
  String epoch;
  String msg;
  TripPayment({required this.spentAt, required this.amount, required this.payerNumber, required this.epoch, required this.msg});

  Map<String, dynamic> toMap(){
    _TripPaymentFields f = _TripPaymentFields();
    return {
      f.spendAt: spentAt,
      f.amount: amount,
      f.payer: payerNumber,
      f.epoch: epoch,
      f.msg: msg,
    };
  }


}
