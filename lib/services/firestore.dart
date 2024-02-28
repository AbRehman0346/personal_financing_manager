import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/sign_up_models.dart';
import '../models/user_data_model.dart';

class Collections {
  static final FirebaseFirestore _store = FirebaseFirestore.instance;
  String accountsCollection = "accounts";
}

class Firestore extends Collections{
  static final FirebaseFirestore _store = FirebaseFirestore.instance;
  Future<void> createAccount(SignUpUserModel model) async {
    await _store
        .collection(accountsCollection)
        .doc(model.phone)
        .set(model.toMap());
  }

  Future<UserModel> getUserData(String phone) async {
    phone = phone.replaceAll("@gmail.com", "");
    DocumentSnapshot snap =
    await _store.collection(accountsCollection).doc(phone).get();
    return UserModel.fromDocumentSnapshot(snap);
  }

  Stream<QuerySnapshot> getUsers(){
    return _store
        .collection(Collections().accountsCollection)
        .snapshots();
  }
}