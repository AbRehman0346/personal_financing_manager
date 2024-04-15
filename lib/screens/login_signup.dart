import 'dart:developer';
import 'package:expense_tracking/generated_files/expanse_tracking_icons_icons.dart';
import 'package:expense_tracking/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Constants.dart';
import '../models/sign_up_models.dart';
import '../models/user_data_model.dart';
import '../route_generator.dart';
import '../services/auth.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  TextEditingController signUpFullNameController = TextEditingController();
  TextEditingController signUpPhoneController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
  TextEditingController();
  TextEditingController signInPhoneController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();
  bool showSignUPFirst = false;
  bool signUpObscurePassword = true;
  bool signInObscurePassword = true;
  bool signUpLoading = false;
  bool signInLoading = false;

  Color bgColor = const Color.fromRGBO(134, 126, 255, 1);
  late double boxHeight;
  late double boxTextFieldWidth;
  late double boxWidth;

  late TextStyle activatedBoxHeadingTextStyling;
  late TextStyle deactivatedBoxHeadingTextStyling;
  late Color activatedBoxHeadingUnderLineColor;
  late Color deactivatedBoxHeadingUnderLineColor;

  List countryCodes = [{
    "label": "+92",
    "value" : "92",
  },
    {
      "label": "+91",
      "value" : "91",
    },
    {
      "label": "+1",
      "value" : "1",
    },
  ];
  String? signupSelectedCountryCode = "92";
  String? signinSelectedCountryCode = "92";

  @override
  Widget build(BuildContext context) {
    boxHeight = MediaQuery.of(context).size.height * 0.6;
    boxWidth = MediaQuery.of(context).size.width * 0.8;
    boxTextFieldWidth = boxWidth * 0.8;
    String mainText = showSignUPFirst ? "Join Us" : "Welcome Back";
    String secondaryText = showSignUPFirst
        ? "And Learn the Latest Concepts"
        : "Glad to Have You Back";
    activatedBoxHeadingTextStyling = const TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);
    deactivatedBoxHeadingTextStyling = const TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black12);
    activatedBoxHeadingUnderLineColor = bgColor;
    deactivatedBoxHeadingUnderLineColor =
    const Color.fromRGBO(209, 206, 255, 1);

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Page Primary Text
                Text(
                  mainText,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                // Page Secondary Text
                Text(
                  secondaryText,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),

                // Spacing
                const SizedBox(height: 70),

                showSignUPFirst
                    ? Stack(
                  children: [
                    signInBox(),
                    signUpBox(),
                  ],
                )
                    : Stack(
                  children: [
                    signUpBox(),
                    signInBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpBox() {
    Color signUpBgColor = const Color.fromRGBO(231, 230, 255, 1);
    return GestureDetector(
      onTap: () {
        setState(() {
          showSignUPFirst = true;
        });
      },
      child: SizedBox(
        width: boxWidth,
        // SignUp Box
        child: Stack(
          children: [
            // SignUp Text, TextFields
            Container(
              height: boxHeight,
              width: boxWidth,
              decoration: BoxDecoration(
                color: signUpBgColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(250),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                boxShadow: showSignUPFirst
                    ? [
                  const BoxShadow(
                      color: Colors.grey,
                      offset: Offset(-3, -3),
                      blurRadius: 20),
                ]
                    : null,
              ),
              // SignUp Text, UnderLine And TextFields
              child: Stack(
                children: [
                  // SignUp Text And UnderLine
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    // Signup Text And UnderLine
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // SignText
                        Text("SignUp",
                            style: showSignUPFirst
                                ? activatedBoxHeadingTextStyling
                                : deactivatedBoxHeadingTextStyling),
                        // Underline to SingUpText
                        Container(
                          height: 8,
                          width: 100,
                          decoration: BoxDecoration(
                              color: showSignUPFirst
                                  ? activatedBoxHeadingUnderLineColor
                                  : deactivatedBoxHeadingUnderLineColor,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                  ),

                  // TextFields: Full Name, Phone, Password, Confirm Password
                  SizedBox(
                    width: boxWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // TextFields Name, Number, Password, Confirm Password
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(top: 80),
                          width: boxTextFieldWidth,
                          // TextFields Name, Number, Password, Confirm Password
                          child: Column(
                            children: [
                              // Full Name TextField
                              TextField(
                                controller: signUpFullNameController,
                                decoration: const InputDecoration(
                                  hintText: "Enter Full Name",
                                ),
                              ),

                              // phone TextField
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Dropdown
                                  Container(
                                  width: 55,
                                  height: 20,
                                    child: DropdownButton(
                                      items: countryCodes.map(
                                            (e) => DropdownMenuItem(value: e["value"],child:
                                      Text(e["label"]),
                                      ),).toList(),
                                      onChanged: (value){
                                          setState(() {
                                            signupSelectedCountryCode = value.toString();
                                          });
                                      },
                                      value: signupSelectedCountryCode,
                                    ),
                                  ),


                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: TextField(
                                      controller: signUpPhoneController,
                                      decoration: const InputDecoration(
                                        hintText: "Enter Phone Number",
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Password TextField
                              TextField(
                                controller: signUpPasswordController,
                                obscureText: signUpObscurePassword,
                                decoration: InputDecoration(
                                  hintText: "Enter Password",
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          signUpObscurePassword =
                                          !signUpObscurePassword;
                                        });
                                      },
                                      child: Icon(
                                          signUpObscurePassword
                                              ? ExpanseTrackingIcons.eye
                                              : ExpanseTrackingIcons.eye_slash,
                                          size: 20)),
                                ),
                              ),
                              // confirm Password TextField
                              TextField(
                                obscureText: signUpObscurePassword,
                                controller: signUpConfirmPasswordController,
                                decoration: const InputDecoration(
                                  hintText: "Confirm Password",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Sign Up Button
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: boxHeight - 25),
              child: ElevatedButton(
                onPressed: signUpButtonOnPressed,
                child: signUpLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                  "   SIGN UP   ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget signInBox() {
    Color signUpBgColor = Colors.white;
    return GestureDetector(
      onTap: () {
        setState(() {
          showSignUPFirst = false;
        });
      },
      child: SizedBox(
        width: boxWidth,
        // SignUp Box
        child: Stack(
          children: [
            // SignIn Text, TextFields
            Container(
              height: boxHeight,
              width: boxWidth,

              decoration: BoxDecoration(
                color: signUpBgColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(250),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                boxShadow: showSignUPFirst
                    ? null
                    : [
                  const BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3, 3),
                      blurRadius: 20),
                ],
              ),
              // SignIn Text, UnderLine And TextFields
              child: Stack(
                children: [
                  // SignIn Text And UnderLine
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    // Signin Text And UndreLine
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // SignText
                        Text(
                          "SignIn",
                          style: showSignUPFirst
                              ? deactivatedBoxHeadingTextStyling
                              : activatedBoxHeadingTextStyling,
                        ),
                        // Underline to SingUpText
                        Container(
                          height: 8,
                          width: 90,
                          decoration: BoxDecoration(
                              color: showSignUPFirst
                                  ? deactivatedBoxHeadingUnderLineColor
                                  : activatedBoxHeadingUnderLineColor,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                  ),

                  // TextFields: Phone, Password
                  SizedBox(
                    width: boxWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // TextFields Name, Number, Password
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(top: 80),
                          width: boxTextFieldWidth,
                          // Number, Password
                          child: Column(
                            children: [
                              // phone TextField
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Country Code drop down button container
                                  SizedBox(
                                    width: 55,
                                    height: 20,
                                    child: DropdownButton(
                                      items: countryCodes.map(
                                            (e) => DropdownMenuItem(value: e["value"],child:
                                        Text(e["label"]),
                                        ),).toList(),
                                      onChanged: (value){
                                        setState(() {
                                          signinSelectedCountryCode = value.toString();
                                        });
                                      },
                                      value: signinSelectedCountryCode,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: TextField(
                                      controller: signInPhoneController,
                                      decoration: const InputDecoration(
                                        hintText: "Enter Phone Number",
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Password TextField
                              TextField(
                                controller: signInPasswordController,
                                obscureText: signInObscurePassword,
                                decoration: InputDecoration(
                                    hintText: "Enter Password",
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          signInObscurePassword =
                                          !signInObscurePassword;
                                        });
                                      },
                                      child: Icon(
                                          signInObscurePassword
                                              ? ExpanseTrackingIcons.eye
                                              : ExpanseTrackingIcons.eye_slash,
                                          size: 20),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Sign Up Button
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: boxHeight - 25),
              child: ElevatedButton(
                onPressed: signInButtonOnPressed,
                child: signInLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                  "   SIGN IN   ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUpButtonOnPressed() async {
    try {
      // Collecting Data
      String fullName = signUpFullNameController.text;
      String phone = signUpPhoneController.text;
      String password = signUpPasswordController.text;
      String confirmPassword = signUpConfirmPasswordController.text;

      // Validation
      if (fullName == "") {
        Fluttertoast.showToast(msg: "Name is Missing");
        return;
      }
      if (phone == "") {
        Fluttertoast.showToast(msg: "Phone Number is Missing");
        return;
      }
      if (phone[0] == "0") {
        Fluttertoast.showToast(
            msg: "Please Remove the first zero from Phone Number");
        return;
      }
      if (password.length < 8) {
        Fluttertoast.showToast(msg: "Password Must be of 8 Characters");
        return;
      }
      if (password != confirmPassword) {
        Fluttertoast.showToast(msg: "Passwords Don't match");
        return;
      }


      for (int i = 0; i < phone.length; i++) {
        if (phone.codeUnitAt(i) < 48 && phone.codeUnitAt(i) > 57) {
          Fluttertoast.showToast(msg: "Phone can only contain numbers");
          return;
        }
      }

      if (signupSelectedCountryCode == null){
        Fluttertoast.showToast(msg: "Unexpected Error in Country Code.");
        return;
      }else{
        phone = signupSelectedCountryCode! + phone;
      }


      // Starting Loading Indicator
      setState(() {
        signUpLoading = true;
      });


      // SignUp Process--------
      // Creating Model
      SignUpUserModel model = SignUpUserModel(
        fullName: fullName,
        phone: phone,
        password: password,
        role: UserRoles().student,
        access: AccessControl.allowed,
      );

      // Signup request
      await Auth().createAccount(model);
      setState(() {
        signUpLoading = false;
      });

      // Navigating to Home Page (if successful)
      if (mounted) {
        ProjectData.user = await Firestore().getUserData(model.email);
        Navigator.pushAndRemoveUntil(
            context,
            RouteGenerator.generateRoute(
                const RouteSettings(name: Routes.homeScreen)),
                (route) => false);
      }
    } catch (e) {
      // Catching Error if unsuccessful
      setState(() {
        signUpLoading = false;
      });
      if (mounted) {
        log(e.toString());

        // Signup failed message showing
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Signup Failed: $e",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        );
      }
    }
  }

  void signInButtonOnPressed() async {
    try {
      String phone = signInPhoneController.text;
      String password = signInPasswordController.text;

      if (phone == "") {
        Fluttertoast.showToast(msg: "Phone Number is Missing");
        return;
      } else if (phone[0] == "0") {
        Fluttertoast.showToast(
            msg: "Please Remove the first zero from Phone Number");
        return;
      }

      if (signinSelectedCountryCode == null){
        Fluttertoast.showToast(msg: "Unexpected Error in Country Code.");
        return;
      }else{
        phone = signinSelectedCountryCode! + phone;
      }

      setState(() {
        signInLoading = true;
      });

      UserModel model = await Auth().signIn(phone, password);

      // This code is commented because the StreamBuilder in main file
      // automatically navigates to the home page.
      if (mounted && model.access == AccessControl.allowed){
        Navigator.pushAndRemoveUntil(
          context,
          RouteGenerator.generateRoute(
              const RouteSettings(name: Routes.homeScreen)),
              (route) => false,
        );
      } else if(mounted && model.access == AccessControl.denied){
        Messages().showOKDialog(context, "User Blocked", "You're Not Allowed to access the Application\nFor More info Contact at: ${ProjectData().contactEmail}");
        return;
      }
    } catch (e) {
      if (mounted) {
        log(e.toString());
        Messages().showDangerMessage(context, "Signup Failed: $e");
      }
    } finally {
      setState(() {
        signInLoading = false;
      });
    }
  }
}
