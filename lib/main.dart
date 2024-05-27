import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpmeout/screens/FirstPage.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:helpmeout/screens/home.dart'; // Import the Home screen


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the Home screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => home()),
            );
          },
          child: const Text('Go to Home Screen'),
        ),
      ),
    );
  }
}