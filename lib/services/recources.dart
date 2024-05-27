import 'package:flutter/material.dart';
import 'package:helpmeout/resources/btech.dart';

class RecourcesPage extends StatefulWidget {
  const RecourcesPage({Key? key}) : super(key: key);

  @override
  State<RecourcesPage> createState() => _RecourcesPageState();
}

class _RecourcesPageState extends State<RecourcesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF68B1D0),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Hello User'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Add padding around buttons
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color(0xFF68B1D0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BTech(),
                    ),
                  );
                },
                child: const Text('B.Tech'),
              ),
              const SizedBox(height: 16.0), // Add spacing between buttons
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color(0xFF68B1D0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MTech(),
                    ),
                  );
                },
                child: const Text('M.Tech'),
              ),
              const SizedBox(height: 16.0), // Add spacing between buttons
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF68B1D0),
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MBA(),
                    ),
                  );
                },
                child: const Text('MBA'),
              ),
              const SizedBox(height: 16.0), // Add spacing between buttons
              // Add more buttons as needed
            ],
          ),
        ),
      ),
    );
  }
}

class MTech extends StatelessWidget {
  const MTech({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M.Tech'),
        backgroundColor: const Color(0xFF68B1D0),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('OOPS! Nothing is found :('),
      ),
    );
  }
}

class MBA extends StatelessWidget {
  const MBA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MBA'),
        backgroundColor: const Color(0xFF68B1D0),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('OOPS! Nothing is found :('),
      ),
    );
  }
}
