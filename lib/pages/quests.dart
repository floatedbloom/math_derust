import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';

import '../session.dart';

class Quests extends StatefulWidget {
  const Quests({ super.key });

  @override
  QuestsState createState() => QuestsState();
}

class QuestsState extends State<Quests> { 
  DbHelper db = DbHelper.instance;
  List<Map<String, dynamic>> quests = [];

  @override
  void initState() {
    super.initState();
    loadQuests();
  }

  Future<void> loadQuests() async {
    await db.initializeQuests();
    List<Map<String, dynamic>> data = await db.getUserQuests(Session.instance.currentUserId ?? 0);
    print("Loaded quests: $data");
    setState(() {
      quests = data;
    });
  }

  Widget questCard(String name, int xp, int progress) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 30),
                  SizedBox(width: 8),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              LinearProgressIndicator(
                value: progress / 100,
                backgroundColor: Colors.grey[300],
                color: Colors.green,
              ),
              SizedBox(height: 8),
              Text(
                '$xp XP',
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Text("Q U E S T S", style: TextStyle(
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
            SizedBox(height: 60),
            Expanded(
              child: quests.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: quests.length,
                      itemBuilder: (context, index) => questCard(
                        quests[index]["name"],
                        quests[index]["xp"],
                        quests[index]["progress"],
                      ),
                    ),
            )
          ],
        ),
      )
    );
  }
}