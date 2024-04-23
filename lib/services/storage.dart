import 'dart:developer';
import 'dart:typed_data';

import 'package:expense_tracking/utils/general_services.dart';
import 'package:firebase_storage/firebase_storage.dart';

class _StoragePaths{
  String profileImages = "profile_images/";
  String tripImages = "trips/";
}

class Storage{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String> _uploadImage(Uint8List image, String url) async {
      try{
        Reference ref = _storage.ref(url);
        await ref.putData(image);
        String downloadURl = await ref.getDownloadURL();
        return downloadURl;
      }catch(e){
        throw Exception();
      }
  }

  Future<String> uploadProfileImage(Uint8List image, String id) async {
    String url = _StoragePaths().profileImages + id;
    return await _uploadImage(image, url);
  }

  Future<String> uploadTripImage(Uint8List image) async {
    String uniquename = GeneralServices().getUniqueId();
    String url = "${_StoragePaths().tripImages}$uniquename";
    return await _uploadImage(image, url);
  }

  Future<String> getProfileImageFromPhone(String phone) async {
   //  it returns empty string if it can't find the image.
   try{
     String id = GeneralServices().getIdFromPhone(phone);
     return await _storage.ref(_StoragePaths().profileImages+id).getDownloadURL();
   }catch(e){
     log("Exception-Services-Storage-getProfileImageFormPhone: $e");
     return "";
   }
  }
}