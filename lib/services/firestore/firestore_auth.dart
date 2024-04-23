import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracking/screens/temp_tests/test_contstants.dart';
import 'package:expense_tracking/services/services_helper_functions.dart';
import 'package:expense_tracking/services/storage.dart';
import 'firebase_collections.dart';
import '../../Constants.dart';
import '../../models/sign_up_models.dart';
import '../../models/user_data_model.dart';

class FirestoreAuth extends Collections{
  Future<void> createAccount(SignUpUserModel model) async {

    // upload image
    String? downloadurl;
    if(model.image != null){
      downloadurl = await Storage().uploadProfileImage(model.image!, model.phone);
    }

    // saving user data.
    await accountsCollection
        .doc(model.phone)
        .set(model.toMap(downloadurl));

    // creating a central place to access user data.
    ProjectData.user = await getUserData(model.phone);
  }

  Future<UserModel> getUserData(String phone) async {
    try{
      phone = ServicesHelperFunction().convertEmailToPhone(phone);
      DocumentSnapshot snap =
      await accountsCollection.doc(phone).get();
      return UserModel.fromDocumentSnapshot(snap);
    }catch(e){
      throw Exception(e);
    }
  }

  Stream<QuerySnapshot> getUsers(){
    return accountsCollection.snapshots();
  }

  Future<bool> isAppUser(String phone)async{
    DocumentSnapshot doc = await accountsCollection.doc(phone).get();
    return doc.exists;
  }
}