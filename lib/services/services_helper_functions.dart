class ServicesHelperFunction {


  String convertPhoneToEmail(String s){
    return "$s@gmail.com";
  }


  String convertEmailToPhone(String phone){
    return phone.replaceAll("@gmail.com", "");
  }

  String getIdFromPhone(String phone){
    return phone.replaceAll("+", "").replaceAll(" ", "");
  }
}