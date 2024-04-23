import 'package:expense_tracking/services/services_helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Constants.dart';
import '../models/sign_up_models.dart';
import '../models/user_data_model.dart';
import 'firestore/firestore_auth.dart';

class Auth{
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<UserCredential> createAccount(SignUpUserModel model)async{
    UserCredential user = await auth.createUserWithEmailAndPassword(email: model.email, password: model.password);
    await FirestoreAuth().createAccount(model);
    return user;
  }

  Future<UserModel> signIn(String phone, String password) async {
    UserModel model = await FirestoreAuth().getUserData(phone);
    await auth.signInWithEmailAndPassword(email: ServicesHelperFunction().convertPhoneToEmail(phone), password: password);
    ProjectData.user = model;
    return model;
  }

  Future<void> signout()async {
    auth.signOut();
  }
}