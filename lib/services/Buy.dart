import 'package:flutter/material.dart';
import 'package:helpmeout/services/Books.dart';
import 'package:helpmeout/services/furniture.dart';
import 'package:helpmeout/services/stationary.dart';
import 'vehicle.dart';
import 'Others.dart';
import 'Electronics.dart';
import 'package:helpmeout/services/sell.dart';

class Buy extends StatefulWidget {
  const Buy({Key? key}) : super(key: key);

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy & Sell'),
        centerTitle: true,
        backgroundColor: const Color(0xFF68B1D0),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(15.0),
        child:
        Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'CATEGORIES',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 40),
              Expanded(
                  child: GridView.count(
                childAspectRatio: (1 / 1),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Electronics()));
                    },
                    child: Container(
                      height: 200,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          'assets/electronics.jpg',
                        ),
                      )),
                      child: const Text(
                        'ELECTRONICS',
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const furniture()));
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          'assets/furniture.jpg',
                        ),
                      )),
                      child: const Text(
                        'FURNITURE',
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Stationary()));
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          'assets/stationary.jpg',
                        ),
                      )),
                      child: const Text(
                        'STATIONARY',
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Books()));
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          'assets/books.jpg',
                        ),
                      )),
                      child: const Text(
                        'BOOKS',
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Vehicle()));
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          'assets/vehicles.png',
                        ),
                      )),
                      child: const Text(
                        'VEHICLE',
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Others()));
                    },
                    child: Container(

                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          'assets/others.jpg',
                        ),
                      )),
                      child: const Text(
                        'OTHERS',
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17),
                      ),
                    ),
                  ),
                ],
              )),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: const Color(0xFF68B1D0),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const sell()));
          }, child:
      const Text('+',style: TextStyle(fontSize: 30))
      ),
    );
  }
}
