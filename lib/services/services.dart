import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/FirstPage.dart';

class Service {
  final _auth = FirebaseAuth.instance;
  bool domaincheck = true;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> signup(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    var email = googleSignInAccount!.email;
    print(email);
    RegExp domain = RegExp(r'^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]+@iiita.ac.in$');
    if(!domain.hasMatch(email)){
      domaincheck = false;
      showDialog(context: context, builder: (BuildContext context){
        return const AlertDialog(
          title: Text('Email Domain Error'),
          content: Text('Sign in with College Email id'),
        );
      }
      );
      googleSignInAccount.clearAuthCache();
      _googleSignIn.signOut();
    }
    if (domaincheck) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await _auth.signInWithCredential(authCredential);
      User? user = result.user;
      print(user);
      final userInst = FirebaseFirestore.instance.collection("user");
      final query = userInst.where("uid", isEqualTo: user?.uid);
      query.get().then(
        (querySnapshot) {
          if (querySnapshot.docs.isEmpty) {
            final uploadData = <String, dynamic>{
              'uid': user?.uid,
              'name': user?.displayName,
              'photourl': user?.photoURL,
              'email': user?.email,
              'batch': '',
              'hostel': '',
              'id': '',
              'contact': '',
            };
            userInst.doc(user?.uid).set(uploadData);
          }
        },
        // onError: () => null,
        onError: (error, stackTrace) {
          // Handle the error here
          print('Error: $error');
          print('Stack Trace: $stackTrace');
        },
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const FirstPage()));
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => FirstPage()));
    // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }else {
      domaincheck = true;
    }
  }

  String? getDetails() {
    if (_auth.currentUser?.email != null) return _auth.currentUser?.email;
    return null;
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      print('Signed Out');
    } catch (e) {
      print('Error is signing out');
    }
  }
}
