import 'package:expense_tracking/services/services_helper_functions.dart';
import 'package:fast_contacts/fast_contacts.dart';

import '../Constants.dart';
import '../services/firestore.dart';

class ContactModel{
  String id = "";
  String name = "";
  String number = "";
  bool? isuser;
  bool isowner = false;

  ContactModel._();

  factory ContactModel.empty(){
    return ContactModel._();
  }

  factory ContactModel.fill({required String id, required String name, required String number, required bool? isuser}){
    ContactModel model = ContactModel._();
    model.id = id;
    model.name = name;
    model.number = number;
    model.isowner = ServicesHelperFunction().getIdFromPhone(number) == ProjectData.user!.phone;
    model.isuser = isuser;
    return model;
  }

  factory ContactModel.fillOnlyNecessaryField({required String name, required String number}){
    ContactModel model = ContactModel._();
    model.name = name;
    model.number = number;
    model.isowner = ServicesHelperFunction().getIdFromPhone(number) == ProjectData.user!.phone;
    return model;
  }


  Future<List<ContactModel>> getFromContacts({required List<Contact> contacts, bool getIsAppUser = false}) async {
    List<ContactModel> models = [];
    for (Contact contact in contacts){
      for (Phone phone in contact.phones){
        bool? isAppUser;
        if(getIsAppUser){
          isAppUser = await Firestore().isAppUser(ServicesHelperFunction().getIdFromPhone(phone.number));
        }
        models.add(ContactModel.fill(id: contact.id, name: contact.displayName, number: phone.number, isuser: isAppUser));
      }
    }
    return models;
  }
}