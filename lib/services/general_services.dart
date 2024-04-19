import 'package:intl/intl.dart';

class GeneralServices{
  String formatDateTime(DateTime datetime, {String format = 'dd-MM-yy – hh:mm'}){
    return DateFormat(format).format(datetime);
  }

  String getUniqueId(){
    return DateTime.now().toString().replaceAll(RegExp(r'[-.: ]'), '');
  }
}