import 'package:flutter/material.dart';

class Mistakes extends StatefulWidget {
  const Mistakes({ super.key });

  @override
  MistakesState createState() => MistakesState();
}

class MistakesState extends State<Mistakes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Mistakes Page")
    );
  }
}