import 'package:flutter/material.dart';

class Learn extends StatefulWidget {
  const Learn({ super.key });

  @override
  LearnState createState() => LearnState();
}

class LearnState extends State<Learn> {
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
            
          ],
        ),
      )
    );
  }
}