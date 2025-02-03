import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/session.dart';

class Mistakes extends StatefulWidget {
  const Mistakes({ super.key });

  @override
  MistakesState createState() => MistakesState();
}

class MistakesState extends State<Mistakes> {
  List<Map<String,dynamic>> mistakes = [];

  @override
  void initState() {
    super.initState();
    _loadMistakes();
  }

  Future<void> _loadMistakes() async {
    DbHelper db = DbHelper.instance;
    List<Map<String, dynamic>> fetchedMistakes = await db.queryUserMistakes(Session.instance.currentUsername ?? 'User Not Found');
    setState(() {
      mistakes = fetchedMistakes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15),
            Text("M I S T A K E S", style: TextStyle(
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
              ),),
            SizedBox(height: 20),
            mistakes.isEmpty ? 
                Center(
                  child: Text(
                    "No Mistakes To Fix",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 120, 120, 120),
                    ),
                  )
                )
            : ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 900),
              child: SingleChildScrollView(
                child: Column(
                  children: mistakes.map((mistake) {
                    String name = mistake['name'] ?? '';
                    String category = mistake['category'] ?? "";
                    String difficulty = mistake['difficulty'] ?? "";
                    //makes widget for each mistake
                    return mistakeWidget(name, category, difficulty);
                  }).toList(),
                  ),
                ),
              )
          ],
        ),
      )
    );
  }
}

Widget mistakeWidget(String name, String category, String difficulty) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                category,
                style: TextStyle(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 255, 163, 163),
                ),
              ),
              SizedBox(height: 5),
              Text(
                difficulty,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}