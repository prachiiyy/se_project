import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool image = false;
  String desc = '';
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  String postid = randomAlpha(15);
  List<dynamic> likes = [];
  File? imageFile;

  Future getImage() async {
    try {
      final attachment = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (attachment == null) {
        return;
      }
      final attachpath = File(attachment.path);
      setState(() {
        imageFile = attachpath;
        image = true;
      });
    } catch (e) {
      print('Not able to fetch image');
    }
  }

  void _addpost() async {
    var downloadURL = '';
    if (image) {
      final storage = FirebaseStorage.instance
          .ref()
          .child('feed_attachments')
          .child(postid);
      UploadTask uploadTask = storage.putFile(imageFile!);
      downloadURL = await (await uploadTask).ref.getDownloadURL();
    }
    FirebaseFirestore.instance.collection("feeds").doc(postid).set(<String, dynamic>{
      'uid': uid,
      'desc': desc.trim(),
      'postid': postid,
      'likes': likes,
      'url': downloadURL,
      'timestamp': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  getImage();
                },
                child: Container(
                  width: 200,
                  height: 200,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: image
                        ? Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: TextField(
                  expands: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Write Something...'
                  ),
                  onChanged: (text) {
                    desc = text;
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (desc.trim() != "") {
                      _addpost();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Post')
              )
            ],
          ),
        ),
      )
    );
  }
}
