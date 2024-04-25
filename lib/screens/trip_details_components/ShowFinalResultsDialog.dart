import 'package:expense_tracking/models/trip_model.dart';
import 'package:expense_tracking/screens/trip_details_components/calc_trip_details_final_result.dart';
import 'package:expense_tracking/utils/general_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/firestore/firestore.dart';

class ShowFinalResultsDialog extends StatefulWidget {
  final List<ParticipantPaymentFinalResult> result;
  final double totalExpense;
  final Function endTrip;
  final bool enableFunctions;
  const ShowFinalResultsDialog(
      {super.key, required this.result, required this.totalExpense, required this.endTrip, required this.enableFunctions});

  @override
  State<ShowFinalResultsDialog> createState() => _ShowFinalResultsDialogState();
}

class _ShowFinalResultsDialogState extends State<ShowFinalResultsDialog> {
  late List<ParticipantPaymentFinalResult> results;
  GeneralServices gs = GeneralServices();
  List<int> expandedTiles = [];

  @override
  void initState() {
    results = widget.result;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool enable = widget.enableFunctions;
    return Column(
      children: [
        const SizedBox(height: 12),

        // Final Results, total expense,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text(
                  "Final Results",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Text(
                  "Total Expense: \$${widget.totalExpense}",
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.56,
          child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (_, index) {
                var result = results[index];
                var isp = !result.debt.isNegative;
                bool expanded = expandedTiles.contains(index);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (expanded) {
                        expandedTiles.remove(index);
                      } else {
                        expandedTiles.add(index);
                      }
                    });
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: FutureBuilder(
                              future: gs.getContactFromNumber(result.number),
                              builder: (_, AsyncSnapshot snap) {
                                if (snap.hasData) {
                                  return Text(snap.data.name);
                                } else {
                                  return const Text("Loading...");
                                }
                              }),
                          subtitle: Text(
                            result.number,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          trailing: Text(
                            result.debt.toStringAsFixed(2),
                            style: TextStyle(
                                color: isp ? Colors.green : Colors.red,
                                fontSize: 15),
                          ),
                        ),
                        expanded
                            ? Container(
                                color: Colors.grey.shade100,
                                height: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: result.payments.length + 1,
                                          itemBuilder: (_, index) {
                                            if (index == 0) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      color:
                                                          Colors.grey.shade300,
                                                      child: ListTile(
                                                        title: Text(
                                                          "Share: ${result.share.toStringAsFixed(2)}",
                                                        ),
                                                        subtitle: Text(
                                                            "Spent: ${result.invested}"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }

                                            TripPayment payment =
                                                result.payments[index - 1];
                                            return ListTile(
                                              title: Text(payment.spentAt,
                                                  style: const TextStyle(
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                              subtitle: Text(
                                                payment.msg,
                                                style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              trailing: Text(
                                                  payment.amount
                                                      .toStringAsFixed(2),
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 13)),
                                            );
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ))
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                );
              }),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                  if (enable){
                  widget.endTrip();

                  }else{
                    Fluttertoast.showToast(msg: "Trip has been ended");
                  }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: enable ? Colors.red : Colors.grey,
                  borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
                child: Text(enable ? "End Trip" : "Trip Ended", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            )
          ],
        ),
      ],
    );
  }
}
