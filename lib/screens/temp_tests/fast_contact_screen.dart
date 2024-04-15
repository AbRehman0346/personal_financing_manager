import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fast_contacts/fast_contacts.dart';

class FastContactsScreen extends StatefulWidget {
  const FastContactsScreen({super.key});

  @override
  State<FastContactsScreen> createState() => _FastContactsScreenState();
}

class _FastContactsScreenState extends State<FastContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(title: Text("Fast Contact Package"),
        actions: [
          TextButton(onPressed: () async {
            List<Contact> contacts = await FastContacts.getAllContacts();
            log(contacts.toString());
          }, child: const Text("Get Contacts"))
        ],

        ),
      );
  }
}
