import 'dart:developer';
import 'package:expense_tracking/AppConfigs.dart';
import 'package:expense_tracking/Constants.dart';
import 'package:expense_tracking/models/trip_model.dart';
import 'package:expense_tracking/screens/shared/display_image.dart';
import 'package:expense_tracking/screens/trip_details_components/ShowFinalResultsDialog.dart';
import 'package:expense_tracking/screens/trip_details_components/add_payment_dialog.dart';
import 'package:expense_tracking/screens/trip_details_components/calc_TotalAmountSpentByEachPerson.dart';
import 'package:expense_tracking/screens/trip_details_components/calc_trip_details_final_result.dart';
import 'package:expense_tracking/screens/trip_details_components/trip_details_balance_details.dart';
import 'package:expense_tracking/utils/HandleDatetime.dart';
import 'package:expense_tracking/utils/general_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/contact_model.dart';
import '../services/firestore/firestore.dart';
import '../widgets/xtextfield.dart';

class TripDetails extends StatefulWidget {
  final Trip trip;
  const TripDetails({super.key, required this.trip});

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  late Trip trip;
  final List<int> _expandedPaymentDetails = [];
  bool enable = false;

  @override
  void initState() {
    trip = widget.trip;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    enable = trip.endDate == null;
    Color heroChildrenColor = ProjectColors.white;
    var generalServices = GeneralServices();
    var balancedetails = TripDetails_BalanceDetailsComponent(payments: trip.payments, totalBalance: trip.budget, participants: trip.participants);
    double tripTotalExpense = trip.calcTripTotalExpense();
    String dateformat = "MMMM dd-yy";
    // log("TripEndDate: ${trip.endDate}");

    return Scaffold(
      backgroundColor: ProjectColors.white_shade2,
      appBar: AppBar(
        title: const Text(
          "Trip Details",
          style: TextStyle(fontFamily: ProjectFonts.protestStrikeRegular),
        ),
        actions: [
          // delete trip button...
          TextButton(onPressed: (){
            showDialog(context: context, builder: (_){
              return AlertDialog(
                backgroundColor: ProjectColors.white,
                surfaceTintColor: ProjectColors.white,
                shadowColor: ProjectColors.greyShadow,
                title: const Text("Confirm Delete"),
                content: const Text("Do you want to delete this trip"),
                actions: [
                  ElevatedButton(onPressed: goback, child: const Text("NO")),
                  ElevatedButton(onPressed: deleteTirp, child: const Text("YES")),
                ],
              );
            });


          }, child:
            Icon(Icons.delete, color: ProjectColors.dangerColor,)
          ),
        ],
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
                                    HandleDatetime.formatDateTime(trip.tripStarts, format: dateformat),
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
                                    enable ? "ongoing" : HandleDatetime.formatDateTime(trip.endDate!, format: dateformat),
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
                                color: ProjectColors.white_shade2,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "${AppConfigs.getCurrencySignBeforeAmount} ${tripTotalExpense} ${AppConfigs.getCurrencySignAfterAmount}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ProjectColors.primaryBlue,
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
                color: ProjectColors.white,
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
                          GestureDetector(
                            onTap: ()async {
      if (!enable){
        Fluttertoast.showToast(msg: "Trip has been ended");
        return;
      }

                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      TextEditingController newbudget = TextEditingController();
                                      CustomDialogs dialogs = CustomDialogs();
                                      return SimpleDialog(
                                        title: const Text("New Budget"),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                        backgroundColor: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        children: [
                                          XTextField(
                                            hint: "Enter New Budget",
                                            fontSize: 17,
                                            keyboardType: TextInputType.number,
                                            controller: newbudget,
                                          ),
                                          const SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: ()async{
                                        String budget = newbudget.text;
                                        if (budget == ""){
                                          Fluttertoast.showToast(msg: "Provide New Budget");
                                        }

                                        double? dbudget = double.tryParse(budget);
                                        if (dbudget == null){
                                          dialogs.showDangerMessage(context, "Error: Make sure budget doesn't contain any non number value");
                                          return;
                                        }

                                        if (trip.tripId == null){
                                          dialogs.showDangerMessage(context, "Error: Trip Id Not Found");
                                          return;
                                        }

                                        dialogs.showAndroidProgressBar(context);

                                        bool result = await Firestore().updateBudget(budget, trip.tripId!);
                                        if (result){
                                          Fluttertoast.showToast(msg: "Updated Successfully");
                                          goback();
                                          goback();
                                          setState(() {
                                            trip.budget = dbudget;
                                          });
                                        }
                                      },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue.shade900,
                                                      borderRadius: const BorderRadius.all(Radius.circular(20))
                                                  ),
                                                  child:
                                                  const Text("Update",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15,),
                                        ],
                                      );
                                    },
                                );
                            },
                            child: Text(
                              "${AppConfigs.getCurrencySignBeforeAmount} ${balancedetails.totalBalanceLeftInPocket}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: balancedetails.totalBalanceLeftInPocket.isNegative ? Colors.red : Colors.green
                              ),
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
                            style: const TextStyle(
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
                  GestureDetector(
                    onTap: ()async{
                      var finalResults = CalcTripFinalResult().calc(totalSpent: tripTotalExpense, trip: trip);
                      log("Total Expense: $tripTotalExpense");
                      for(var result in finalResults){
                        ContactModel? contact = await generalServices.getContactFromNumber(result.number);
                        log("Name: ${contact?.name ?? "unknown"}");
                        log("Invested: ${result.invested.toStringAsFixed(2)}   |");
                        log("Debt: ${result.debt.toStringAsFixed(2)}\n");
                      }



                        showDialog(
                            context: context,
                            builder: (_)=> SimpleDialog(
                              backgroundColor: Colors.white,
                              surfaceTintColor: Colors.white,
                              children: [
                                ShowFinalResultsDialog(result: finalResults, totalExpense: tripTotalExpense, endTrip: endTrip, enableFunctions: enable,)
                              ],
                            )
                        );



                      // Navigator.push(context, MaterialPageRoute(builder: (_)=>ShowFinalResultsDialog(result: finalResults,)));


                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 249, 213, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text("CHECK FINAL RESULT", style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
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
                        GestureDetector(
                          onTap: enable ? contributeActionListener : null,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              color: ProjectColors.white_shade2,
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
                          ),
                        )
                      ],
                    ),
                    const Divider(),
                    // Expanse Details List View
                    trip.payments.isEmpty ? const SizedBox(
                      height: 80,
                      child: Center(child: Text("No Contribution Yet!"),),
                    ) :
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: trip.payments.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isExpanded = _expandedPaymentDetails.contains(index);
                        TripPayment payment = trip.payments[index];
                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              if(isExpanded){
                                _expandedPaymentDetails.remove(index);
                              }else{
                                _expandedPaymentDetails.add(index);
                              }
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  child: ClipOval(
                                    child: DisplayImage.display(context: context, url: trip.image)
                                    ,),
                                ),
                                title: Text(
                                  payment.spentAt,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: FutureBuilder(future: generalServices.getContactFromNumber(payment.payerNumber), builder: (_, snap){
                                  if(snap.hasData){
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Paid By ${snap.data!.name}",
                                          style: TextStyle(color: Colors.grey.shade600),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        isExpanded ? Text(HandleDatetime.formatDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(payment.epoch)).toString()), style: TextStyle(color: Colors.grey),) : SizedBox.shrink(),
                                      ],
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
                              ),
                              isExpanded ? Padding(
                                padding: const EdgeInsets.only(left: 70, bottom: 10),
                                child: Text(payment.msg, style: TextStyle(color: Colors.grey),),
                              ): const SizedBox.shrink(),
                            ],
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(enable ? ProjectColors.primaryBlue : Colors.grey),
            foregroundColor: MaterialStateProperty.all(ProjectColors.white),
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
    if (!enable){
      Fluttertoast.showToast(msg: "Trip has been ended");
      return;
    }

    showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: const Text("Contribute to Trip"),
        contentPadding: const EdgeInsets.all(40),
        titleTextStyle: TextStyle(fontFamily: ProjectFonts.lobster, color: ProjectColors.primaryBlue, fontSize: 28, fontWeight: FontWeight.bold),
        shadowColor: Colors.white,
        elevation: 20,
        backgroundColor: ProjectColors.white,
        surfaceTintColor: Colors.white,
        children: [
            AddPaymentDialog(trip: trip, complete: operationComplete),
        ],
      );
    });
  }

  void endTrip()async{
    CustomDialogs dialogs = CustomDialogs();
    dialogs.showAndroidProgressBar(context);

    dialogs.dangerOperationDialog(
        context: context,
        title: "End Trip",
        msg: "You want to end the trip?",
        primaryButtonOnPressed: () async {
          await Firestore().endTrip(trip.tripId!);
          setState(() {
            trip.endDate = DateTime.now().toString();
            Fluttertoast.showToast(msg: "Trip has been Ended");
          });
          if(mounted){
            goback();
            goback();
            goback();
          }
        },
        primaryButtonText: "End Trip",
    );
  }

  void deleteTirp(){
    if(trip.tripId == null){
      Fluttertoast.showToast(msg: "Couldn't delete trip");
      return;
    }
    Firestore db = Firestore();
    db.deleteTrip(trip.tripId!);
    Fluttertoast.showToast(msg: "Trip Deleted");
    goback();
    goback();
  }

  void goback(){
    Navigator.pop(context);
  }
}
