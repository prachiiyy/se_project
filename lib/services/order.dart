import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class order extends StatefulWidget {
  const order({Key? key}) : super(key: key);

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> {
  bool button = false;
  String platform = '';
  String restro = '';
  String date = '';
  int itemcnt = 0;
  int fare = 0;
  String name = '';
  String contact = '';
  bool show = false;

  uploadImage() async {
    FirebaseFirestore.instance.collection('order').add({
      'platform': platform,
      'restro': restro,
      'date': date,
      'itemcnt': itemcnt,
      'fare': fare,
      'name': name,
      'contact': contact,
    });
    Navigator.of(context).pop();
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
        leading: BackButton(
            onPressed : (){
              Navigator.pop(context);
            }
        ),
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
          'Food Order',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  platform = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Platform',
                  border: UnderlineInputBorder(),
                ),
              ),
              TextField(
                onChanged: (value) {
                  restro = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Restaurant',
                  border: UnderlineInputBorder(),
                ),
              ),
              TextField(
                onChanged: (value) {
                  date = value;
                },
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Date of Order(dd/mm/yyyy)',
                  border: UnderlineInputBorder(),
                ),
              ),
              TextField(
                onChanged: (value) {
                  itemcnt = int.parse(value);
                },
                keyboardType: TextInputType.number,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Items Bought till now',
                  border: UnderlineInputBorder(),
                ),
              ),
              TextField(
                onChanged: (value) {
                  fare = int.parse(value);
                },
                keyboardType: TextInputType.number,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Bill Amount',
                  border: UnderlineInputBorder(),
                ),
              ),
              TextField(
                onChanged: (value) {
                  name = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: UnderlineInputBorder(),
                ),
              ),
              TextField(
                onChanged: (value) {
                  contact = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Contact no.',
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
