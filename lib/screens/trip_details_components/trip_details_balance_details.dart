import 'package:expense_tracking/models/trip_model.dart';
import '../../Constants.dart';

class TripDetails_BalanceDetailsComponent{
  double totalBalance;
  late double totalBalanceLeftInPocket;
  late double ipaid = 0;
  double spent = 0;

  TripDetails_BalanceDetailsComponent({
    required List<TripPayment> payments,
    required this.totalBalance,
    required List<String> participants,
}){
    if (ProjectData.user == null){
      throw Exception("Unexpected error occurred. Can't find user data.");
    }

    String user = ProjectData.user!.phone;

      for (TripPayment payment in payments){
          if (payment.payerNumber == user){
            ipaid += payment.amount;
          }
          spent += payment.amount / participants.length;
      }
      totalBalanceLeftInPocket = totalBalance - ipaid;
  }
}
