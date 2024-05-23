import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracking/models/trip_model.dart';
import 'package:expense_tracking/services/messaging/messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Constants.dart';
import '../../services/firestore/firestore.dart';

class AddPaymentDialog extends StatefulWidget {
  final Trip trip;
  final Function complete;
  const AddPaymentDialog({super.key, required this.trip, required this.complete});

  @override
  State<AddPaymentDialog> createState() => _AddPaymentDialogState();
}

class _AddPaymentDialogState extends State<AddPaymentDialog> {
  TextEditingController amountCont = TextEditingController();
  TextEditingController msgCont = TextEditingController();
  List items = ["Food", "Travel", "Hotel"];
  late String spentAtValue;
  late Trip trip;


  @override
  void initState() {
    spentAtValue = items[0];
    trip = widget.trip;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // spendAt
        DropdownButton(
          items: items.map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
        )).toList(), onChanged: (value){
          setState(() {
            spentAtValue = value.toString();
          });
        }, value: spentAtValue,
          isExpanded: true,
        ),
        const SizedBox(height: 10),

        // amount
        TextField(
          keyboardType: TextInputType.number,
          controller: amountCont,
          decoration: const InputDecoration(
            hintText: "Amount You Spent",
          ),),

        const SizedBox(height: 10),
        // msg
        TextField(
          controller: msgCont,
          decoration: const InputDecoration(
            hintText: "Message",
          ),),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // cancel button
            TextButton(onPressed: (){
              Navigator.pop(context);
            },
                child: const Text("Cancel", style: TextStyle(color: Colors.black),)),

            // Contribute button
            TextButton(onPressed: () async {
              if (ProjectData.user == null){
                throw Exception("Unexpected Error: Can't find user data");
              }

              CustomDialogs().showAndroidProgressBar(context);

              String spentAt = spentAtValue;
              double? amount = double.tryParse(amountCont.text);
              String payer = ProjectData.user!.phone;
              String epoch = DateTime.now().millisecondsSinceEpoch.toString();
              String msg = msgCont.text;

              // Validation
              if(amount == null){
                CustomDialogs().showWarningMessage(context, "Please provide amount");
                Navigator.pop(context);
                return;
              }

              var payment = TripPayment(spentAt: spentAt, amount: amount, payerNumber: payer, epoch: epoch, msg: msg);
              if (widget.trip.tripId == null){
                Navigator.pop(context);
                throw Exception("Unexpected Error\nCan't find user data.");
              }

              // Adding payment
              await Firestore().addTripPayment(payment, trip.tripId!);

              sendPaymentNotifications(payment);


                widget.complete();

              if (context.mounted){
                Navigator.pop(context);
                Navigator.pop(context);
              }
            }, child: Text("Contribute", style: TextStyle(color: ProjectColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 16),)),
          ],
        ),
      ],
    );
  }

  Future<void> sendPaymentNotifications(TripPayment payment) async {
    // Sending notification
    List<String> participants = trip.participants;
    participants.remove(ProjectData.user?.phone);
    QuerySnapshot query = await Firestore().getNotificationTokens(participants);
    List<DocumentSnapshot> docs = query.docs;
    List<String> tokens = [];
    for (int i=0; i<docs.length; i++){
      tokens.add(docs[i].get("token"));
    }
    Messaging().sendNotificationToDevice("Payment Added", "Payment ${payment.amount} added by ${ProjectData.user!.phone}", tokens);
  }
}
