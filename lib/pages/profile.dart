import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class Profile extends StatefulWidget {
  const Profile({ super.key });

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'USERNAME',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 120, 120, 120),
                  ),
                ),
                //settings menu
              ],
            ),
            const Text(
              'MATH CLASS',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 120, 120, 120),
              ),
            ),
            const SizedBox(height: 30),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
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
                          Text(
                            "100",
                            style: TextStyle(
                              fontSize: 35,
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
                                child: PieChartWidget()
                              ),
                            )
                          ),
                        ),
                        Center(
                          child: Text(
                            "10000 XP",
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
            const SizedBox(height: 30),
            const Text(
              'F R I E N D S',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    friendWidget("Friend 1", 100),
                    friendWidget("Friend 2", 100),
                    friendWidget("Friend 3", 100),
                    friendWidget("Friend 4", 100),
                    friendWidget("Friend 5", 100),
                    friendWidget("Friend 6", 100),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(300, 300),
      painter: PieChartPainter(),
    );
  }
}

class PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill;
    double startAngle = 0.0;
    List<Color> colors = [
      Color(0xFFB0BEC5),
      Color.fromARGB(255, 104, 158, 106),
      Color.fromARGB(255, 197, 131, 66),
      Color.fromARGB(255, 204, 93, 93),
    ];
    List<double> sliceAngles = List.generate(4, (_) => Random().nextDouble() * pi);
    double totalAngle = sliceAngles.reduce((a, b) => a + b);
    sliceAngles = sliceAngles.map((angle) => angle / totalAngle * (2 * pi)).toList();

    for (int i = 0; i < sliceAngles.length; i++) {
      paint.color = colors[i % colors.length];
      double sweepAngle = sliceAngles[i];
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
    return false;
  }
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
        ],
      ),
    ),
  );
}