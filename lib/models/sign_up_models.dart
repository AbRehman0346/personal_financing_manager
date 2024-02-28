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
}

class SignUpUserModel {
  String fullName;
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
  });

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
