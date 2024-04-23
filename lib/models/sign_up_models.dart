import 'dart:typed_data';

import 'package:expense_tracking/models/user_data_model.dart';
import 'package:expense_tracking/services/services_helper_functions.dart';

class SignUpUserModelFields {
  String nameField = "name";
  String phoneField = "phone";
  String passwordField = "password";
  String profileImage = "image";
  // String emailField = "email";
}

class SignUpUserModel {
  String fullName;
  late String email;
  String phone;
  String password;
  Uint8List? image;

  SignUpUserModel({
    this.image,
    required this.fullName,
    required this.phone,
    required this.password,
  }){
    email = ServicesHelperFunction().convertPhoneToEmail(phone);
  }

  UserModel toUserModel(String imagedownloadurl){
    return UserModel(image: imagedownloadurl, name: fullName, phone: phone, accountId: phone);
  }

  Map<String, dynamic> toMap(String? imagedownloadurl) {
    SignUpUserModelFields f = SignUpUserModelFields();
    return {
      f.nameField: fullName,
      f.phoneField: phone,
      f.passwordField: password,
      f.profileImage: imagedownloadurl,
    };
  }
}
