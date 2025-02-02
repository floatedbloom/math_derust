import 'package:flutter/material.dart';

class Community extends StatefulWidget {
  const Community({ super.key });

  @override
  CommunityState createState() => CommunityState();
}

class CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Text("C O M M U N I T Y", style: TextStyle(
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