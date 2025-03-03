import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/widgets/question.dart';
import '../problems/geometry_problems.dart';

/*
TOPICS
1. Foundations for Geometry
2. Geometric Reasoning
3. Parallel and Perpendicular Lines
4. Triangle Congruence
5. Properties and Attributes of Triangles
6. Polygons and Quadrilaterals
7. Simliarity
8. Right Triangles and Trigonometry
9. Extending Permieter, Circumference, and Area
10. Spatial Reasoning
11. Circles
12. Transformational Geometry
*/

class GeometryPage extends StatefulWidget {
  const GeometryPage({super.key});

  @override
  State<GeometryPage> createState() => _GeometryPageState();
}

class _GeometryPageState extends State<GeometryPage> {
  DbHelper db = DbHelper.instance; 
  List<Map<String,dynamic>> questions = [];

  List<Map<String,dynamic>> newProblems = geoProblems;

  Future<void> _addProblems(List<Map<String,dynamic>> newProblems) async {
    for (Map<String,dynamic> newProblem in newProblems) {
      await db.insert('questions',newProblem);
    }
  }

  Future<void> _loadProblems() async {
    List<Map<String,dynamic>> questions = await db.queryWhere('questions','category=?',['Geometry']);
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
                topic: 'Geometry',
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