import 'package:flutter/material.dart';

class Learn extends StatefulWidget {
  const Learn({ super.key });

  @override
  LearnState createState() => LearnState();
}

class LearnState extends State<Learn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Learn Page")
    );
  }
}