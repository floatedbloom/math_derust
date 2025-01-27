import 'package:flutter/material.dart';

class Quests extends StatefulWidget {
  const Quests({ super.key });

  @override
  QuestsState createState() => QuestsState();
}

class QuestsState extends State<Quests> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Quests Page")
    );
  }
}