import 'dart:developer';
import 'dart:typed_data';

import 'package:expense_tracking/services/general_services.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Storage{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String> uploadProfileImage(Uint8List image) async {
      try{
        String uniquename = GeneralServices().getUniqueId();
        String url = "profile_images/$uniquename";
        Reference ref = _storage.ref(url);
        await ref.putData(image);
        String downloadURl = await ref.getDownloadURL();
        return downloadURl;
      }catch(e){
        throw Exception();
      }
  }
}