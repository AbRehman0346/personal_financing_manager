import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracking/screens/temp_tests/test_contstants.dart';
import 'package:expense_tracking/services/services_helper_functions.dart';

import '../Constants.dart';
import '../models/sign_up_models.dart';
import '../models/user_data_model.dart';

class Collections {
  static final FirebaseFirestore _store = FirebaseFirestore.instance;
  CollectionReference accountsCollection = _store.collection("accounts");
}

class Firestore extends Collections{
  static final FirebaseFirestore _store = FirebaseFirestore.instance;
  Future<void> createAccount(SignUpUserModel model) async {
    await accountsCollection
        .doc(model.phone)
        .set(model.toMap());
    ProjectData.user = model.toUserModel();
  }



  Future<UserModel> getUserData(String phone) async {
    phone = ServicesHelperFunction().convertEmailToPhone(phone);
    DocumentSnapshot snap =
    await accountsCollection.doc(phone).get();
    return UserModel.fromDocumentSnapshot(snap);
  }

  Stream<QuerySnapshot> getUsers(){
    return accountsCollection.snapshots();
  }



  Future<bool> isAppUser(String phone)async{
    DocumentSnapshot doc = await accountsCollection.doc(phone).get();
    return doc.exists;
  }
}