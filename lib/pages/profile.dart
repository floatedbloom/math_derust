import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'dart:math';

import 'package:math_derust/session.dart';

class Profile extends StatefulWidget {
  const Profile({ super.key });

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  DbHelper db = DbHelper.instance;
  Map<String, int> xps = {
    'xp_tot': 0,
    'xp_algebra': 0,
    'xp_geometry': 0,
    'xp_intalg': 0,
    'xp_trig': 0,
  };

  Map<String, int> friends = {};
  final TextEditingController friendController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    Map<String, int> fetchedXp = await db.getUserXp(Session.instance.currentUserId ?? 0);
    Map<String, int> fetchedFriends = await db.getUserFriends(Session.instance.currentUserId ?? 0);
    print(fetchedFriends);
    setState(() {
      xps = fetchedXp;
      friends = fetchedFriends;
    });
  }

  Future<String?> getClassValue() async {
    List<Map<String, dynamic>> result = await db.queryWhere(
      'users',
      'username = ?',
      [Session.instance.currentUsername],
    );

    if (result.isNotEmpty) {
      return result.first['class'];
    }
    return null;
  }

  Future<int?> getStreak() async {
    List<Map<String, dynamic>> result = await db.queryWhere(
      'users',
      'username = ?',
      [Session.instance.currentUsername],
    );

    if (result.isNotEmpty) {
      return result.first['streak'];
    }
    return null;
  }

  void _addFriend(TextEditingController friendName) async {
    bool res = await db.checkExistence(friendName.text);
    bool exists = res && friendName.text.trim() != Session.instance.currentUsername?.trim();
    if (exists) {
      db.addFriend(Session.instance.currentUserId ?? 0, friendName.text);
      await loadUser();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username doesn't exist or is already you friend"))
        );
    }
    friendController.clear();
    FocusScope.of(context).unfocus();
  }

  void _removeFriend(String friendName) async {
    await db.removeFriend(Session.instance.currentUserId ?? 0, friendName);
    await loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {FocusManager.instance.primaryFocus?.unfocus();},
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 0),
                  Text("P R O F I L E", style: TextStyle(
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
                  const SizedBox(height: 120),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      Session.instance.currentUsername as String,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 255, 198, 198),
                      ),
                    ),
                  ),
                  FutureBuilder<String?>(
                    future: getClassValue(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return ConstrainedBox(constraints: const BoxConstraints(minWidth: 200, maxWidth: 200, minHeight: 50, maxHeight: 50),child: Text('Error loading class'));
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return ConstrainedBox(constraints: const BoxConstraints(minWidth: 200, maxWidth: 200, minHeight: 50, maxHeight: 50),child: Center(child: Text('No Class',style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 149, 134, 134),
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 4.0,
                                color: Color.fromRGBO(172, 108, 108, 0.298),
                              )
                            ]
                          ),)));
                      } else {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${snapshot.data!}",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 170, 156, 156),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 250,
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      padding: const EdgeInsets.all(20.0),
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 95, 88, 88),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withAlpha((0.3 * 255).toInt()),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FutureBuilder<int?>(
                                  future: getStreak(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return SizedBox(
                                        height: 40,
                                        child: snapshot.connectionState == ConnectionState.waiting
                                          ? CircularProgressIndicator()
                                          : Text(snapshot.data?.toString() ?? "Error"),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error loading Streak');
                                    } else if (!snapshot.hasData || snapshot.data == null) {
                                      return Text('E R R O R',style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(255, 163, 4, 4),
                                          shadows: [
                                            Shadow(
                                              offset: Offset(2.0, 2.0),
                                              blurRadius: 4.0,
                                              color: Color.fromRGBO(0, 0, 0, 0.3),
                                            )
                                          ]
                                        ),);
                                    } else {
                                      return Text(
                                        snapshot.data!.toString() ?? "0",
                                        style: TextStyle(
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
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "🔥",
                                  style: TextStyle(fontSize: 44),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Day Streak",
                                  style: TextStyle(
                                    fontSize: 20,
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
                        ),
                        Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                  child: ClipOval(
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        Color.fromRGBO(0, 0, 0, 0.3),
                                        BlendMode.darken,
                                      ),
                                      child: PieChartWidget(
                                        xpAlgebra: xps['xp_algebra'] ?? 0,
                                        xpGeometry: xps['xp_geometry'] ?? 0,
                                        xpIntAlg: xps['xp_intalg'] ?? 0,
                                        xpTrig: xps['xp_trig'] ?? 0
                                      )
                                    ),
                                  )
                                ),
                              ),
                              Center(
                                child: Text(
                                  "${xps['xp_tot']} XP",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 4.0,
                                        color: Color.fromRGBO(0, 0, 0, 0.5),
                                      )
                                    ]
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  /*const SizedBox(height: 30),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          friends.isEmpty
                          ? Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Text("No Friends Yet", 
                            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20)
                            ),
                          )
                          : ListView.builder(
                            shrinkWrap: true,
                            itemCount: friends.length,
                            itemBuilder: (context,index) {
                              return friendWidget(friends.keys.elementAt(index), friends.values.elementAt(index));
                            },
                          )
                        ],
                      ),
                    )
                  ),*/
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 150),
                        child: TextField(
                          controller: friendController,
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(71, 197, 197, 255),
                            hintText: "     Username",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () => _addFriend(friendController), 
                        child: Row(
                          children: [
                            Text(
                              "Add A Friend  ",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 120, 120, 120),
                            ),),
                            Icon(
                              Icons.handshake_rounded,
                            ),
                          ],
                        )
                      ),
                    ],
                  )*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget friendWidget(String username, int xp) {
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
                  username,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '$xp XP',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () => _removeFriend(username), 
              icon: Icon(Icons.person_remove_alt_1_rounded)
            )
          ],
        ),
      ),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  final int xpAlgebra;
  final int xpGeometry;
  final int xpIntAlg;
  final int xpTrig;

  const PieChartWidget({
    super.key,
    required this.xpAlgebra,
    required this.xpGeometry,
    required this.xpIntAlg,
    required this.xpTrig,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(300, 300),
      painter: PieChartPainter(
        xpAlgebra: xpAlgebra,
        xpGeometry: xpGeometry,
        xpIntAlg: xpIntAlg,
        xpTrig: xpTrig,
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final int xpAlgebra;
  final int xpGeometry;
  final int xpIntAlg;
  final int xpTrig;

  PieChartPainter({
    required this.xpAlgebra,
    required this.xpGeometry,
    required this.xpIntAlg,
    required this.xpTrig,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    double startAngle = 0.0;
    
    List<Color> colors = [
      Color(0xFFB0BEC5), // Algebra
      Color.fromARGB(255, 104, 158, 106), // Geometry
      Color.fromARGB(255, 197, 131, 66), // Intermediate Algebra
      Color.fromARGB(255, 204, 93, 93), // Trigonometry
    ];
    
    List<int> xpValues = [xpAlgebra, xpGeometry, xpIntAlg, xpTrig];
    int totalXp = xpValues.reduce((a, b) => a + b);
    
    if (totalXp == 0) return;

    for (int i = 0; i < xpValues.length; i++) {
      paint.color = colors[i % colors.length];
      double sweepAngle = (xpValues[i] / totalXp) * (2 * pi);
      canvas.drawArc(
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}