import 'dart:developer';

import 'package:intl/intl.dart';

class GeneralServices{
  String formatDateTime(String datetime, {String format = 'dd-MM-yy – hh:mm'}){
    try{
      DateTime dt = DateTime.parse(datetime);
      return DateFormat(format).format(dt);
    }catch(e){
      log("Exception in converting string to date: $e");
      return "";
    }
  }

  String getUniqueId(){
    return DateTime.now().toString().replaceAll(RegExp(r'[-.: ]'), '');
  }
}