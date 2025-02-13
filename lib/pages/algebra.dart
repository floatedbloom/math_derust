import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';

class AlgebraPage extends StatefulWidget {
  const AlgebraPage({super.key});

  @override
  State<AlgebraPage> createState() => _AlgebraPageState();
}

class _AlgebraPageState extends State<AlgebraPage> {
  DbHelper db = DbHelper.instance;
  List<Map<String,dynamic>> questions = [];

  List<Map<String,dynamic>> newProblems = [/*
    {
      'name': 'Problem 1',
      'category': 'Algebra',
      'difficulty': 1,
      'content': 'Simplify the following: 5 + -20',
      'answers': '25;-25;15;-15',
    },
    {
      'name': 'Problem 2',
      'category': 'Algebra',
      'difficulty': 2,
      'content': 'Simplify the following: 4a(2+4)-3a',
      'answers': '21a;16a-3;15a;4a',
    },
    {
      'name': 'Problem 3',
      'category': 'Algebra',
      'difficulty': 2,
      'content': 'Solve the following for y: 5y + 13 = 2y - 2',
      'answers': '5;-5;15;-15',
    },
    {
      'name': 'Problem 4',
      'category': 'Algebra',
      'difficulty': 2,
      'content': 'Solve the following for x: 14x = 84',
      'answers': '1/6;-1/6;6;-6',
    },
    {
      'name': 'Problem 5',
      'category': 'Algebra',
      'difficulty': 3,
      'content': 'Solve the following for x: 2/3 * x = 6',
      'answers': '4;2;9;3',
    },*/
  ];

  Future<void> _addProblems(List<Map<String,dynamic>> newProblems) async {
    for (Map<String,dynamic> newProblem in newProblems) {
      await db.insert('questions',newProblem);
    }
  }

  Future<void> _loadProblems() async {
    List<Map<String,dynamic>> questions = await db.queryWhere('questions','category=?',['Algebra']);
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
                  children: answers.map((answer) => ElevatedButton(
                    onPressed: () async {
                      if (await db.checkAnswer(name, answer)) {
                        
                      } else {

                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Answer: $answer", style: TextStyle(fontWeight: FontWeight.bold))
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
}