/*
* Shared In
* Home Screen
* Trip Screen
* Profile Screen
* Group Screen
*
* */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Constants.dart';

class Footer extends StatelessWidget {
  int selectedIndex;

  Footer({super.key, this.selectedIndex = 1});

  @override
  Widget build(BuildContext context) {
    double iconWidth = 24;
    Color color = ProjectColors.primaryColor;
    return Container(
      padding: const EdgeInsets.only(top: 4.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 0),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //   Home
          Column(
            children: [
              Icon(
                Icons.home,
                size: iconWidth,
                color: selectedIndex == 1 ? color : null,
              ),
              Text(
                "Home",
                style: TextStyle(
                  color: selectedIndex == 1 ? color : null,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          //   Trip
          Column(
            children: [
              SvgPicture.asset(
                ProjectPaths.TRIP_ICON,
                width: iconWidth,
                colorFilter: ColorFilter.mode(
                  selectedIndex == 2 ? color : Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                "Trip",
                style: TextStyle(
                    color: selectedIndex == 2 ? color : null,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),

          // Group
          Column(
            children: [
              Icon(
                Icons.groups_outlined,
                size: iconWidth,
                color: selectedIndex == 3 ? color : null,
              ),
              Text(
                "Group",
                style: TextStyle(
                    color: selectedIndex == 3 ? color : null,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),

          //   Profile
          Column(
            children: [
              SvgPicture.asset(
                ProjectPaths.PROFILE_ICON,
                width: iconWidth,
                colorFilter: ColorFilter.mode(
                    selectedIndex == 4 ? color : Colors.black, BlendMode.srcIn),
              ),
              Text(
                "Profile",
                style: TextStyle(
                    color: selectedIndex == 4 ? color : null,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
