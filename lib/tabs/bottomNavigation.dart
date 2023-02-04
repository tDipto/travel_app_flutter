import 'package:flutter/material.dart';
import 'package:travel_app/tabs/bottomPages/addPlace.dart';
import 'package:travel_app/tabs/bottomPages/divisionPage.dart';
import 'package:travel_app/tabs/bottomPages/homePage.dart';
import 'package:travel_app/tabs/bottomPages/profilePage.dart';

import 'bottomPages/maindivision.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final _pages = [
    HomePage(),
    MainDivisionPage(),
    AddPlace(),
    const ProfilePage(),
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        // ignore: prefer_const_constructors
        title: Text(
          "ট্রাভেল গাইড",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: Colors.greenAccent,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "হোম ",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_location_rounded), label: "বিভাগ"),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_sharp),
            label: "সংযুক্ত করুন ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "প্রোফাইল ",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // print(_currentIndex);
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
