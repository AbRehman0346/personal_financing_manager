import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracking/Constants.dart';
import 'package:expense_tracking/screens/home_screen_components/calc_data.dart';
import 'package:expense_tracking/screens/shared/cappbar.dart';
import 'package:expense_tracking/screens/shared/footer.dart';
import 'package:expense_tracking/screens/home_screen_components/middle_cards.dart';
import 'package:expense_tracking/screens/home_screen_components/recent_trip.dart';
import 'package:expense_tracking/screens/home_screen_components/uppper_main_box.dart';
import 'package:expense_tracking/screens/shared/new_trip_floating_button.dart';
import 'package:expense_tracking/services/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appbar = cAppBar(context:context, title:"Expense Tracking");
    double appbarHeight = appbar.preferredSize.height;
    double topHeight = MediaQuery.of(context).padding.top;
    double footerSize = FooterProperties().footerHeight;

    String balance = "Loading...";
    String iowed = "Loading...";
    String ipaid = "Loading...";
    String share = "Loading...";
    List<DocumentSnapshot>? docs;

    Widget buildUI() {
      return Scaffold(
        backgroundColor: ProjectColors.white_shade2,
        appBar: appbar,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  appbarHeight -
                  topHeight -
                  footerSize,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Upper main Box
                    UpperMainBox(balance: balance),

                    const SizedBox(height: 20),

                    //   Middle Cards (My Share, I paid and I Owed)
                    MiddleCards(iowed: iowed, ipaid: ipaid, share: share,),

                    const SizedBox(height: 20),

                    //   Recent Tips
                    RecentTrip(docs: docs,),
                  ],
                ),
              ),
            ),

            // Footer
            SizedBox(
              height: footerSize,
              child: Footer(),
            )
          ],
        ),



        floatingActionButton: NewTripFloatingButton().build(context: context),
      );
    };

    return FutureBuilder(future: Firestore().getTrips(), builder: (_, AsyncSnapshot snap){
      if(snap.hasData){
        docs = snap.data.docs;
        CalcHomePageDataResponse homepagedata = CalcHomePageData().calc(docs!);
        balance = homepagedata.balance;
        iowed = homepagedata.owe;
        ipaid = homepagedata.ipaid;
        share = homepagedata.share;

        return buildUI();
      }else{
        return buildUI();
      }
    });

    // ____________________________



    return FutureBuilder(future: Firestore().getTrips(), builder: (_, AsyncSnapshot snap){
      if(snap.hasData){
        List<DocumentSnapshot> docs = snap.data.docs;
        CalcHomePageDataResponse homepagedata = CalcHomePageData().calc(docs);
        return Scaffold(
          backgroundColor: ProjectColors.white_shade2,
          appBar: appbar,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    appbarHeight -
                    topHeight -
                    footerSize,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Upper main Box
                      UpperMainBox(balance: homepagedata.balance),

                      const SizedBox(height: 20),

                      //   Middle Cards (My Share, I paid and I Owed)
                      // MiddleCards(data: homepagedata,),

                      const SizedBox(height: 20),

                      //   Recent Tips
                      RecentTrip(docs: docs,),
                    ],
                  ),
                ),
              ),

              // Footer
              SizedBox(
                height: footerSize,
                child: Footer(),
              )
            ],
          ),



          floatingActionButton: NewTripFloatingButton().build(context: context),
        );
      }else{
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: const CupertinoActivityIndicator(),
          ),
        );
      }
    });
  }
}

