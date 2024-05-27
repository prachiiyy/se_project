import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'found.dart';
import 'lost.dart';

class lostandfoundPage extends StatefulWidget {
  const lostandfoundPage({Key? key}) : super(key: key);

  @override
  _lostandfoundPageState createState() => _lostandfoundPageState();
}

class _lostandfoundPageState extends State<lostandfoundPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://lnf.iiita.ac.in/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF68B1D0),
        title: const Text(
          'Lost And Found',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                'https://i0.wp.com/lost-found.org/wp-content/uploads/lost-and-found-service.png?resize=685%2C408&ssl=1'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF68B1D0),
                    )),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Lost()));
                    },
                    child: const Text(
                      'Lost',
                    )),
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFF68B1D0),
                  )),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Found()));
                  },
                  child: const Text(
                    'Found',
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
