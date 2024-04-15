import 'dart:developer';
import 'dart:typed_data';
import 'package:expense_tracking/models/user_data_model.dart';
import 'package:expense_tracking/services/permissions.dart';
import 'package:expense_tracking/services/services_helper_functions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Constants.dart';
import '../models/contact_model.dart';

class CreateTripScreen extends StatefulWidget {
  CreateTripScreen({super.key});

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  Uint8List? file;

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appbar = AppBar(
      title: const Text(
        "Create Trip",
        style: TextStyle(
          fontFamily: ProjectFonts.protestStrikeRegular,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              // if (await FlutterContacts.requestPermission()){
              //   List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true, withThumbnail: true, withAccounts: true, withGroups: true);
              //   log(contacts.isEmpty.toString());
              // }
            },
            child: const Text("Test"))
      ],
    );

    Widget imageAndUploadImageText = Center(
      child: Column(
        children: [
          ClipOval(
            child: GestureDetector(
              onTap: selectImage,
              child: CircleAvatar(
                radius: 60,
                child: file == null
                    ? Image.asset(
                        "assets/images/profileplaceholder.png",
                        width: double.maxFinite,
                        height: double.maxFinite,
                        fit: BoxFit.cover,
                      )
                    : Image.memory(
                        file!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
              ),
            ),
          ),
          const Text(
            "Upload Image",
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );

    // Participants contains: Trip Name Text Field and Participants with Add Member Button
    Widget participants = Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trip Name Text...
          Text(
            "Trip Name",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          // Trip Name TextField...
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Trip Name",
            ),
          ),

          SizedBox(height: 30),

          // Perticipants.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text(
                    "Participants ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "(3 Persons)",
                    // style: TextStyle(color: Colors.grey.shade700),
                  ),
                ],
              ),
              TextButton(
                onPressed: null,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: ProjectColors.shadow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.add,
                        size: 15,
                        color: Colors.black,
                      ),
                      SizedBox(width: 3),
                      Text(
                        "Add Member",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );

    Widget createTripButton = Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ProjectColors.primaryColor),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {},
              child: const Text(
                "Create Trip",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );

    Widget listOfParticipants() {
      return FutureBuilder(
          future: getContacts(),
          builder: (BuildContext contact, AsyncSnapshot snap) {
            if (snap.hasData) {
              List<ContactModel>? contacts = snap.data;

              // if null -> it returns Text Widget with "permission denied".
              if (contacts == null) {
                return const Center(
                  child: Text(
                    "Contact Permission Denied",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              // if empty -> it returns Text Widget with "No Contact Found"
              if (contacts.isEmpty) {
                return const Center(
                  child: Text(
                    "No Contact Found",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    ContactModel contact = contacts[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: ClipOval(
                            child: CircleAvatar(
                              child: Image.asset(
                                ProjectPaths.profilePlaceholderImage,
                                fit: BoxFit.cover,
                                width: double.maxFinite,
                                height: double.maxFinite,
                              ),
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Circle pic, Name:
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      contact.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 1,
                                    ),
                                  ),
                                  contact.isowner
                                      ? const Text(
                                    "  (You)",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  )
                                      : const SizedBox(),
                                ],
                              ),
                              contact.isowner
                                  ? Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  color: ProjectColors.shadow,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Owner",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                                  : Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: contact.isuser == null
                                    ? const SizedBox.shrink()
                                    : contact.isuser!
                                    ? const Text(
                                  "Add",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                                    : const Text(
                                  "Invite",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(contact.number),
                        ),
                        index == contacts.length-1 ? const SizedBox(height: 80) : const SizedBox.shrink()
                      ],
                    );
                  },
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          });
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar
            appbar,
            const SizedBox(height: 20),

            // Image and Upload Image Text.
            imageAndUploadImageText,

            // Trip Name Text Field and Participants with Add Member Button
            participants,

            // List of Participants
            listOfParticipants(),
          ],
        ),
      ),

      //   Create Trip Button
      floatingActionButton: createTripButton,
    );
  }

  void selectImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xfile == null) return;
    file = await xfile.readAsBytes();
    setState(() {});
  }

  Future<List<ContactModel>?> getContacts() async {
    // returns null when contact permission is denied
    // return contact list or empty list based on contacts available in device.
    if (await HandlePermissions().handleContactPermission()) {
      // List<Contact> rawContacts = await FastContacts.getAllContacts();
      // TODO: Need to uncomment above line to get the actual data
      // TODO: Need to remove the below raw data...
      List<Map<String, String>> data = [
        {
          "id": "1",
          "name": "Supreme Court",
          "number": "+923053717314",
        },
        {
          "id": "1",
          "name": "High Court",
          "number": "+923033719258",
        },
        {
          "id": "1",
          "name": "Sam",
          "number": "+923063763586",
        },
        {
          "id": "1",
          "name": "abdul",
          "number": "+923033372287",
        },
        {
          "id": "1",
          "name": "unknown",
          "number": "+9328674769",
        },
      ];
      List<Contact> rawContacts = data.map((e) => Contact(id: e["id"]!, phones: [Phone(number: e["number"]!, label: "mobile")], emails: [], structuredName: StructuredName(displayName: e["name"]!, namePrefix: "", givenName: "", middleName: "", familyName: "", nameSuffix: ""), organization: Organization(company: "", department: "", jobDescription: "")),).toList();
      List<ContactModel> contacts =
          await ContactModel.empty().getFromContacts(contacts: rawContacts, getIsAppUser: true);
      return contacts;
    } else {
      return null;
    }
  }
}
