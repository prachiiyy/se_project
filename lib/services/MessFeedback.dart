import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessFeedBackPage extends StatefulWidget {
  const MessFeedBackPage({Key? key}) : super(key: key);

  @override
  State<MessFeedBackPage> createState() => _MessFeedBackState();
}

class _MessFeedBackState extends State<MessFeedBackPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
            'https://docs.google.com/forms/d/e/1FAIpQLSeocOxRZHwbCoehtuiTEfiLKfZdXHuyM1jYzT8cLoOjPXn0bg/viewform'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF68B1D0),
          title: const Text('Mess Feedback'),
          centerTitle: true,
        ),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}
