import 'dart:developer';
import 'dart:typed_data';
import 'package:expense_tracking/models/trip_model.dart';
import 'package:expense_tracking/models/user_data_model.dart';
import 'package:expense_tracking/services/firestore/firestore.dart';
import 'package:expense_tracking/services/general_services.dart';
import 'package:expense_tracking/services/permissions.dart';
import 'package:expense_tracking/services/services_helper_functions.dart';
import 'package:expense_tracking/services/storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Constants.dart';
import '../models/contact_model.dart';
import '../models/upload/TripUploadModel.dart';

class CreateTripScreen extends StatefulWidget {
  CreateTripScreen({super.key});

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  Uint8List? file;
  // List<ContactModel> addedContacts = [];
  List<String> addedContactNumbers = [];
  TextEditingController tripNameController = TextEditingController();

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

if (file != null){
  String response = await Storage().uploadProfileImage(file!);
  if (response != ""){
    log("File uploaded Successfully");
  }else{
    log("Some error occurred");
  }

}else{
  log("File is null");
}

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
            controller: tripNameController,
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
          // Create Trip Button
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            // Create Trip Button
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ProjectColors.primaryColor),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: createTrip,
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

              void addRemoveContactActionHandler(ContactModel contact, bool action){
                    // in action, true means add and false means remove.
                    setState(() {
                      if (action){
                        // addedContacts.add(contact);
                        addedContactNumbers.add(contact.number);
                      }else{
                        addedContactNumbers.remove(contact.number);
                        // addedContacts.removeAt(index);
                      }
                    });
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    ContactModel contact = contacts[index];
                    bool isAdded = addedContactNumbers.contains(contact.number);
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
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
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5),
                                      decoration: BoxDecoration(
                                        color: ProjectColors.shadow,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        "Owner",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : contact.isuser == null
                                      ? const SizedBox.shrink()
                                      : contact.isuser!
                                          // Add
                                          ? GestureDetector(
                                onTap: () => addRemoveContactActionHandler(contact, !isAdded),
                                            child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 5),
                                                decoration: BoxDecoration(
                                                  color: isAdded ? Colors.blue : Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  isAdded ? "Added":"Add",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          )
                                          // Invite
                                          : Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 5,
                                                  bottom: 5),
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Text(
                                                "Invite",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                            ],
                          ),
                          subtitle: Text(contact.number),
                        ),
                        index == contacts.length - 1
                            ? const SizedBox(height: 80)
                            : const SizedBox.shrink()
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

  void createTrip()async {
    CustomDialogs dialogs = CustomDialogs();
    dialogs.showProgressBar(context);

    // Collecting All Data and storing in variables.
    Uint8List? file = this.file;
    String name = tripNameController.text;
    List<String> participants = addedContactNumbers;
    String? error;

    //Validation
    if (name == ""){
      error = "Provide Trip Name";
    }else if (participants.isEmpty){
      error = "Add at least one participant";
    }

    if (error != null){
      CustomDialogs().showWarningMessage(context, error);
      Navigator.pop(context);
      return;
    }



    // Creating Trip
    TripUploadModel trip = TripUploadModel(tripName: name, image: file, participants: participants);
    try{
      await Firestore().createTrip(trip);
      if(mounted){
        Fluttertoast.showToast(msg: "Trip Created");
        // Hiding the progress bar
        Navigator.pop(context);
        // Retuning from create trip page.
        Navigator.pop(context);
      }
    }catch(e){
      log("Exception in creating trip $e");
      if (mounted){
        CustomDialogs().showDangerMessage(context, "Failed to Create Trip");
      }
      // Hiding progress bar.
      if(mounted){
        Navigator.pop(context);
      }
    }
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
          "id": "2",
          "name": "High Court",
          "number": "+923033719258",
        },
        {
          "id": "3",
          "name": "Sam",
          "number": "+923063763586",
        },
        {
          "id": "4",
          "name": "abdul",
          "number": "+923033372287",
        },
        {
          "id": "5",
          "name": "unknown",
          "number": "+9328674769",
        },
      ];
      List<Contact> rawContacts = data
          .map(
            (e) => Contact(
                id: e["id"]!,
                phones: [Phone(number: e["number"]!, label: "mobile")],
                emails: [],
                structuredName: StructuredName(
                    displayName: e["name"]!,
                    namePrefix: "",
                    givenName: "",
                    middleName: "",
                    familyName: "",
                    nameSuffix: ""),
                organization: const Organization(
                    company: "", department: "", jobDescription: "")),
          )
          .toList();
      List<ContactModel> contacts = await ContactModel.empty()
          .getFromContacts(contacts: rawContacts, getIsAppUser: true);
      return contacts;
    } else {
      return null;
    }
  }
}
