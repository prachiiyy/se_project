import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:helpmeout/components/ProfileData.dart';

class EditProfile extends StatefulWidget {
  final ProfileData profileData;
  const EditProfile({super.key, required this.profileData});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _batchController = TextEditingController();
  TextEditingController _hostelController = TextEditingController();
  TextEditingController _bloodGroupController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize text controllers with current profile data
    _idController = TextEditingController(text: widget.profileData.id);
    _emailController = TextEditingController(text: widget.profileData.email);
    _batchController = TextEditingController(text: widget.profileData.batch);
    _hostelController = TextEditingController(text: widget.profileData.hostel);
    _bloodGroupController = TextEditingController(text: 'O+');
    _contactController =
        TextEditingController(text: widget.profileData.contact);
  }

  @override
  void dispose() {
    // Dispose text controllers when this widget is removed from the tree
    _idController.dispose();
    _emailController.dispose();
    _batchController.dispose();
    _hostelController.dispose();
    _bloodGroupController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  bool uploading = false;

  void saveDetails() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    final userInst =
        FirebaseFirestore.instance.collection("user").doc(uid);
    await userInst.update({
      'id': _idController.text,
      'hostel': _hostelController.text,
      'batch': _batchController.text,
      'contact': _contactController.text,
    });
    Navigator.pop(context);
  }

  bool _isSendOtp = false;
  bool verified = false;
  final _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();

  Future<bool> _sendOtp(String phone) async {
    if (_isSendOtp) {
      return false;
    }

    _isSendOtp = true;
    setState(() {
      _isSendOtp = true;
    });

    Completer<bool> completer = Completer<bool>();
    Timer? timeouttimer;

    User? currentUser = FirebaseAuth.instance.currentUser;

    _auth.verifyPhoneNumber(
      phoneNumber: "+91$phone",
      verificationCompleted: (PhoneAuthCredential credential) async {
        if (currentUser != null) {
          try {
            await currentUser.linkWithCredential(credential);
            print("Phone number linked successfully!");
            completer.complete(true);
          } catch (e) {
            Navigator.of(context).pop();
            print(e.toString());
            completer.complete(false);
          }
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        _contactController.text = phone;
        print(e.message!);
        completer.complete(false);
        Navigator.of(context).pop();
      },
      codeSent: (String verificationId, int? resendToken) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            timeouttimer = Timer(const Duration(seconds: 60), () {
              Navigator.of(context).pop();
              print("OTP timeout");
            });
            return AlertDialog(
              title: const Text('Enter OTP'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    String smsCode = _otpController.text.trim();
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId, smsCode: smsCode);
                    if (currentUser != null) {
                      timeouttimer?.cancel();
                      try {
                        await currentUser.unlink("phone");
                      } catch (e) {
                        print(e.toString());
                      }
                      try {
                        await currentUser.linkWithCredential(credential);
                        print("Phone number linked successfully!");
                        completer.complete(true);
                        Navigator.of(context).pop();
                      } catch (e) {
                        print(e.toString());
                        completer.complete(false);
                      }
                    }
                  },
                  child: const Text('Verify'),
                ),
              ],
            );
          },
        ).then((value) {
          timeouttimer?.cancel();
        });
      },
      timeout: const Duration(seconds: 90),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    setState(() {
      _isSendOtp = false;
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF68B1D0),
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20.0),
              const Text(
                'ID',
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: _idController,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Email',
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.none,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Batch',
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: _batchController,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Hostel',
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: _hostelController,
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Text(
                    'Contact',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  TextButton(
                      onPressed: () async {
                        if ((_contactController.text !=
                                    widget.profileData.contact ||
                                widget.profileData.contact == "") &&
                            verified == false) {
                          var result = await _sendOtp(_contactController.text);
                          if (result == false) {
                            _contactController.clear();
                          } else {
                            verified = true;
                          }
                          setState(() {});
                        }
                      },
                      child: (_contactController.text ==
                                  widget.profileData.contact ||
                              verified == true)
                          ? const Icon(Icons.verified, color: Colors.green)
                          : const Icon(Icons.info_outlined, color: Colors.red)),
                ],
              ),
              TextField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF68B1D0),
                )),
                onPressed: () {
                  if (verified == true ||
                      _contactController.text == widget.profileData.contact) {
                    saveDetails();
                    setState(() {
                      uploading = true;
                    });
                  }
                },
                child: const Text('Save'),
              ),
              Container(
                child: (uploading || _isSendOtp)
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox(height: 5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
