import 'package:expense_tracking/screens/home_screen_components/calc_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../AppConfigs.dart';
import '../../Constants.dart';

class MiddleCards extends StatelessWidget {
  final String share;
  final String ipaid;
  final String iowed;
  const MiddleCards({
    super.key,
    required this.share,
    required this.ipaid,
    required this.iowed,

  });

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(2, 2),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ]);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // My Share
        Container(
          width: 150,
          height: 180,
          decoration: decoration,

          // My Share and Price Text Including Wallet Icon
          child: Stack(
            children: [
              // Wallet Icon
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(left: 50, top: 50),
                child: Image.asset(ProjectPaths.WALLET),
              ),

              // My Share and Price TExt
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // My Share Text
                    const Text(
                      "My Share",
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),

                    // Price
                    Text(
                      "${AppConfigs.getCurrencySignBeforeAmount} ${share}",
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

        // I Paid And I Owed Boxes
        SizedBox(
          height: 180,
          // I Paid and I Owed Boxes
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // I Paid
              Container(
                width: 150,
                height: 80,
                decoration: decoration,

                // I Paid and Price including thumbsUp Icon
                child: Stack(
                  children: [
                    // Thumbs Up Icon
                    Container(
                      padding: const EdgeInsets.only(left: 90),
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(
                        ProjectPaths.THUMBS_UP,
                        colorFilter: ColorFilter.mode(
                          ProjectColors.primaryBlue,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),

                    // I Paid and Price Text
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "I Paid",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${AppConfigs.getCurrencySignBeforeAmount} ${ipaid}",
                            style: const TextStyle(
                                fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // I owed
              Container(
                width: 150,
                height: 80,
                decoration: decoration,

                // I Owed and Price Text including Coin Image
                child: Stack(
                  children: [
                    // Coin Icon
                    Container(
                      padding: const EdgeInsets.only(left: 90),
                      alignment: Alignment.centerLeft,
                      child: Image.asset(ProjectPaths.COIN),
                    ),

                    // I Owed and Price Text
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // I Owed Text
                         const  Text(
                            "I Owed",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),

                          // Price
                          Text(
                            "${AppConfigs.getCurrencySignBeforeAmount} $iowed",
                            style: TextStyle(
                                fontSize: 18, color: double.tryParse(iowed)?.isNegative ?? false ? Colors.red : Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
