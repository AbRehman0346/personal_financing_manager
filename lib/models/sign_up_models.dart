import 'package:expense_tracking/models/user_data_model.dart';
import 'package:expense_tracking/services/services_helper_functions.dart';

class AccessControl {
  static String allowed = "allowed";
  static String denied = "denied";
}

class SignUpUserModelFields {
  String nameField = "name";
  String phoneField = "phone";
  String passwordField = "password";
  String roleField = "role";
  String accessField = "access";
  // String emailField = "email";
}

class SignUpUserModel {
  String fullName;
  late String email;
  String phone;
  String password;
  String role;
  String access;
  SignUpUserModel({
    required this.fullName,
    required this.phone,
    required this.password,
    required this.role,
    required this.access,
  }){
    email = ServicesHelperFunction().convertPhoneToEmail(phone);
  }

  UserModel toUserModel(){
    return UserModel(name: fullName, phone: phone, role: role, accountId: phone, access: access);
  }

  Map<String, dynamic> toMap() {
    SignUpUserModelFields f = SignUpUserModelFields();
    return {
      f.nameField: fullName,
      f.phoneField: phone,
      f.passwordField: password,
      f.roleField: role,
      f.accessField: access,
    };
  }
}
