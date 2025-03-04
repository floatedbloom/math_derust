import 'package:flutter/material.dart';
import 'package:math_derust/widgets/question.dart';

class LessonWidget extends StatefulWidget {
  const LessonWidget({super.key});

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  int _currentIndex = 0;  
  final List<QuestionWidget> _questions = const[
    /*QuestionWidget(topic: topic, name: name, difficulty: difficulty, content: content, answers: answers, db: db),
    QuestionWidget(topic: topic, name: name, difficulty: difficulty, content: content, answers: answers, db: db),
    QuestionWidget(topic: topic, name: name, difficulty: difficulty, content: content, answers: answers, db: db),
    QuestionWidget(topic: topic, name: name, difficulty: difficulty, content: content, answers: answers, db: db),
    QuestionWidget(topic: topic, name: name, difficulty: difficulty, content: content, answers: answers, db: db)*/
  ];

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}