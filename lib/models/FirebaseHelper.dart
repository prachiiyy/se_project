import 'package:cloud_firestore/cloud_firestore.dart';

import 'Usermodel.dart';

class FirebaseHelper{

  static Future<UserModel?> getUserModelById(String uid) async {
    UserModel? userModel;

    DocumentSnapshot docsnap = await FirebaseFirestore.instance.collection("user").doc(uid).get();

    if(docsnap.data() != null)
    {
      userModel = UserModel.fromMap(docsnap.data() as Map<String, dynamic>);
    }

    return userModel;
  }
}