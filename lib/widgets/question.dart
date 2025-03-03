import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/session.dart';
import 'package:rive/rive.dart';

class QuestionWidget extends StatelessWidget {
  final String topic;
  final String name;
  final int difficulty;
  final String content;
  final String answers;
  final DbHelper db;

  const QuestionWidget({
    super.key,
    required this.topic,
    required this.name,
    required this.difficulty,
    required this.content,
    required this.answers,
    required this.db,
  });

  void _showQuestion(BuildContext context, String topic, String name, String content, List<String> answers) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text(name),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(content, style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Column(
                  children: answers.map((answer) => Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        bool isCorrect = await db.checkAnswer(name, answer,topic);
                        if (isCorrect) {
                          await db.updateUserQuestProgress(Session.instance.currentUserId ?? 0, 1, 1);
                          int questionId = await db.getQuestionIdByNameAndCategory(name, topic) ?? 0;
                          await db.broDidntMessUp(questionId, topic, Session.instance.currentUserId ?? 0);
                        }
                        await _showResultAnimation(context,isCorrect);
                        //Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 27, 50, 56),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Answer: $answer", style: TextStyle(fontWeight: FontWeight.bold))
                    ),
                  )).toList(),
                )
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Close")),
        ],
      ),
    );
  }

  Future<void> _showResultAnimation(BuildContext context, bool isCorrect) async {
    late BuildContext dialogContext; 

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        dialogContext = ctx;
        return AlertDialog(
          backgroundColor: Color.fromARGB(255,18,18,18),
          content: SizedBox(
            width: 400,
            height: 400,
            child: RiveAnimation.asset(
              isCorrect ? 'assets/checkmark_icon.riv' : 'assets/error_icon.riv',
            ),
          ),
        );
      },
    );

    await Future.delayed(Duration(milliseconds: 1500));

    if (Navigator.canPop(dialogContext)) {
      Navigator.pop(dialogContext);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> answersSplit = answers.split(';');
    return GestureDetector(
      onTap: () => _showQuestion(context, topic, name, content, answersSplit),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(8.0),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("Difficulty: $difficulty", style: TextStyle(fontSize: 14, color: Colors.grey)),
              SizedBox(height: 5),
              Text(content, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}