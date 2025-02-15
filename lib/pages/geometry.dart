import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/session.dart';
import 'package:rive/rive.dart';

class GeometryPage extends StatefulWidget {
  const GeometryPage({super.key});

  @override
  State<GeometryPage> createState() => _GeometryPageState();
}

class _GeometryPageState extends State<GeometryPage> {
  DbHelper db = DbHelper.instance;
  List<Map<String,dynamic>> questions = [];

  List<Map<String,dynamic>> newProblems = [/*
    {
      'name': 'Problem 1',
      'category': 'Geometry',
      'difficulty': 1,
      'content': 'What is the sum of the interior angles of a triangle?',
      'answers': '90;180;270;360',
      'correct': '180',
    },
    {
      'name': 'Problem 2',
      'category': 'Geometry',
      'difficulty': 2,
      'content': 'A right triangle has legs of 3 and 4. What is the length of the hypotenuse?',
      'answers': '5;6;7;8',
      'correct': '5',
    },
    {
      'name': 'Problem 3',
      'category': 'Geometry',
      'difficulty': 2,
      'content': 'What is the area of a circle with radius 6?',
      'answers': '36π;12π;18π;24π',
      'correct': '36π',
    },
    {
      'name': 'Problem 4',
      'category': 'Geometry',
      'difficulty': 3,
      'content': 'A square has a perimeter of 20. What is its area?',
      'answers': '25;16;20;10',
      'correct': '25',
    },
    {
      'name': 'Problem 5',
      'category': 'Geometry',
      'difficulty': 3,
      'content': 'Which type of quadrilateral has exactly one pair of parallel sides?',
      'answers': 'Square;Rhombus;Trapezoid;Rectangle',
      'correct': 'Trapezoid',
    },*/
  ];

  Future<void> _addProblems(List<Map<String,dynamic>> newProblems) async {
    for (Map<String,dynamic> newProblem in newProblems) {
      await db.insert('questions',newProblem);
    }
  }

  Future<void> _loadProblems() async {
    List<Map<String,dynamic>> questions = await db.queryWhere('questions','category=?',['Geometry']);
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
                        bool isCorrect = await db.checkAnswer(name, answer,'Geometry');
                        print(answer);
                        print(isCorrect);
                        if (isCorrect) {
                          await db.updateUserQuestProgress(Session.instance.currentUserId ?? 0, 1, 1);
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
}