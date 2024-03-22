import 'package:expense_tracking/route_generator.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class NewTripFloatingButton {
  Widget build({required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          RouteGenerator.generateRoute(
            const RouteSettings(name: Routes.createTrip),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 50),
        width: 120,
        decoration: BoxDecoration(
          color: ProjectColors.primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              weight: 5,
            ),
            Text(
              "New Trip",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
