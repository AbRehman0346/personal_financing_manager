/*
* This is a toggle button changing between "ongoing trip and trip history"
* it is used in trip tab.
*
* */
import 'package:flutter/material.dart';
import '../../Constants.dart';

class OnGoingTripHistoryToggleButton {
  Widget build({
    required BuildContext context,
    required bool isFirstSelected,
    required Function onPressed,
  }) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: ProjectColors.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          toggleButton(
              title: "Ongoing Trips",
              selected: isFirstSelected,
              onPressed: () {
                onPressed();
              }),
          toggleButton(
              title: "Trip History",
              selected: !isFirstSelected,
              onPressed: () {
                onPressed();
              }),
        ],
      ),
    );
  }

  Widget toggleButton({
    required String title,
    required bool selected,
    required Function onPressed,
  }) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: !selected
            ? () {
                onPressed();
              }
            : null,
        child: Container(
          margin: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: selected ? ProjectColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
