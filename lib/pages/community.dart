import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/session.dart';

class Community extends StatefulWidget {
  const Community({ super.key });

  @override
  CommunityState createState() => CommunityState();
}

class CommunityState extends State<Community> {
  DbHelper db = DbHelper.instance;
  List<Map<String,dynamic>> posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    List<Map<String, dynamic>> fetchedPosts = await db.queryAll('community');
    setState(() {
      posts = fetchedPosts;
    });
  }

  void _createComment() {
    TextEditingController contentController = TextEditingController();
  }

  void _createPost() {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    showCupertinoDialog(
      context: context, 
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Your Post",),
          content: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height:10),
                CupertinoTextField(
                  controller: titleController,
                  placeholder: "Title",
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  style: TextStyle(color: Colors.grey)
                ),
                SizedBox(height: 10),
                CupertinoTextField(
                  controller: contentController,
                  placeholder: "Content",
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  maxLines: 10,
                  style: TextStyle(color: Colors.grey)
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                String title = titleController.text.trim();
                String content = contentController.text.trim();
                if (title.isNotEmpty && content.isNotEmpty) {
                  Map<String,dynamic> row = {
                    "creator_id": Session.instance.currentUserId,
                    "title": title,
                    "content":content,
                  };
                  await db.insert('community',row);
                }
                Navigator.pop(context);
                _loadPosts();
              },
              child: Text("Post"),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Center(
              child: Text("C O M M U N I T Y", style: TextStyle(
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
            ),
            SizedBox(height:10),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: _createPost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(239, 35, 44, 61),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Create Post",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: posts.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) => communityPost(
                    posts[index]["creator_id"].toString(),
                    posts[index]["title"] ?? "No Title",
                    posts[index]["content"] ?? "",
                    posts[index]["likes"] ?? 0,
                  ),
              ),
            )
          ],
        ),
      )
    );
  }
}

Widget communityPost(String username, String title, String content, int likes) {
  return Card(
    elevation: 3,
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "@$username",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite, color: Colors.red),
                  const SizedBox(width: 5),
                  Text("$likes", style: TextStyle(fontSize: 16)),
                ],
              ),
              IconButton(
                icon: Icon(Icons.comment, color: Colors.grey),
                onPressed: () {
                  // Handle comment functionality
                },
              )
            ],
          ),
        ],
      ),
    ),
  );
}