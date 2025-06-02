import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/widgets/question.dart';
import '../problems/algebra_problems.dart';

const Map<int, String> topicMap = {
  1: "Evaluate functions and use function notation",
  2: "Solve linear systems of  equatons in two variables, including applications",
  3: "Solve absolute value equations and inequalities",
  4: "Add, subtract, multiply, divide and factor polynomial expressions",
  5: "Add, subtract, multiply, divide and simplify rational expressions, including complex fractions",
  6: "Solve rational equations",
  7: "Solve literal equations for a specific variable",
  8: "Simplify expressions involving rational exponents and convert between rational exponents and radicals",
  9: "Simplify radical expressions",
  10: "Solve radical equations and applications",
  11: "Solve quadratic equations, including equations of quadratic form, by factoring, square root method, completing the square, and the quadratic formula",
  12: "Graph quadratic functions",
  13: "Solve applications involving quadratic equations",
};

class AlgebraPage extends StatefulWidget {
  const AlgebraPage({super.key});

  @override
  State<AlgebraPage> createState() => _AlgebraPageState();
}

class _AlgebraPageState extends State<AlgebraPage> {
  DbHelper db = DbHelper.instance;
  List<Map<String,dynamic>> questions = [];

  List<Map<String, dynamic>> newProblems = algProblems;
  
  Future<void> _addProblems(List<Map<String,dynamic>> newProblems) async {
    for (Map<String,dynamic> newProblem in newProblems) {
      await db.insert('questions',newProblem);
    }
  }

  Future<void> _loadProblems() async {
    List<Map<String,dynamic>> questions = await db.queryWhere('questions','category=?',['Algebra']);
    if (!mounted) return;
    setState(() {
      this.questions = questions;
    });
  }

  void _initializeProblems() async {
    List<Map<String,dynamic>> existing = await db.queryWhere('questions', 'category=?', ['Algebra']);
    if (existing.isEmpty) {
      await _addProblems(newProblems);
    }
    await _loadProblems();
  }

  @override
  void initState() {
    super.initState();
    _initializeProblems();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context,index) {
              return QuestionWidget(
                topic: 'Algebra',
                name: questions[index]['name'], 
                difficulty: questions[index]['difficulty'], 
                content: questions[index]['content'], 
                answers: questions[index]['answers'],
                db: db
              );
            },
          ),
        )
      ],
    );
    /*Map<String,List<Map<String,dynamic>>> groupedQuestions = {};
    for (var q in questions) {
      final String topic = topicMap[q['topic']] ?? 'Unknown';
      
      if (!groupedQuestions.containsKey(topic)) {
        groupedQuestions[topic] = [];
      }
      groupedQuestions[topic]!.add({
        ...q,
        'topic': topic,
      });
    }

    var topicNodes = groupedQuestions.entries.map((entry) {
      return TreeNode(
        topic: entry.key, 
        questions: entry.value,
        db: db
      );
    }).toList();

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: topicNodes,
          ),
        )
      ],
    );*/
  }
}