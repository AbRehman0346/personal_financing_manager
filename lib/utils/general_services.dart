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
    return phone.replaceAll(RegExp(r'[+ ]'), "");
  }


  Future<ContactModel?> getContactFromNumber(String number, {bool returnSameIfNotFound = false})async{
    List<ContactModel>? contacts = await OS().getContacts();
    if (contacts == null){
      if (returnSameIfNotFound){
        return ContactModel.fillOnlyNecessaryField(name: number, number: number);
      }else{
        throw Exception("Contact Permission Denied");
      }
    }
    for (ContactModel contact in contacts){
        if (number == getIdFromPhone(contact.number)){
          return contact;
        }
    }
    if (returnSameIfNotFound){
      return ContactModel.fillOnlyNecessaryField(name: number, number: number);
    }else{
      return null;
    }
  }
}