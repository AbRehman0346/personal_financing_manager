import 'dart:developer';

import 'package:expense_tracking/services/permissions.dart';
import 'package:fast_contacts/fast_contacts.dart';
import '../models/contact_model.dart';

class OS{
  static List<ContactModel>? _contacts;
  Future<List<ContactModel>?> getContacts() async {
    if (_contacts != null) return _contacts;
    if (await HandlePermissions().handleContactPermission()) {
      List<Contact> rawContacts = await FastContacts.getAllContacts();
      // Commented code was only for testing.. it only contains 5 contacts
      // that were used during testing.
      // List<Map<String, String>> data = [
      //   {
      //     "id": "1",
      //     "name": "Supreme Court",
      //     "number": "+923053717314",
      //   },
      //   {
      //     "id": "2",
      //     "name": "High Court",
      //     "number": "+923033719258",
      //   },
      //   {
      //     "id": "3",
      //     "name": "Sam",
      //     "number": "+923063763586",
      //   },
      //   {
      //     "id": "4",
      //     "name": "abdul",
      //     "number": "+923033372287",
      //   },
      //   {
      //     "id": "5",
      //     "name": "unknown",
      //     "number": "+9328674769",
      //   },
      // ];
      // List<Contact> rawContacts = data
      //     .map(
      //       (e) => Contact(
      //       id: e["id"]!,
      //       phones: [Phone(number: e["number"]!, label: "mobile")],
      //       emails: [],
      //       structuredName: StructuredName(
      //           displayName: e["name"]!,
      //           namePrefix: "",
      //           givenName: "",
      //           middleName: "",
      //           familyName: "",
      //           nameSuffix: ""),
      //       organization: const Organization(
      //           company: "", department: "", jobDescription: "")),
      // )
      //     .toList();
      List<ContactModel> contacts = await ContactModel.empty()
          .getFromContacts(contacts: rawContacts);
      _contacts = contacts;
      return contacts;
    } else {
      return null;
    }
  }
}