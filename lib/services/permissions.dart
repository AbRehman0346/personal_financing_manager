import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

class HandlePermissions{
  Future<bool> handleContactPermission() async {
    // TODO: Need to correct this permission... afterwards. It doesn't work. program stacks while requesting.
    return true;
    log("Requesting peremssion");
    PermissionStatus status = await Permission.contacts.request();
    log("Got the permission status");
    return status.isGranted;
  }
}