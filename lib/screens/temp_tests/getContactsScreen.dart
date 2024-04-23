import 'dart:developer';
import 'package:flutter/material.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GetContacts extends StatefulWidget {
  const GetContacts({super.key});

  @override
  State<GetContacts> createState() => _GetContactsState();
}

class _GetContactsState extends State<GetContacts> {
  // List<Contact>? contacts;
  // List<int> indexes = [];


  @override
  Widget build(BuildContext context) {
    return Placeholder();


    //   Scaffold(
    //   appBar: AppBar(title: const Text("Contacts"),
    //   actions: [
    //     TextButton(onPressed: () async {
    //       if (await FlutterContacts.requestPermission()){
    //         contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
    //         setState(() { });
    //       }
    //     }, child: const Text("Get Contacts")),
    //     TextButton(onPressed: (){
    //       for (int i=0; i<contacts!.length; i++){
    //         if (contacts![i].phones.length > 1){
    //           log("${contacts![i].phones.length}   index: $i");
    //           indexes.add(i);
    //         }
    //       }
    //       setState(() {});
    //     }, child: const Text("print"),)
    //   ],
    //
    //   ),
    //
    //   body: contacts == null ? const Center(child: Text("No Contact Yet"),) : ListView.builder(
    //       itemCount: contacts!.length,
    //       itemBuilder: (context, index){
    //     Contact contact = contacts![index];
    //
    //     return Column(
    //       children: List.generate(contact.phones.length, (phoneIndex) => ListTile(
    //         title: Text(contact.displayName),
    //         subtitle: Text((contact.phones.isNotEmpty ? contact.phones[phoneIndex].number : "No Phone Number Available")),
    //         trailing: Text("Index: $index"),
    //       ),),
    //     );
    //   }),
    // );
  }
}












