import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracking/models/sign_up_models.dart';

import '../Constants.dart';

class UserModel{
  String accountId;
  String name;
  String phone;
  String? image;

  UserModel({this.image, required this.name, required this.phone, required this.accountId});

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot snap){
    SignUpUserModelFields fields = SignUpUserModelFields();
    return UserModel(
        accountId: snap.id,
        name: snap.get(fields.nameField),
        phone: snap.get(fields.phoneField),
        image: snap.get(fields.profileImage),
    );
  }
}