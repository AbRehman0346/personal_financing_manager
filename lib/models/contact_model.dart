import 'dart:developer';

import 'package:expense_tracking/services/services_helper_functions.dart';
import 'package:expense_tracking/utils/general_services.dart';
import 'package:fast_contacts/fast_contacts.dart';

import '../Constants.dart';
import '../services/firestore/firestore_auth.dart';

class ContactModel{
  String id = "";
  String name = "";
  String number = "";
  bool isowner = false;

  ContactModel._();

  factory ContactModel.empty(){
    return ContactModel._();
  }

  factory ContactModel.fill({required String id, required String name, required String number}){
    ContactModel model = ContactModel._();
    model.id = id;
    model.name = name;
    model.number = number;
    model.isowner = GeneralServices().getIdFromPhone(number) == ProjectData.user!.phone;
    return model;
  }

  factory ContactModel.fillOnlyNecessaryField({required String name, required String number}){
    ContactModel model = ContactModel._();
    model.name = name;
    model.number = number;
    model.isowner = GeneralServices().getIdFromPhone(number) == ProjectData.user!.phone;
    return model;
  }

  Future<List<ContactModel>> getFromContact({required Contact contact}) async {
    List<ContactModel> models = [];
      for (Phone phone in contact.phones){
        models.add(ContactModel.fill(id: contact.id, name: contact.displayName, number: phone.number));
      }
    return models;
  }

  Future<List<ContactModel>> getFromContacts({required List<Contact> contacts}) async {
    List<ContactModel> models = [];
    GeneralServices gs = GeneralServices();
    for (Contact contact in contacts){
      for (Phone phone in contact.phones){
        models.add(ContactModel.fill(id: gs.getIdFromPhone(phone.number), name: contact.displayName, number: phone.number));
      }
    }
    return models;
  }
}