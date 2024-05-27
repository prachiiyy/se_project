import 'package:flutter/material.dart';

import 'post_lost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'show.dart';

class Lost extends StatefulWidget {
  const Lost({super.key});

  @override
  State<Lost> createState() => _LostState();
}

class _LostState extends State<Lost> {
  String description = '';
  String name = '';
  String number = '';
  String link = ' ';
  String item = '';
  String date = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF68B1D0),
        title: const Text(
          'Lost Items',
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder<QuerySnapshot>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final datas = snapshot.data?.docs;
                for (var data in datas!) {
                  description = data['description'];
                  name = data['name'];
                  number = data['contact'];
                  link = data['url'];
                  item = data['itemname'];
                  date = data['date'];
                  print(link);
                }
                return Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        print('#@@');
                        print(snapshot.data?.docs[index]['url']);
                        return func(
                          link: snapshot.data?.docs[index]['url'],
                          name: snapshot.data?.docs[index]['name'],
                          number: snapshot.data?.docs[index]['contact'],
                          description: snapshot.data?.docs[index]
                              ['description'],
                          item: snapshot.data?.docs[index]['itemname'],
                          date: snapshot.data?.docs[index]['date'],
                        );
                      }),
                );
              }
              return const Column();
            },
            stream: FirebaseFirestore.instance.collection('lost').snapshots(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF68B1D0),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Post_lost()));
          },
          child: const Text('+', style: TextStyle(fontSize: 30))),
    );
  }
}

class func extends StatelessWidget {
  const func({
    Key? key,
    required this.link,
    required this.name,
    required this.number,
    required this.description,
    required this.item,
    required this.date,
  }) : super(key: key);

  final String link;
  final String name;
  final String number;
  final String description;
  final String item;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Show(name, number, link,
                              description, item, date, false)));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: Image.network(link,
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          fit: BoxFit.cover),
                    ),
                    ListTile(
                      title: Center(
                          child: Text(
                        item,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
