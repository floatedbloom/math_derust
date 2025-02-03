import 'package:flutter/material.dart';
import 'algebra.dart';
import 'geometry.dart';
import 'int_alg.dart';
import 'trig.dart';

class Learn extends StatefulWidget {
  const Learn({ super.key });

  @override
  LearnState createState() => LearnState();
}

class LearnState extends State<Learn> {
  Widget topicWidget(String name) {
    return GestureDetector(
      onTap: () {
        switch(name) {
          case "Algebra" : Navigator.push<void>(context,MaterialPageRoute<void>(builder: (context) => AlgebraPage()),); break;
          case "Geometry" : Navigator.push<void>(context,MaterialPageRoute<void>(builder: (context) => GeometryPage()),); break;
          case "Intermediate Algebra" : Navigator.push<void>(context,MaterialPageRoute<void>(builder: (context) => IntAlgPage()),); break;
          case "Trigonometry" : Navigator.push<void>(context,MaterialPageRoute<void>(builder: (context) => TrigPage()),); break;
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(45),
          child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
                ),
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Text("L E A R N", style: TextStyle(
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
              ),
            ),
            SizedBox(height: 60,),
            topicWidget("Algebra"),
            SizedBox(height: 20,),
            topicWidget("Geometry"),
            SizedBox(height: 20,),
            topicWidget("Intermediate Algebra"),
            SizedBox(height: 20,),
            topicWidget("Trigonometry"),
          ],
        ),
      )
    );
  }
}