import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'pages/login.dart';
import 'session.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: FutureBuilder<bool>(
        future: Session.isLoggedIn(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (/*snapshot.data == */true) return Home();
          return Login();
        },
      ),
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => Login(),
      },
    );
  }
}