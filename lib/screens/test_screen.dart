import 'package:expense_tracking/Constants.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget appbar = const Text(
      "Create Trip",
      style: TextStyle(fontSize: 22),
    );

    Widget imageAndUploadImageText = Center(
      child: Column(
        children: [
          ClipOval(
            child: CircleAvatar(
              radius: 80,
              child: Image.asset(
                "assets/images/profileplaceholder.png",
                width: double.maxFinite,
                height: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Text(
            "Upload Image",
            style: TextStyle(fontSize: 22),
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
                  child: Row(
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

    List participantsData = [
      {
        "image": "assets/images/me.jpg",
        "name": "John Doe",
        "isowner": true,
      },
      {
        "image": "assets/images/me.jpg",
        "name": "Mia Jack",
        "isowner": false,
      },
      {
        "image": "assets/images/me.jpg",
        "name": "Keto Romio",
        "isowner": false,
      },
      {
        "image": "assets/images/me.jpg",
        "name": "Keto Romio",
        "isowner": false,
      },
      {
        "image": "assets/images/me.jpg",
        "name": "Keto Romio",
        "isowner": false,
      },
      {
        "image": "assets/images/me.jpg",
        "name": "Keto Romio",
        "isowner": false,
      },
      {
        "image": "assets/images/me.jpg",
        "name": "Keto Romio",
        "isowner": false,
      },
    ];

    Widget listOfParticipants = Expanded(
      child: ListView.builder(
        itemCount: participantsData.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
          leading: ClipOval(
            child: CircleAvatar(
              child: Image.asset(
                participantsData[index]["image"],
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
                  Text(
                    participantsData[index]["name"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  participantsData[index]["isowner"] as bool
                      ? const Text(
                          "  (You)",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        )
                      : const SizedBox(),
                ],
              ),
              participantsData[index]["isowner"] as bool
                  ? Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: ProjectColors.shadow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Owner",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Invite",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );

    Widget createTripButton = Row(
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
            child: Text(
              "Create Trip",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );

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
            listOfParticipants,

            //   Create Trip Button
            createTripButton,
          ],
        ),
      ),
    );
  }
}
