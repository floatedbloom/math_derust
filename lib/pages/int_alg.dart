import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/widgets/question.dart';
import '../problems/int_alg_problems.dart';

/*
TOPICS
1. Solve linear, compound, absolute value, quadratic and rational inequalities.
2. Evaluate and use functional notation to include difference quotients.
3. Analyze functions to include domains, ranges, restrictions and symmetry.
4. Sketch graphs of common functions and their transformations
5. Perform basic operations on functions to include compositions and inverses.
6. Use the theory of polynomial equations to find zeros.
7. Graph polynomial and rational functions to include intercepts and asymptotes.
8. Analyze exponential and logarithmic functions to include domains, ranges, asymptotes and their graphs.
9. Evaluate exponential and logarithmic expressions.
10. Solve exponential and logarithmic equations and associated applications.
11. Analyze and graph equations of conic sections to include vertices, foci, and asymptotes.
12. Solve applications involving conic sections.
13. Solve non-linear systems using substitution and elimination techniques.                                                                                                 q   
*/

class IntAlgPage extends StatefulWidget {
  const IntAlgPage({super.key});

  @override
  State<IntAlgPage> createState() => _IntAlgPageState();
}

class _IntAlgPageState extends State<IntAlgPage> {
  DbHelper db = DbHelper.instance;
  List<Map<String,dynamic>> questions = [];

  List<Map<String,dynamic>> newProblems = intalgProblems;

  Future<void> _addProblems(List<Map<String,dynamic>> newProblems) async {
    for (Map<String,dynamic> newProblem in newProblems) {
      await db.insert('questions',newProblem);
    }
  }

  Future<void> _loadProblems() async {
    List<Map<String,dynamic>> questions = await db.queryWhere('questions','category=?',['Intermediate Algebra']);
    if (!mounted) return;
    setState(() {
      this.questions = questions;
    });
  }

  void _initializeProblems() async {
    await _addProblems(newProblems);
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
                topic: 'Intermediate Algebra',
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
  }
}