import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'models/user_data_model.dart';

// class UserRoles {
//   static String admin = "admin";
//   String student = "student";
//   String teacher = "teacher";
// }


class CustomDialogs {
  void showDangerMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showWarningMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        backgroundColor: Colors.yellow,
      ),
    );
  }

  void showAndroidProgressBar(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => const AlertDialog(
        backgroundColor: Colors.transparent,
        content: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator(
            color: Colors.black,
          ),
        ]),
      ),
    );
  }

  void showIOsProgressBar(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => const AlertDialog(
        backgroundColor: Colors.transparent,
        content: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CupertinoActivityIndicator(),
        ]),
      ),
    );
  }

  void showOKDialog(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"))
          ],
        ));
  }

  void dangerOperationDialog({
    required BuildContext context,
    required String title,
    required String msg,
    Function? primaryButtonOnPressed,
    String? primaryButtonText,
    Function? secondaryButtonOnPressed,
    String? secondaryButtonText,
  }) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            ElevatedButton(
                onPressed: secondaryButtonOnPressed == null
                    ? () {
                  Navigator.pop(context);
                }
                    : () {
                  secondaryButtonOnPressed;
                },
                child: Text(secondaryButtonText ?? "Cancel")),
            ElevatedButton(
                onPressed: primaryButtonOnPressed == null
                    ? null
                    : () {
                  primaryButtonOnPressed();
                },
                child: Text(primaryButtonText ?? "OK"))
          ],
        ));
  }


  void createAlertDialogTemplate({
    required BuildContext context,
    required String title,
    required String guide,
    required String hint,
    String primaryButtonText = "OK",
    String secondaryButtonText = "Cancel",
    String? successMsg,
    required Function primaryButtonOnPressed,
    Function? secondaryButtonOnPressed,
    TextEditingController? controller,
  }) {
    Color bgColor = Colors.red.shade300;
    Color primaryColor = Colors.white;
    Color secondaryColor = Colors.white70;

    showDialog(
      useSafeArea: true,
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: bgColor,
        title: Text(
          title,
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              guide,
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: controller,
              style: TextStyle(color: primaryColor),
              decoration: InputDecoration(
                fillColor: Colors.red.shade200,
                filled: true,
                hintText: hint,
                hintStyle: TextStyle(color: secondaryColor),
                border: const OutlineInputBorder(),
                contentPadding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 10),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (secondaryButtonOnPressed != null) {
                secondaryButtonOnPressed();
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(secondaryButtonText,
              style: const TextStyle(color: Colors.white),),
          ),
          TextButton(
            onPressed: () {
              try {
                CustomDialogs().showAndroidProgressBar(context);
                primaryButtonOnPressed();
                Navigator.pop(context);
                Navigator.pop(context);
                controller?.text = "";
                Fluttertoast.showToast(msg: successMsg ?? "Operation Successful");
              } catch (e) {
                CustomDialogs()
                    .showDangerMessage(context, "Operation Failed: $e");
              }
            },
            child: Text(
              primaryButtonText,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}


class ProjectColors {
  static Color get primaryBlue => const Color.fromRGBO(7, 61, 255, 1);

  static Color get white => Colors.white;

  static Color get white_shade2 => const Color.fromRGBO(245, 245, 245, 1);

  static Color get selectionColorBlack => const Color.fromRGBO(0, 0, 0, 1);
}

class ProjectFonts {
  static const String protest = "Protest";
  static const String protestStrikeRegular = "Protest_Strike_Regular";
  static const String anton = "Anton";
  static const String lobster = "Lobster";
}

class ProjectData {
  static const String APP_VERSION = "v1.0.0";
  static UserModel? user;
  static User? authuser;
  String contactEmail = "abrehman0346@gmail.com";
}

class ProjectPaths {
  static const String SPLASH_SCREEN_BG = "assets/images/splash_bg.PNG";
  static const String WALLET = "assets/images/wallet.png";
  static const String THUMBS_UP = "assets/svg/thumbsUp.svg";
  static const String COIN = "assets/images/coin.png";
  static const String TRIP_ICON = "assets/svg/trip.svg";
  static const String PROFILE_ICON = "assets/svg/profile.svg";
  static const String front = "assets/svg/front.html";
  static const String bigFront = "assets/svg/big_front.svg";
  static const String profilePlaceholderImage = "assets/images/profileplaceholder.png";
  static const String tripDefaultImage = "assets/images/tips_defualt_image.jpg";
}
