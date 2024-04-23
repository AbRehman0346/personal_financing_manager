import 'package:expense_tracking/models/trip_model.dart';
import '../../Constants.dart';

class TripDetails_BalanceDetailsComponent{
  int totalBalance;
  late int totalBalanceLeftInPocket;
  late int ipaid = 0;
  double spent = 0;

  TripDetails_BalanceDetailsComponent({
    required List<TripPayment> payments,
    required this.totalBalance,
    required List<String> participants,
}){
    String user = ProjectData.user!.phone;
      for (TripPayment payment in payments){
          if (payment.payer == user){
            ipaid += payment.amount;
          }
          spent += payment.amount / participants.length;
      }
      totalBalanceLeftInPocket = totalBalance - ipaid;
  }
}

// class PaymentResults{
//   String name;
//   String number;
//   String spent;
//   String amount;
// }