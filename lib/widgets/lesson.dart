import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/session.dart';
import 'package:math_derust/widgets/question.dart';

class LessonWidget extends StatefulWidget {
  final List<Map<String,dynamic>> questions;
  final DbHelper db;
  final String? topic; // Topic for quest tracking

  const LessonWidget({
    super.key, 
    required this.questions, 
    required this.db,
    this.topic,
  });

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

  Future<void> _onLessonComplete() async {
    final userId = Session.instance.currentUserId;
    if (userId == null) return;
    
    // Update general lesson completion quests
    await widget.db.updateQuestsByCondition(userId, 'lesson_complete');
    
    // Update subject-specific quests based on topic
    final topic = widget.topic ?? (widget.questions.isNotEmpty ? widget.questions.first['topic'] : null);
    if (topic != null) {
      switch (topic.toLowerCase()) {
        case 'algebra':
          await widget.db.updateQuestsByCondition(userId, 'algebra_lesson');
          break;
        case 'geometry':
          await widget.db.updateQuestsByCondition(userId, 'geometry_lesson');
          break;
        case 'trigonometry':
          await widget.db.updateQuestsByCondition(userId, 'trig_lesson');
          break;
        case 'intermediate algebra':
          await widget.db.updateQuestsByCondition(userId, 'intalg_lesson');
          break;
      }
    }
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      // Lesson completed - track quest progress
      _onLessonComplete();
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