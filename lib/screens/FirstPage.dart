import 'package:flutter/material.dart';
import 'feed.dart';
import 'home.dart';
import 'profile.dart';
import 'package:helpmeout/chat/chat_home_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HelpMeOut',
      home: const Display(),
      theme: ThemeData(
        primaryColor: const Color(0xFF68B1D0),
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  int selectedIndex = 0;

  final screenOptions = [
    const Home_Page(),
    const Feed_Page(),
    Chat_HomePage(),
    const Profile(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenOptions.elementAt(selectedIndex),
      backgroundColor: const Color(0xFFE4F4FD),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        elevation: 5,
        iconSize: 30,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFF68B1D0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Feed',
            backgroundColor: Color(0xFF68B1D0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
            backgroundColor: Color(0xFF68B1D0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Color(0xFF68B1D0),
          )
        ],
      ),
    );
  }
}
