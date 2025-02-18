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
    List<Map<String, dynamic>> fetchedPosts = await db.queryAll('posts');
    setState(() {
      posts = fetchedPosts;
    });
  }

  void _createComment(int postId) {
  TextEditingController contentController = TextEditingController();

  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text("Add Comment"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              CupertinoTextField(
                controller: contentController,
                placeholder: "Write a comment...",
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                maxLines: 5,
                style: TextStyle(color: Colors.grey),
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
              String content = contentController.text.trim();
              if (content.isNotEmpty) {
                Map<String, dynamic> row = {
                  "parent_id": postId,
                  "creator_id": Session.instance.currentUserId,
                  "content": content,
                };
                await db.insert('comments', row);
                Navigator.pop(context);
                _loadPosts(); // Reload to show new comments
              }
            },
            child: Text("Post"),
          ),
        ],
      );
    }
  );
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
                  await db.insert('posts',row);
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

  Future<void> likeContent(int commentId, String table, DbHelper db, Function updateLikes) async {
    await db.likeContent(commentId, table);
    updateLikes();
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
                itemBuilder: (context, index) {
                  return FutureBuilder<String>(
                    future: db.getUsernameById(posts[index]["creator_id"]),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return communityPost(
                        snapshot.data ?? "Unknown User",
                        posts[index]["title"] ?? "No Title",
                        posts[index]["content"] ?? "",
                        posts[index]["likes"] ?? 0,
                        posts[index]["id"] ?? 0,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
  Widget communityPost(String username, String title, String content, int likes, int postId) {
    return GestureDetector(
      onTap: () => showComments(context,postId,db),
      child: Card(
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
              Text("@$username", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
              const SizedBox(height: 5),
              Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(content, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await db.likeContent(postId, 'post');
                              setState(() => likes++);
                            },
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(scale: animation, child: child);
                              },
                              child: Icon(Icons.favorite, 
                                key: ValueKey(likes), 
                                color: Colors.red, size: 24),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text("$likes", style: TextStyle(fontSize: 16)),
                        ],
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.comment, color: Colors.grey),
                    onPressed: () {
                      _createComment(postId);
                    },
                  ),
                ],
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: db.queryWhere('comments', 'parent_id', [postId]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) return SizedBox.shrink();
                  return Column(
                    children: snapshot.data!.map((comment) {
                      return ListTile(
                        title: Text("@${comment['creator_id']}", style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(comment['content']),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showComments(BuildContext context, int postId, DbHelper db) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: db.queryWhere('comments', 'parent_id = ?', [postId]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
            var comments = snapshot.data!;
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text("Comments", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: comments.isEmpty
                      ? Center(child: Text("No comments yet"))
                      : ListView.builder(
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder<String>(
                              future: db.getUsernameById(comments[index]["creator_id"]),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(child: CircularProgressIndicator());
                                }
                                int likeCount = comments[index]['likes'];

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return ListTile(
                                      title: Text("@${snapshot.data ?? "User Not Found"}", 
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(comments[index]['content']),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  await likeContent(comments[index]["id"], 'comments', db, () {
                                                    setState(() => likeCount++);
                                                  });
                                                },
                                                child: AnimatedSwitcher(
                                                  duration: Duration(milliseconds: 200),
                                                  transitionBuilder: (child, animation) {
                                                    return ScaleTransition(scale: animation, child: child);
                                                  },
                                                  child: Icon(Icons.favorite, 
                                                    key: ValueKey(likeCount), 
                                                    color: Colors.red, size: 20),
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Text(likeCount.toString(), 
                                                style: TextStyle(fontSize: 14)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                );
                              },
                            );
                          }
                      ), 
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}