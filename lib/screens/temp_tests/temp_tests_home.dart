import 'package:expense_tracking/services/auth.dart';
import 'package:flutter/material.dart';

class TempTestsHome extends StatefulWidget {
  const TempTestsHome({super.key});

  @override
  State<TempTestsHome> createState() => _TempTestsHomeState();
}

class _TempTestsHomeState extends State<TempTestsHome> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text("Sign out"),
          onTap: signoutHandler,
        ),
        ListTile(
          title: Text("Get Contacts"),

        )
      ],
    );
  }

  void getContactsHandler(){

  }

  void signoutHandler(){
    Auth().signout();
  }
}
