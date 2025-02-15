import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/session.dart';
import 'package:rive/rive.dart';

class TrigPage extends StatefulWidget {
  const TrigPage({super.key});

  @override
  State<TrigPage> createState() => _TrigPageState();
}

class _TrigPageState extends State<TrigPage> {
  DbHelper db = DbHelper.instance;
  List<Map<String,dynamic>> questions = [];

  List<Map<String,dynamic>> newProblems = [/*
    {
      'name': 'Problem 1',
      'category': 'Trigonometry',
      'difficulty': 1,
      'content': 'What is sin(30°)?',
      'answers': '0;1/2;√2/2;1',
      'correct': '1/2',
    },
    {
      'name': 'Problem 2',
      'category': 'Trigonometry',
      'difficulty': 2,
      'content': 'What is cos(π/4)?',
      'answers': '1;0;√2/2;1/2',
      'correct': '√2/2',
    },
    {
      'name': 'Problem 3',
      'category': 'Trigonometry',
      'difficulty': 2,
      'content': 'Find tan(45°).',
      'answers': '1;0;√3/2;√3',
      'correct': '1',
    },
    {
      'name': 'Problem 4',
      'category': 'Trigonometry',
      'difficulty': 3,
      'content': 'Solve for x: sin(x) = 0.5 on [0°, 360°].',
      'answers': '30°;30°, 150°;90°, 270°;60°, 120°',
      'correct': '30°, 150°',
    },
    {
      'name': 'Problem 5',
      'category': 'Trigonometry',
      'difficulty': 3,
      'content': 'What is the period of f(x) = 3sin(2x)?',
      'answers': 'π;2π;π/2;3π',
      'correct': 'π',
    },*/
  ];

  Future<void> _addProblems(List<Map<String,dynamic>> newProblems) async {
    for (Map<String,dynamic> newProblem in newProblems) {
      await db.insert('questions',newProblem);
    }
  }

  Future<void> _loadProblems() async {
    List<Map<String,dynamic>> questions = await db.queryWhere('questions','category=?',['Trigonometry']);
    setState(() {
      this.questions = questions;
    });
  }

  @override
  void initState() {
    super.initState();
    _addProblems(newProblems);
    _loadProblems();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context,index) {
              return questionWidget(
                questions[index]['name'], 
                questions[index]['difficulty'], 
                questions[index]['content'], 
                questions[index]['answers']
              );
            },
          ),
        )
      ],
    );
  }

  Widget questionWidget(String name, int difficulty, String content, String answers) {
    List<String> answersSplit = answers.split(';');
    return GestureDetector(
      onTap: () => _showQuestion(name, content, answersSplit),
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

  void _showQuestion(String name, String content, List<String> answers) {
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
                        bool isCorrect = await db.checkAnswer(name, answer,'Trigonometry');
                        if (isCorrect) {
                          await db.updateUserQuestProgress(Session.instance.currentUserId ?? 0, 1, 1);
                        }
                        print(answer);
                        print(isCorrect);
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
}