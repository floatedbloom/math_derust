import 'package:flutter/material.dart';
import 'package:math_derust/widgets/lesson.dart';
import 'package:math_derust/widgets/question.dart';

class TreeNode extends StatelessWidget {
  final LessonWidget lesson;
  final String text;
  final List<TreeNode> children;

  const TreeNode({super.key,required this.lesson, required this.text, this.children = const []});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("$text clicked")),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey[800],
            foregroundColor: Colors.white,
          ),
          child: Text(text),
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