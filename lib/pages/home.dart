import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import 'community.dart';
import 'learn.dart';
import 'mistakes.dart';
import 'profile.dart';
import 'quests.dart';

class Home extends StatefulWidget {
  const Home({ super.key });

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 2;

  static const List<Widget> _pages = [
    Quests(),
    Community(),
    Profile(),
    Learn(),
    Mistakes(),
  ];

  void _onElementTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Math Derust', style: TextStyle(
          fontSize: 44,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 173, 151, 103),
          shadows: [
            Shadow(
              offset: Offset(2, 2),
              blurRadius: 1,
              color: Colors.grey,
            ),
          ],),
        )),
        elevation: 0,
        scrolledUnderElevation: 0.0,
        backgroundColor: Color(0xFF121212),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: badges.Badge(
                  badgeContent: Text('3', style: TextStyle(color: Color.fromARGB(255, 160, 15, 15))),
                  child: Icon(Icons.brightness_7_sharp),), 
                label: "Quests"),
              BottomNavigationBarItem(
                icon: badges.Badge(
                  badgeContent: Text('3', style: TextStyle(color: Color.fromRGBO(160, 15, 15, 1))),
                  child: Icon(Icons.diversity_3_rounded),), 
                label: "Community"),
              BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions_rounded), label: "Profile"),
              BottomNavigationBarItem(icon: Icon(Icons.local_library_rounded), label: "Learn"),
              BottomNavigationBarItem(
                icon: badges.Badge(
                  badgeContent: Text('3', style: TextStyle(color: Color.fromARGB(255, 160, 15, 15))),
                  child: Icon(Icons.redo_rounded),), 
                label: "Mistakes"),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.indigoAccent,
            unselectedItemColor: Colors.grey,
            backgroundColor: const Color.fromARGB(255, 18, 18, 18),
            onTap: _onElementTap,
          ),
      ),
    );
  }
}