import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpmeout/models/ChatRoomModel.dart';
import 'package:helpmeout/models/FirebaseHelper.dart';
import 'package:helpmeout/models/Usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpmeout/chat/chat_room_page.dart';
import 'package:helpmeout/chat/chat_search_page.dart';

class Chat_HomePage extends StatefulWidget {
  final User firebaseuser = FirebaseAuth.instance.currentUser!;
  final UserModel userModel = UserModel(
    uid: FirebaseAuth.instance.currentUser?.uid,
    username: FirebaseAuth.instance.currentUser?.displayName,
    email: FirebaseAuth.instance.currentUser?.email,
    profilepic: FirebaseAuth.instance.currentUser?.photoURL,
  );

  Chat_HomePage({Key? key}) : super(key: key);

  @override
  State<Chat_HomePage> createState() => _Chat_HomePageState();
}

class _Chat_HomePageState extends State<Chat_HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
        backgroundColor: const Color(0xFF68B1D0),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("chatrooms")
                .where("participants.${widget.userModel.uid}", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot chatRoomSnapshot =
                      snapshot.data as QuerySnapshot;

                  return ListView.builder(
                    itemCount: chatRoomSnapshot.docs.length,
                    itemBuilder: (context, index) {
                      ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                          chatRoomSnapshot.docs[index].data()
                              as Map<String, dynamic>);

                      Map<String, dynamic>? participants =
                          chatRoomModel.participants;

                      List<String> participantkeys =
                          participants!.keys.toList();
                      participantkeys.remove(widget.userModel.uid);
                      print(participantkeys[0]);
                      print(widget.userModel.username);

                      return FutureBuilder(
                        future:
                            FirebaseHelper.getUserModelById(participantkeys[0]),
                        builder: (context, userData) {
                          if (userData.connectionState ==
                              ConnectionState.done) {
                            if (userData.data != null) {
                              UserModel targetUser = userData.data as UserModel;

                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return Chat_Room_Page(
                                          targetUser: targetUser,
                                          chatroom: chatRoomModel,
                                          userModel: widget.userModel,
                                          firabaseUser: widget.firebaseuser);
                                    }),
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(targetUser.profilepic!),
                                ),
                                title: Text(targetUser.username.toString()),
                                subtitle: (chatRoomModel.lastMessage
                                            .toString() !=
                                        "")
                                    ? Text(chatRoomModel.lastMessage.toString())
                                    : Text(
                                        "Say Hello :)",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                              );
                            } else {
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: Text("No Previous Chats"),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Chat_searchPage(
                userModel: widget.userModel, firebaseuser: widget.firebaseuser);
          }));
        },
        backgroundColor: const Color(0xFF68B1D0),
        child: const Icon(Icons.search),
      ),
    );
  }
}
