import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/widgets/question.dart';

class LessonWidget extends StatefulWidget {
  final List<Map<String,dynamic>> questions;
  final DbHelper db;

  const LessonWidget({super.key, required this.questions, required this.db});

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  int _currentIndex = 0;  
  late final List<QuestionWidget> _questions;

  @override
  void initState() {
    super.initState();
    _questions = widget.questions.map((q) => QuestionWidget(
      topic: q['topic'],
      name: q['name'],
      difficulty: q['difficulty'],
      content: q['content'],
      answers: q['answers'],
      db: widget.db,
    )).toList();
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_questions[_currentIndex].topic),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: _questions[_currentIndex]),
            ElevatedButton(onPressed: _nextQuestion, 
              child: Text(_currentIndex < _questions.length - 1 ? 'Next' : 'Finish'),
            )
          ]
        )
      )
    );
  }
}