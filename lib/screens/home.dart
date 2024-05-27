import 'package:flutter/material.dart';
import 'package:helpmeout/main.dart';
import 'package:helpmeout/services/Buy.dart';
import 'package:helpmeout/services/MessFeedback.dart';
import 'package:helpmeout/services/carpooling.dart';
import 'package:helpmeout/services/lostnfound.dart';
import 'package:helpmeout/services/foodordering.dart';
import 'package:helpmeout/services/recources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/services.dart';
import 'feedback.dart';
import 'contact_us.dart';
import 'package:helpmeout/components/searchitem.dart';
import 'package:helpmeout/screens/home.dart'; // Import the Home screen


class Home_Page extends StatefulWidget {
  const Home_Page({
    Key? key,
  }) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class ServiceIcon {
  final String title;
  final Image icon;
  final Color color;
  final StatefulWidget page;
  ServiceIcon(this.title, this.icon, this.color, this.page);
}

class _Home_PageState extends State<Home_Page> {
  String? getDetails() {
    if (FirebaseAuth.instance.currentUser?.email != null) {
      return FirebaseAuth.instance.currentUser?.email;
    return null;
    }
    return null;
  }

  String? name = FirebaseAuth.instance.currentUser?.displayName;
  List<ServiceIcon> serviceicons = <ServiceIcon>[
    ServiceIcon('Car Pooling', const Image(image: AssetImage('assets/vehicle.png'), width: 34, height: 34), Colors.cyan[200]!,
        const CarPoolingPage()),
    ServiceIcon('Lost & Found', const Image(image: AssetImage('assets/lost-and-found.png'), width: 34, height: 34), Colors.indigo[200]!,
        const lostandfoundPage()),
    ServiceIcon('Resources', const Image(image: AssetImage('assets/digital-library.png'), width: 34, height: 34), Colors.yellow[200]!,
        const RecourcesPage()),
    ServiceIcon('Food Order', const Image(image: AssetImage('assets/delivery-man.png'), width: 34, height: 34), Colors.green[200]!,
        const FoodorderingPage()),
    ServiceIcon('Mess Review', const Image(image: AssetImage('assets/good-review.png'), width: 34, height: 34), Colors.redAccent,
        const MessFeedBackPage()),
    ServiceIcon('Buy & Sell', const Image(image: AssetImage('assets/buy.png'), width: 34, height: 34), Colors.purple[200]!,
        const Buy()),
  ];

  void showBottomModalSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedbackScreen()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFF68B1D0),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: const Text(
                    "FeedBack",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUsPage()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color(0xFF68B1D0),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: const Text(
                    "Contact Us",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  Service service = Service();
                  await service.signOut();
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (BuildContext context) => const Gsign()),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color(0xFF68B1D0),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: const Text(
                    "LogOut",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  bool search = false;

  static List<SearchItem> keys = [
    SearchItem("car", const CarPoolingPage()),
    SearchItem("pool", const CarPoolingPage()),
    SearchItem("car pool", const CarPoolingPage()),
    SearchItem("lost", const lostandfoundPage()),
    SearchItem("found", const lostandfoundPage()),
    SearchItem("resource", const RecourcesPage()),
    SearchItem("notes", const RecourcesPage()),
    SearchItem("food", const FoodorderingPage()),
    SearchItem("food order", const FoodorderingPage()),
    SearchItem("mess", const MessFeedBackPage()),
    SearchItem("mess review", const MessFeedBackPage()),
    SearchItem("mess feedback", const MessFeedBackPage()),
  ];

  List<SearchItem> display_list = [];

  void updateList(String value) {
    setState(() {
      if (value == "") {
        search = false;
        display_list.clear();
      } else {
        search = true;
        display_list = keys.where((element) => element.key.toLowerCase().contains(value.toLowerCase())).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
              padding:
                  const EdgeInsets.only(top: 35, left: 15, right: 15, bottom: 10),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Color(0xFF68B1D0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hello User',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: showBottomModalSheet,
                            child: const Icon(
                              Icons.settings,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {

                            },
                            child: const Icon(
                              Icons.notifications,
                              size: 30,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      onTapOutside: (e) => FocusManager.instance.primaryFocus?.unfocus(),
                      onChanged: (value) => updateList(value),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        prefixIcon: const Icon(Icons.search, size: 24),
                      ),
                    ),
                  )
                ],
              )),
          Expanded(
            child : search
            ? ListView.builder(
                itemCount: display_list.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => display_list[index].path));
                  },
                  title: Text(
                    display_list[index].key,
                    style: const TextStyle(
                      color: Color(0xFF68B1D0),
                      fontSize: 24,
                    ),
                  ),
                  leading: const Icon(Icons.arrow_forward),
                  tileColor: Colors.white,
                ),
              )
            : SingleChildScrollView(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child:  Column(
                children: [
                  Image.asset(
                    'assets/face.gif',
                    height: MediaQuery.of(context).size.width * 0.8,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Services',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: serviceicons.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => serviceicons[index].page
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: serviceicons[index].color,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: serviceicons[index].icon,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              serviceicons[index].title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
