import 'dart:developer';
import 'dart:typed_data';

import 'package:expense_tracking/services/os.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../models/contact_model.dart';

class GeneralServices{
  String getUniqueId(){
    return DateTime.now().toString().replaceAll(RegExp(r'[-.: ]'), '');
  }

  Future<Uint8List?> getImageFromGallery()async{
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xfile == null) return null;
    return await xfile.readAsBytes();
  }

  String getIdFromPhone(String phone){
    String id = phone.replaceAll(RegExp(r'[+ -]'), "");
    if(id[0] == "0"){
      // TODO: Country Code 92 is hardcoded.. need to fix it according to other countries
      // local country code... also need to check if any country code has 0 in starting in which case
      // this function will not perform as expected.
      id = id.replaceFirst("0", "92");
    }
    return id;
  }


  Future<ContactModel?> getContactFromNumber(String number)async{
    List<ContactModel>? contacts = await OS().getContacts();
    if (contacts != null){
      for (ContactModel contact in contacts){
        if (number == getIdFromPhone(contact.number)){
          return contact;
        }
      }
    }
    return ContactModel.fillOnlyNecessaryField(name: number, number: number);
  }
}