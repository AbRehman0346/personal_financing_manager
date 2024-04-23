import 'dart:developer';

import 'package:intl/intl.dart';

class HandleDatetime{
  static String formatDateTime(String datetime, {String format = 'dd-MM-yy – hh:mm'}){
    try{
      DateTime dt = DateTime.parse(datetime);
      return DateFormat(format).format(dt);
    }catch(e){
      log("Exception in converting string to date: $e");
      return "";
    }
  }
}