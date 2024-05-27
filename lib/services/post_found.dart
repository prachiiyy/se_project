import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import 'package:hexcolor/hexcolor.dart';

class Post_found extends StatefulWidget {
  const Post_found({Key? key}) : super(key: key);

  @override
  State<Post_found> createState() => _Post_foundState();
}

class _Post_foundState extends State<Post_found> {
  bool button = false;
  String description = '';
  String name = '';
  String number = '';
  String item = '';
  String date = '';
  File? sel_image;
  bool show = false;
  Future getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final ima = File(image.path);
      setState(() {
        sel_image = ima;
      });
    } catch (e) {
      print('Not able to fetch image');
    }
  }

  uploadImage() async {
    if (sel_image != null) {
      setState(() {
        show = true;
      });
      final storage = FirebaseStorage.instance
          .ref()
          .child('foundimages')
          .child('${randomAlpha(9)}.jpg');
      final UploadTask task = storage.putFile(sel_image!);
      var downloadURL = await (await task).ref.getDownloadURL();
      FirebaseFirestore.instance.collection('found').add({
        'name': name,
        'contact': number,
        'description': description,
        'url': downloadURL,
        'itemname': item,
        'date': date,
      });
      Navigator.pop(context);
    } else {
      print('No path received');
    }
  }

  @override
  Widget build(BuildContext context) {
    return show
        ? Container(
            child: const Center(
            child: SizedBox(
                width: 30, height: 30, child: CircularProgressIndicator()),
          ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor('0047AB'),
              actions: [
                IconButton(
                    onPressed: () {
                      uploadImage();
                    },
                    icon: const Icon(
                      Icons.upload,
                    ))
              ],
              centerTitle: true,
              title: const Text(
                'Post Found Items',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          getImage();
                          button = true;
                        },
                        child: button
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  sel_image!,
                                  height: 300,
                                  width: 400,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                height: 300,
                                width: 450,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.black,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                ),
                              )),
                    TextField(
                      onChanged: (value) {
                        item = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Item name',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Founder Name',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        number = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Founder Contact number',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        description = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        date = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Date when item was found',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
