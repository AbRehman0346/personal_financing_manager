import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Constants.dart';
import '../../models/trip_model.dart';

class CalcHomePageData{
  CalcHomePageDataResponse calc(List<DocumentSnapshot> docs){
    double ipaid = 0;
    double share = 0;
    double balance = 0;
    double owe = 0;
    for (DocumentSnapshot doc in docs){
      var trip = Trip.fromDocumentSnapshot(doc);
      if (trip.endDate == null){
        var calc = _calciPaid_Share_Owe(trip);
        ipaid += calc.ipaid;
        share += calc.share;
        balance += trip.budget - calc.ipaid;
        owe = calc.owe;
      }
    }

    return CalcHomePageDataResponse(
        share: share.toStringAsFixed(2),
        balance: balance.toStringAsFixed(2),
        ipaid: ipaid.toStringAsFixed(2),
        owe: owe.toStringAsFixed(2)
    );

  }

  _CalciPaidShareOweResult _calciPaid_Share_Owe(Trip trip){
    List<TripPayment> payments = trip.payments;
    double ipaid = 0;
    double share = 0;
    double owe = 0;
    double totalAmount = 0;


    if (ProjectData.user == null){
      throw Exception("Error, User data not found");
    }
    var user = ProjectData.user!.phone;

    for (var payment in payments){
      totalAmount += payment.amount;
      if (user == payment.payerNumber){
        ipaid += payment.amount;
      }
    }
    share = totalAmount / trip.participants.length;
    owe = ipaid - share;

    return _CalciPaidShareOweResult(ipaid: ipaid, share: share, owe: owe);
  }
}

class CalcHomePageDataResponse{
  String balance;
  String ipaid;
  String owe;
  String share;
  CalcHomePageDataResponse({required this.balance, required this.ipaid, required this.owe, required this.share});
}

class _CalciPaidShareOweResult{
  // double totalAmount;
    double ipaid;
    double share;
    double owe;
    _CalciPaidShareOweResult({required this.ipaid, required this.share, required this.owe});
}