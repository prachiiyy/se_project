import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class pool extends StatefulWidget {
  const pool({Key? key}) : super(key: key);

  @override
  State<pool> createState() => _poolState();
}

class _poolState extends State<pool> {
  bool button = false;
  String source = '';
  String destination = '';
  String type = '';
  String Date = '';
  String Time = '';
  int fare = 0;
  String contact = '';
  bool show = false;

  uploadRequest() async {
      await FirebaseFirestore.instance.collection('pool').add({
        'source': source,
        'destination': destination,
        'type': type,
        'date': Date,
        'time': Time,
        'fare': fare,
        'name': FirebaseAuth.instance.currentUser!.displayName!,
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
                uploadRequest();
              },
              icon: const Icon(
                Icons.upload,
              ))
        ],
        centerTitle: true,
        title: const Text(
          'Pool request',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  source = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Source',
                  border: UnderlineInputBorder(),
                ),
              ),
              TextField(
                onChanged: (value) {
                  destination = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Destination',
                  border: UnderlineInputBorder(),
                ),
              ),
              TextField(
                onChanged: (value) {
                  type = value;
                },
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Type of Vehicle',
                  border: UnderlineInputBorder(),
                ),
              ),
              TextField(
                onChanged: (value) {
                  Date = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Date of travel(dd/mm/yyyy)',
                  border: UnderlineInputBorder(),
                ),
              ),
              TextField(
                onChanged: (value) {
                  Time = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Time of Journey(24 hrs format)',
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
                  hintText: 'Fare per head',
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
