import 'dart:developer';

import 'package:expense_tracking/Constants.dart';
import 'package:flutter/material.dart';

class OngoingTripTab extends StatefulWidget {
  const OngoingTripTab({super.key});

  @override
  State<OngoingTripTab> createState() => _OngoingTripTabState();
}

class _OngoingTripTabState extends State<OngoingTripTab> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => Card(),
      ),
    );
  }

  Widget Card() {
    double paddingOfImages = -30;
    Color color = Colors.grey.shade700;
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image.asset(
              "assets/images/Pakistan_scene.jpg",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trip Tite.
                const Text(
                  "Trip to Pakistan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // Number of persons and date.
                Row(
                  children: [
                    Icon(
                      Icons.groups_outlined,
                      color: color,
                    ),
                    Text(
                      " 6 Persons | ",
                      style: TextStyle(color: color),
                    ),
                    Icon(
                      Icons.calendar_today,
                      size: 15,
                      color: color,
                    ),
                    Text("October 20", style: TextStyle(color: color)),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),

                // Pictures...
                Stack(
                  children: List.generate(5, (index) {
                    paddingOfImages += 30;
                    return Container(
                      padding: EdgeInsets.only(left: paddingOfImages),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: ProjectColors.bg, width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ClipOval(
                          child: CircleAvatar(
                            child: Image.asset(
                              "assets/images/me.jpg",
                              fit: BoxFit.cover,
                              width: double.maxFinite,
                              height: double.maxFinite,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                //Total Expense
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Expense",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),

                      // Total Expense: $ 300 USD
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: ProjectColors.shadow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "\$ 300 USD",
                          style: TextStyle(
                            color: ProjectColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          ProjectColors.primaryColor,
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          ProjectColors.secondary,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "View Details",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
