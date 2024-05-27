import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Post extends StatefulWidget {
  String? uid;
  String? desc;
  List<dynamic>? likes;
  String? postid;
  DateTime? timestamp;
  String? attachment;
  Post({Key? key, this.uid, this.desc, this.likes, this.attachment, this.postid, this.timestamp}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  var userName = '';
  var userPhotoUrl = '';
  var time_stamp = '';
  TextEditingController postComment = TextEditingController();
  List<Widget> comments = [];
  bool isliked = false;
  bool loaded = false;
  bool attachment = false;
  bool showcomment = false;

  String formatTimeStamp(DateTime dt) {
    var timeStamp = '';
    DateTime current = DateTime.now();
    if (dt.day == current.day && dt.month == current.month) {
      int hourdif = current.hour - dt.hour;
      int mindif = current.minute - dt.minute;
      if (hourdif == 0) {
        timeStamp = '$mindif minutes ago';
      }else {
        timeStamp = '$hourdif hours ago';
      }
    }else {
      timeStamp = DateFormat.MMMd().format(dt);
    }
    return timeStamp;
  }

  void getUserData() async {
    final docRef = FirebaseFirestore.instance.collection("user").doc(widget.uid);
    await docRef.get().then((DocumentSnapshot doc) {
      final userdata = doc.data() as Map<String, dynamic>;
      userName = userdata['name'];
      userPhotoUrl = userdata['photourl'];
      setState(() {
        loaded = true;
      });
    },
        onError: (e) => print("Error getting document: $e")
    );
    setState(() {
      loaded = true;
    });
  }

  bool isLiked() {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    for (var element in widget.likes!) {
      if (element.toString() == uid) return true;
    }
    return false;
  }

  void like() {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    widget.likes?.add(uid!);
    FirebaseFirestore.instance.collection("feeds").doc(widget.postid).update({
      'likes': widget.likes,
    });
  }

  void unlike() {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    widget.likes?.remove(uid);
    FirebaseFirestore.instance.collection("feeds").doc(widget.postid).update({
      'likes': widget.likes,
    });
  }

  void getComments() async {
    final snapshot = await FirebaseFirestore.instance.collection("feeds").doc(widget.postid).collection("comments").get();

    if (snapshot.docs.isNotEmpty) {
      for (var document in snapshot.docs) {
        var timeString = formatTimeStamp((document['time'] as Timestamp).toDate());

        // Create a widget using the retrieved data
        Widget listItem = Comment(
          commentId: document['commentId'],
          desc: document['desc'],
          userName: document['userName'],
          userPhotoUrl: document['userPhotoUrl'],
          time: timeString,
        );

        // Add the widget to the list
        comments.add(listItem);
      }
    }
  }

  void addComment() async {
    if (postComment.text.trim() == "") {
      return;
    }
    var commentid = randomAlpha(20);
    final commentRef = FirebaseFirestore.instance.collection("feeds").doc(widget.postid).collection("comments");
    await commentRef.doc(commentid).set(<String, dynamic>{
      'commentId': commentid,
      'desc': postComment.text.trim(),
      'userName': FirebaseAuth.instance.currentUser?.displayName,
      'userPhotoUrl': FirebaseAuth.instance.currentUser?.photoURL,
      'time': Timestamp.now(),
    });
    setState(() {
      postComment.clear();
    });
  }

  @override
  void initState() {
    if (widget.attachment != '') {
      attachment = true;
    }
    time_stamp = formatTimeStamp(widget.timestamp!);
    isliked = isLiked();
    getComments();
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      return Container();
    }
    else {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 10,left: 10, right: 10),
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
              color: Color(0xFF68B1D0),
              width: 4,
            )
        ),
        color: Colors.white
      ),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                children: [
                  Image.network(
                    userPhotoUrl,
                    width: 30,
                    height: 30,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/avataricon.png',width: 30, height: 30,);
                    },
                  ),
                  const SizedBox(width: 10),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    time_stamp,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
                  )
                ],
              )
          ),
          const Divider(thickness: 2, color: Color(0xFF68B1D0)),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.desc!,
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
          ),
          const SizedBox(height: 5),
          Container(
            child: attachment
            ? Image.network(
              widget.attachment!,
              height: MediaQuery.of(context).size.width * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
            )
            : const SizedBox(height: 5),
          ),
          const SizedBox(height: 5),
          Container(
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (isliked) {
                          isliked = false;
                          unlike();
                        }else {
                          isliked = true;
                          like();
                        }
                      });
                    },
                    icon: isliked
                        ? const Icon(Icons.thumb_up, color: Colors.redAccent,)
                        : const Icon(Icons.thumb_up_off_alt)
                ),
                const SizedBox(width: 2),
                Text(widget.likes!.length.toString(), style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 10,),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (showcomment) {
                        showcomment = false;
                      } else {
                        showcomment = true;
                      }
                    });
                  },
                  icon: const Icon(Icons.comment, color: Color(0xFF68B1D0),),
                ),
                const SizedBox(width: 2),
                Text(comments.length.toString(), style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          showcomment
            ? Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
              child: Column(
                children: [
                  const Divider(thickness: 2, color: Colors.black,),
                  Column(
                    children: comments,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF68B1D0),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                              controller: postComment,
                              minLines: 1,
                              maxLines: 20,
                              maxLength: 200,
                              expands: false,
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Write comments...',
                                focusColor: Colors.blue,
                              ),
                            ),
                        ),
                        IconButton(
                            onPressed: addComment,
                            color: const Color(0xFF68B1D0),
                            icon: const Icon(Icons.send),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
            : const SizedBox(height: 1),
        ],
      ),
    );
    }
  }
}

class Comment extends StatefulWidget {
  String commentId;
  String desc;
  String userName;
  String userPhotoUrl;
  String time;
  Comment({Key? key,required this.commentId, required this.desc,required this.userName,required this.userPhotoUrl,required this.time}) : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                widget.userPhotoUrl,
                width: 30,
                height: 30,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/avataricon.png',width: 30, height: 30,);
                },
              ),
              const SizedBox(width: 10),
              Text(
                widget.userName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                widget.time,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                ),
              )
            ],
          ),
          const Divider(thickness: 2, indent: 40, endIndent: 20,),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.desc,
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
          ),
          const SizedBox(height: 5),
          const Divider(thickness: 2, color: Colors.black,),
          const SizedBox(height: 5,)
        ],
      )
    );
  }
}
