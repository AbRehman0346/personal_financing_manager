import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracking/models/sign_up_models.dart';

import '../Constants.dart';

class UserModel{
  String name;
  String phone;
  String role;
  String accountId;
  String access;

  UserModel({required this.name, required this.phone, required this.role, required this.accountId, required this.access});

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot snap){
    SignUpUserModelFields fields = SignUpUserModelFields();
    return UserModel(
      accountId: snap.id,
        name: snap.get(fields.nameField),
        phone: snap.get(fields.phoneField),
        role: snap.get(fields.roleField),
        access: snap.get(fields.accessField),
    );
  }

  bool get isAdmin => role == UserRoles.admin;

  bool get isAccessAllowed => access == AccessControl.allowed;

  bool get isAccessDenied => access == AccessControl.denied;
}