import 'dart:developer';
import 'package:expense_tracking/Constants.dart';
import 'package:expense_tracking/models/contact_model.dart';
import 'package:expense_tracking/services/os.dart';
import 'package:expense_tracking/utils/general_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/xtextfield.dart';

class AllContactsDialog extends StatefulWidget {
  List<ContactModel> addedContacts;
  Function donefunction;
  AllContactsDialog({super.key, required this.addedContacts, required this.donefunction});

  @override
  State<AllContactsDialog> createState() => _AllContactsDialogState();
}

class _AllContactsDialogState extends State<AllContactsDialog> {
  List<ContactModel>? contacts;
  List<ContactModel> selectedModels = [];
  var searchController = TextEditingController();

  @override
  void initState() {
    OS().getContacts().then((value) => setState(() {
      contacts = value!;
      for(var model in contacts!){
        if (widget.addedContacts.where((element)=>element.id == model.id).isNotEmpty){
          if(selectedModels.where((element) => element.id == model.id).toList().isEmpty){
            selectedModels.add(model);
          }
        }
      }
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 500,
      height: 500,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("All Contacts"),),
        body: SizedBox(
          height: 450,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: XTextField(
                  controller: searchController,
                  onChange: (){
                    log("on change of textfield is called.");
                    setState(() {});
                  },
                  prefixIcon: const Icon(Icons.search),
                  hint: "Search",
                ),
              ),

              FutureBuilder(future: Future.delayed(Duration.zero, ()=>contacts), builder: (_, AsyncSnapshot snap){
                if(snap.hasData){
                  List<ContactModel> contacts = snap.data;
                  List<ContactModel> filteredContacts = contacts.where((contact) => contact.name.toLowerCase().contains(searchController.text.toLowerCase())).toList();
                    return Expanded(
                      child: ListView.builder(
                          itemCount: filteredContacts.length,
                          itemBuilder: (_, int index){
                            ContactModel contact = filteredContacts[index];
                            bool selected = selectedModels.where((element) => element.id == contact.id).toList().isNotEmpty;
                          return GestureDetector(
                            onTap: (){
                                setState(() {
                                  if (selected){
                                    selectedModels = selectedModels.where((element) => element.id != contact.id).toList();
                                  }else{
                                    selectedModels.add(contact);
                                  }
                                });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                  selected ?
                                  ProjectColors.selectionColorBlack :
                                  ProjectColors.white_shade2,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                              child: ListTile(
                                selectedColor: Colors.blue,
                                      title: Text(
                                        contact.name,
                                        style: TextStyle(
                                            color: selected ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                subtitle: Text(contact.number,
                                  style: TextStyle(color: selected ? Colors.white : Colors.black),),
                              ),
                            ),
                          );
                      }),
                    );
                }else{
                  return const SizedBox(
                    height: 350,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                }
              })
            ],
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: (){
            log(selectedModels.toString());
            for (int i=0; i<selectedModels.length; i++){
              log(selectedModels[i].id);
            }
            widget.donefunction(selectedModels);
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 3),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            decoration: BoxDecoration(
              color: ProjectColors.primaryBlue,
              borderRadius: BorderRadius.circular(20)
            ),

            child: const Text("Done", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
          ),
        ),
      ),
    );
  }
}
