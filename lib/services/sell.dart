import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:hexcolor/hexcolor.dart';

class sell extends StatefulWidget {
  const sell({Key? key}) : super(key: key);

  @override
  State<sell> createState() => _sellState();
}

class _sellState extends State<sell> {
  String dropdownvalue = 'Electronics';
  String category = '';
  var items = [
    'Electronics',
    'Furniture',
    'Books',
    'Stationary',
    'Vehicles',
    'Others'
  ];
  bool button = false;
  String description = '';
  String name = '';
  String number = '';
  String item = '';
  String price = '';
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
          .child('images')
          .child('${randomAlpha(9)}.jpg');
      final UploadTask task = storage.putFile(sel_image!);
      var downloadURL = await (await task).ref.getDownloadURL();
      FirebaseFirestore.instance.collection(category).add({
        'name': name,
        'contact': number,
        'description': description,
        'url': downloadURL,
        'itemname': item,
        'price': price,
      });
      Navigator.of(context).pop();
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
                    width: 30, height: 30, child: CircularProgressIndicator())))
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
                'Sell Item',
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
                    Column(
                      children: [
                        const Text('Select Category'),
                        DropdownButton(
                          // Initial Value
                          value: dropdownvalue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                              category = newValue;
                            });
                          },
                        ),
                      ],
                    ),
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
                        hintText: 'Owner Name',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        number = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Owner Contact number',
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
                        price = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Selling price',
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
