import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpmeout/services/itemdesc.dart';

class Others extends StatefulWidget {
  const Others({Key? key}) : super(key: key);

  @override
  State<Others> createState() => _OthersState();
}

class _OthersState extends State<Others> {
  String description = '';
  String name = '';
  String number = '';
  String link = ' ';
  String item = '';
  String price = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF68B1D0),
        title: const Text(
          'OTHER ITEMS',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
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
                  price = data['price'];
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
                          price: snapshot.data?.docs[index]['price'],
                        );
                      }),
                );
              }

              return const Column(
                children: [Text('Yo')],
              );
            },
            stream: FirebaseFirestore.instance.collection('Others').snapshots(),
          ),
        ],
      ),
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
    required this.price,
  }) : super(key: key);

  final String link;
  final String name;
  final String number;
  final String description;
  final String item;
  final String price;
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
                          builder: (context) => ItemDesc(
                              name, number, link, description, item, price)));
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
                          // width: 300,
                          height: 250,
                          fit: BoxFit.fill),
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
