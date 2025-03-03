import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/widgets/question.dart';
import '../problems/trig_problems.dart';

/*
TOPICS
1. Use trigonometric ratios and the Pythagorean Theorem to solve right triangles and right triangle applications.
2. State from memory the trigonometric functions of special angles in radians and degrees.
3. State from memory the fundamental trigonometric identities.
4. Evaluate trigonometric expressions involving any angle.
5. Solve applications using the Laws of Sines and Cosines.
6. Evaluate trigonometric functions of real numbers.
7. Analyze and graph trigonometric functions, identifying domains, ranges, amplitudes, periods, phase shifts and asymptotes.
8. Simplify trigonometric expressions and prove trigonometric identities.
9. Evaluate expressions involving inverse trigonometric functions.
10. Solve trigonometric equations for exact and approximate values.
11. Identify and graph common polar equations.
12. Identify and graph common parametrically defined curves.
13. Perform vector addition, subtraction and scalar multiplication in geometric, algebraic and trigonometric forms.
14. Use vector properties to solve applied problems algebraically and trigonometrically.
15. Find vector and scalar projections using the dot product.
*/

class TrigPage extends StatefulWidget {
  const TrigPage({super.key});

  @override
  State<TrigPage> createState() => _TrigPageState();
}

class _TrigPageState extends State<TrigPage> {
  DbHelper db = DbHelper.instance;
  List<Map<String,dynamic>> questions = [];

  List<Map<String,dynamic>> newProblems = trigProblems;

  Future<void> _addProblems(List<Map<String,dynamic>> newProblems) async {
    for (Map<String,dynamic> newProblem in newProblems) {
      await db.insert('questions',newProblem);
    }
  }

  Future<void> _loadProblems() async {
    List<Map<String,dynamic>> questions = await db.queryWhere('questions','category=?',['Trigonometry']);
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
                topic: 'Trigonometry',
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