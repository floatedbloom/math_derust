import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/widgets/lesson.dart';

class TreeNode extends StatelessWidget {
  final String topic;
  final List<TreeNode> children;
  final List<Map<String,dynamic>> questions;
  final DbHelper db;

  const TreeNode({super.key,required this.topic, this.children = const [], this.questions = const [], required this.db});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            if (children.isEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LessonWidget(
                    questions: questions,
                    db: db
                  )
                )
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Hi"))
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey[800],
            foregroundColor: Colors.white,
          ),
          child: Text(topic),
        ),
        if (children.isNotEmpty)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: children.map((child) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: child,
              );
            }).toList(),
          ),
      ],
    );
  }
}