import 'dart:developer';

import 'package:expense_tracking/models/trip_model.dart';
import 'package:expense_tracking/screens/trip_details_components/calc_TotalAmountSpentByEachPerson.dart';

class CalcTripFinalResult{
  List<ParticipantPaymentFinalResult> calc({required double totalSpent, required Trip trip}){
    List<ParticipantPaymentFinalResult> result = [];
    final double share = totalSpent / trip.participants.length;

    for(String s in trip.participants){
      print(s);
    }
    log("Share ${share}");

    var totalAmountSpentByEachPerson = CalcTotalAmountSpentByEachPerson().calc(trip);

    for (var obj in totalAmountSpentByEachPerson){
      double hisShare = obj.amount - share;
      result.add(ParticipantPaymentFinalResult(
          number: obj.number,
          invested: obj.amount,
          debt: hisShare,
          payments: obj.payments,
        share: share,
      ));
    }
    return result;
  }
}

class ParticipantPaymentFinalResult{
  String number;
  double invested;
  double debt;
  double share;
  List<TripPayment> payments;
  ParticipantPaymentFinalResult({
    required this.number,
    required this.invested,
    required this.debt,
    required this.payments,
    required this.share,
  });
}

