import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Constants.dart';

class Collections {
  static final FirebaseFirestore _store = FirebaseFirestore.instance;
  CollectionReference accountsCollection = _store.collection("accounts");
  CollectionReference tripReference = _store.collection("all_trips");
  // CollectionReference get userTripReference => tripReference.doc(ProjectData.user!.phone).collection("trips");
}