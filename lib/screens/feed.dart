import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpmeout/components/post.dart';
import 'package:helpmeout/screens/addpost.dart';

class Feed_Page extends StatefulWidget {
  const Feed_Page({Key? key}) : super(key: key);

  @override
  State<Feed_Page> createState() => _Feed_PageState();
}

class _Feed_PageState extends State<Feed_Page> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 35, left: 15, right: 15, bottom: 15),
                height: 80,
                color: const Color(0xFF68B1D0),
                child: const Row(
                  children: [
                    Text(
                      'Feed',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Feed(),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(right: 10, bottom: 10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPost()));
                },
                backgroundColor: const Color(0xFF68B1D0),
                child: const Icon(Icons.add),
              )
            )
          )
        ],
      )
    );
  }
}

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  Stream<QuerySnapshot> feedref = FirebaseFirestore.instance.collection("feeds").orderBy("timestamp",descending: true).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: feedref,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }else if (snapshot.connectionState == ConnectionState.active
                || snapshot.connectionState == ConnectionState.done) {

          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            List<Widget> feedlist = snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

              return Post(
                uid: data['uid'],
                desc: data['desc'],
                likes: data['likes'] as List<dynamic>,
                attachment: data['url'],
                postid: data['postid'],
                timestamp: (data['timestamp'] as Timestamp).toDate(),
              );
            }).toList();
            return Column(children: feedlist);
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
}


