import 'package:firebase_auth/firebase_auth.dart';
import '../models/sign_up_models.dart';
import '../models/user_data_model.dart';
import 'firestore.dart';

class Auth{
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<UserCredential> createAccount(SignUpUserModel model)async{
    UserCredential user = await auth.createUserWithEmailAndPassword(email: formatUsername(model.phone), password: model.password);
    await Firestore().createAccount(model);
    return user;
  }

  Future<UserModel> signIn(String phone, String password) async {
    UserModel model = await Firestore().getUserData(phone);
    if (model.isAccessAllowed) {
      await auth.signInWithEmailAndPassword(email: formatUsername(phone), password: password);
    }
    return model;
  }

  String formatUsername(String s){
    return "$s@gmail.com";
  }

  Future<void> signout()async {
    auth.signOut();
  }
}