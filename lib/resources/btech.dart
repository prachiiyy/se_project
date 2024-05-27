import 'package:flutter/material.dart';
import 'package:helpmeout/resources/courselist.dart';
import 'package:helpmeout/components/Course.dart';

class BTech extends StatelessWidget {
  List<Course> Sem1 = [
    Course(title: 'Physics', respath: 'resources/sem1/physics'),
    Course(title: 'Linear Algebra', respath: 'resources/sem1/lal'),
    Course(title: 'Introduction to Programming', respath: 'resources/sem1/itp'),
    Course(title: 'FEE', respath: 'resources/sem1/fee'),
    Course(title: 'Professional Communication', respath: 'resources/sem1/pfc'),
    Course(title: 'Principles of Management', respath: 'resources/sem1/pom'),
  ];

  List<Course> Sem4 = [
    Course(
        title: 'Priciples of Programming Language',
        respath: 'resources/sem4/ppl'),
    Course(title: 'Computer Networks', respath: 'resources/sem4/cn'),
    Course(
        title: 'Database Management Systems', respath: 'resources/sem1/dbms'),
    Course(
        title: 'Design and Analysis of Algorithms',
        respath: 'resources/sem1/daa'),
    Course(title: 'Software Engineering', respath: 'resources/sem1/se'),
  ];

  BTech({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF68B1D0),
        title: const Text('Resources'),
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
                      builder: (context) => Courses(courselist: Sem1),
                    ),
                  );
                },
                child: const Text('sem 1'),
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
                      builder: (context) => const Sem2(),
                    ),
                  );
                },
                child: const Text('sem 2'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color(0xFF68B1D0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Sem3(),
                    ),
                  );
                },
                child: const Text('sem 3'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color(0xFF68B1D0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Courses(courselist: Sem4),
                    ),
                  );
                },
                child: const Text('Sem 4'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color(0xFF68B1D0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Sem5(),
                    ),
                  );
                },
                child: const Text('sem 5'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color(0xFF68B1D0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Sem6(),
                    ),
                  );
                },
                child: const Text('sem 6'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color(0xFF68B1D0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Sem7(),
                    ),
                  );
                },
                child: const Text('sem 7'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color(0xFF68B1D0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Sem8(),
                    ),
                  );
                },
                child: const Text('sem 8'),
              ),
              const SizedBox(height: 16.0),
              // Add spacing between buttons
              // Add more buttons as needed
            ],
          ),
        ),
      ),
    );
  }
}

class Sem2 extends StatelessWidget {
  const Sem2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semester 2'),
      ),
      body: const Center(
        child: Text('OOPS! Nothing is found :('),
      ),
    );
  }
}

class Sem3 extends StatelessWidget {
  const Sem3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semester 3'),
      ),
      body: const Center(
        child: Text('OOPS! Nothing is found :('),
      ),
    );
  }
}

class Sem4 extends StatelessWidget {
  const Sem4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semester 4'),
      ),
      body: const Center(
        child: Text('OOPS! Nothing is found :('),
      ),
    );
  }
}

class Sem5 extends StatelessWidget {
  const Sem5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semester 5'),
      ),
      body: const Center(
        child: Text('OOPS! Nothing is found :('),
      ),
    );
  }
}

class Sem6 extends StatelessWidget {
  const Sem6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semester 6'),
      ),
      body: const Center(
        child: Text('OOPS! Nothing is found :('),
      ),
    );
  }
}

class Sem7 extends StatelessWidget {
  const Sem7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semester 7'),
      ),
      body: const Center(
        child: Text('OOPS! Nothing is found :('),
      ),
    );
  }
}

class Sem8 extends StatelessWidget {
  const Sem8({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semester 8'),
      ),
      body: const Center(
        child: Text('OOPS! Nothing is found :('),
      ),
    );
  }
}
