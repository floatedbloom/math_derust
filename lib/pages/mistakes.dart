import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/session.dart';
import 'package:rive/rive.dart';

class Mistakes extends StatefulWidget {
  const Mistakes({ super.key });

  @override
  MistakesState createState() => MistakesState();
}

class MistakesState extends State<Mistakes> {
  DbHelper db = DbHelper.instance;
  List<Map<String,dynamic>> mistakes = [];

  @override
  void initState() {
    super.initState();
    _loadMistakes();
  }

  Future<void> _loadMistakes() async {
    DbHelper db = DbHelper.instance;
    List<Map<String, dynamic>> fetchedMistakes = await db.queryUserMistakes(Session.instance.currentUsername ?? 'User Not Found');
    setState(() {
      mistakes = fetchedMistakes;
    });
  }

  void _showQuestion(String name, String content, List<String> answers, String category) {
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
                        int questionId = await db.getQuestionIdByNameAndCategory(name, category) ?? 0;
                        print(category);
                        bool isCorrect = await db.checkAnswer(name, answer, category);
                        print(answer);
                        print(isCorrect);
                        if (isCorrect) {
                          await db.removeMistake(Session.instance.currentUserId ?? 0, questionId);
                          await db.updateUserQuestProgress(Session.instance.currentUserId ?? 0, 2, 1);
                          await _loadMistakes();
                        }
                        _showResultAnimation(isCorrect);
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

  void _showResultAnimation(bool isCorrect) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          width: 150,
          height: 150,
          child: RiveAnimation.asset(
            isCorrect ? 'assets/checkmark_icon.riv' : 'assets/error_icon.riv',
          ),
        ),
      ),
    );

    // Close the animation dialog after 1.5 seconds
    Future.delayed(Duration(milliseconds: 1500), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15),
            Text("M I S T A K E S", style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0,
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                  )
                ]
              ),),
            SizedBox(height: 20),
            mistakes.isEmpty ? 
                Center(
                  child: Text(
                    "No Mistakes To Fix",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 120, 120, 120),
                    ),
                  )
                )
            : ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 900),
              child: SingleChildScrollView(
                child: Column(
                  children: mistakes.map((mistake) {
                    String name = mistake['name'] ?? '';
                    String category = mistake['category'] ?? "";
                    int difficulty = mistake['difficulty'] ?? "";
                    String content = mistake['content'] ?? "";
                    String answers = mistake['answers'] ?? "";
                    //makes widget for each mistake
                    return mistakeWidget(name, category, difficulty, content, answers);
                  }).toList(),
                  ),
                ),
              )
          ],
        ),
      )
    );
  }
  Widget mistakeWidget(String name, String category, int difficulty, String content, String answers) {
    List<String> answersSplit = answers.split(';');
    return GestureDetector(
      onTap: () => _showQuestion(name, content, answersSplit, category),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 255, 163, 163),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    difficulty.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}