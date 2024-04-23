import 'dart:developer';

import '../../models/trip_model.dart';

class CalcTotalAmountSpentByEachPerson{
  List<TotalAmountSpentByEachPerson> calc(Trip trip) {
    List<TotalAmountSpentByEachPerson> participantsAndTheirPayments = [];
    //calculating total expense each person did on trip.
    for (TripPayment payment in trip.payments){
      //looking for payer in list if found then increase the payment otherwise adding it down.
      bool found = false;
      for (var participantPayment in participantsAndTheirPayments){
        if (participantPayment.number == payment.payerNumber){
          participantPayment.amount += payment.amount;
          participantPayment.payments.add(payment);

          found = true;
          continue;
        }
      }

      if (found){
        continue;
      }

      //       adding the payer in list.
      participantsAndTheirPayments.add(
          TotalAmountSpentByEachPerson(
              number: payment.payerNumber,
              amount: payment.amount,
            payments: [payment],
          )
      );
    }

    if (participantsAndTheirPayments.length != trip.participants.length){
      for (String s in trip.participants){
        bool found = false;
        for (var p in participantsAndTheirPayments){
          if (s == p.number){
            found = true;
          }
        }
        if (!found){
          participantsAndTheirPayments.add(TotalAmountSpentByEachPerson(number: s, amount: 0, payments: []));
        }
      }
    }

    return participantsAndTheirPayments;
  }
}

class TotalAmountSpentByEachPerson{
  String number;
  double amount;
  List<TripPayment> payments;
  TotalAmountSpentByEachPerson({required this.number, required this.amount, required this.payments});
}