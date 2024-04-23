import 'dart:developer';
import 'package:expense_tracking/AppConfigs.dart';
import 'package:expense_tracking/Constants.dart';
import 'package:expense_tracking/models/trip_model.dart';
import 'package:expense_tracking/screens/shared/display_image.dart';
import 'package:expense_tracking/screens/trip_details_components/add_payment_dialog.dart';
import 'package:expense_tracking/screens/trip_details_components/trip_details_balance_details.dart';
import 'package:expense_tracking/utils/HandleDatetime.dart';
import 'package:expense_tracking/utils/general_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/firestore/firestore.dart';

class TripDetails extends StatefulWidget {
  final Trip trip;
  const TripDetails({super.key, required this.trip});

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  late Trip trip;

  @override
  void initState() {
    trip = widget.trip;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color heroChildrenColor = Colors.white;
    var generalServices = GeneralServices();
    var balancedetails = TripDetails_BalanceDetailsComponent(payments: trip.payments, totalBalance: 1000, participants: trip.participants);
    return Scaffold(
      backgroundColor: ProjectColors.bg,
      appBar: AppBar(
        title: const Text(
          "Trip Details",
          style: TextStyle(fontFamily: ProjectFonts.protestStrikeRegular),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Upper Hero Part...
            Stack(
              children: [
                // Background Hero Image
                SvgPicture.asset(
                  ProjectPaths.bigFront,
                  width: MediaQuery.of(context).size.width,
                ),

                // Trip to {{somewhere}} and number of persons and Date of trip
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Trip to Country
                      Text(
                        trip.tripName,
                        style: TextStyle(
                          color: heroChildrenColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Persons and Date with icons.
                      Row(
                        children: [
                          // Group Icon
                          Icon(
                            Icons.groups_sharp,
                            color: heroChildrenColor,
                          ),
                          const SizedBox(width: 3),
                          // 6 persons
                          Text(
                            "${trip.participants.length} Persons",
                            style: TextStyle(color: heroChildrenColor),
                          ),
                          const SizedBox(width: 20),
                          // Calender Icon
                          Icon(
                            Icons.calendar_today,
                            color: heroChildrenColor,
                            size: 15,
                          ),
                          const SizedBox(width: 3),
                          // Created: Date
                          Text(
                            "Created: ${HandleDatetime.formatDateTime(trip.tripStarts)}",
                            style: TextStyle(color: heroChildrenColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Card on Hero image.. trip start and trip end date card.
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 70,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(47, 92, 255, 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // Trip Start and End Date Columns Inside.
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Trip Start Date Column
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Trip Starts
                                  const Text(
                                    "Trip Starts",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white60,

                                    ),
                                  ),
                                  // Trip Start Date
                                  Text(
                                    HandleDatetime.formatDateTime(trip.tripStarts, format: "MMMM dd-yy"),
                                    style: TextStyle(
                                      color: heroChildrenColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              // Trip End Date Column
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Trip Ends ",
                                    style: TextStyle(
                                      color: Colors.white60,
                                    ),
                                  ),
                                  Text(
                                    trip.endDate ?? "ongoing",
                                    style: TextStyle(
                                      color: heroChildrenColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Total Expense
                      Container(
                        margin: const EdgeInsets.only(top: 45),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Expense:",
                              style: TextStyle(color: Colors.grey.shade800),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: ProjectColors.shadow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "${AppConfigs.getCurrencySignBeforeAmount} ${trip.getTotalExpense()} ${AppConfigs.getCurrencySignAfterAmount}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ProjectColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Middle Total Balance, I paid, spent box..
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: ProjectColors.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              // Total Balance, I Paid, Spent Box...
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Total Balance, I Paid, Spent Box...
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Total Balance
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Total Balance...
                          Text(
                            "Total Balance",
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 12),
                          ),
                          // Money
                          Text(
                            "${AppConfigs.getCurrencySignBeforeAmount} ${balancedetails.totalBalanceLeftInPocket} ${AppConfigs.getCurrencySignAfterAmount}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            "Your Budget: ${AppConfigs.getCurrencySignBeforeAmount}${balancedetails.totalBalance}",
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 8),
                          ),
                        ],
                      ),
                      // Divider..
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: 2,
                        height: 60,
                        color: Colors.grey.shade300,
                      ),

                      // I Paid...
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //  I Paid...
                          Text(
                            "I Paid",
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 12),
                          ),
                          // Money
                          Text(
                            "${AppConfigs.getCurrencySignBeforeAmount}${balancedetails.ipaid}",
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),

                      // Divider...
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: 2,
                        height: 60,
                        color: Colors.grey.shade300,
                      ),

                      // Spent
                      Column(
                        children: [
                          // Spent
                          Text(
                            "Spent",
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 12),
                          ),
                          // Money
                          Text(
                            "${AppConfigs.getCurrencySignBeforeAmount}${balancedetails.spent.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Contribute Button
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 249, 213, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text("Contribute to Continue this Trip"),
                    ),
                  ),
                ],
              ),
            ),

            // Expanse Details and Add Button
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.only(bottom: 80),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              // Expanse Details and Add Button
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                // Expanse Details and Add Button
                child: Column(
                  children: [
                    // Expanse Details Text and Add Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Expanse Details Text
                        const Text(
                          "Expanse Detail",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: ProjectFonts.protestStrikeRegular,
                            letterSpacing: 3,
                          ),
                        ),
                        // Add Button
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: ProjectColors.shadow,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                size: 20,
                              ),
                              SizedBox(width: 2),
                              Text("Add"),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Divider(),
                    // Expanse Details List View
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: trip.payments.length,
                      itemBuilder: (BuildContext context, int index) {
                        TripPayment payment = trip.payments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: ClipOval(
                              child: DisplayImage.display(context: context, url: trip.image)
                              ,),
                          ),
                          title: Text(
                            payment.spentAt,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: FutureBuilder(future: generalServices.getContactFromNumber(payment.payer, returnSameIfNotFound: true), builder: (_, snap){
                            if(snap.hasData){
                              return Text(
                                "Paid By ${snap.data!.name}",
                                style: TextStyle(color: Colors.grey.shade600),
                                overflow: TextOverflow.ellipsis,
                              );
                            }else{
                              return const Text("Loading...", style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),);
                            }
                          }),
                          // Amount
                          trailing: Text(
                            "${AppConfigs.getCurrencySignBeforeAmount} ${payment.amount}",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(ProjectColors.primaryColor),
            foregroundColor: MaterialStateProperty.all(ProjectColors.secondary),
          ),
          onPressed: contributeActionListener,
          child: const Text(
            "Contribute",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void operationComplete() async {
    trip = await Firestore().getTripById(trip.tripId);
    setState(() {
      Fluttertoast.showToast(msg: "Payment Added Successfully");
    });
  }

  void contributeActionListener(){
    showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: const Text("Contribute to Trip"),
        contentPadding: const EdgeInsets.all(40),
        titleTextStyle: TextStyle(fontFamily: ProjectFonts.lobster, color: ProjectColors.primaryColor, fontSize: 28, fontWeight: FontWeight.bold),
        shadowColor: Colors.white,
        elevation: 20,
        backgroundColor: ProjectColors.secondary,
        surfaceTintColor: Colors.white,
        children: [
            AddPaymentDialog(trip: trip, complete: operationComplete),
        ],
      );
    });
  }
}
