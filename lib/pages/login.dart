import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/db.dart';
import '../session.dart';
import 'create_account.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DbHelper db = DbHelper.instance;

  Future<void> _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    bool validUser = await db.validateUser(username, password);
    if (validUser) {
      await Session.instance.setUser(username);
      await updateStreak();
      await DbHelper.instance.resetDailyQuests();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context, 
          '/home',
          (_) => false
        );
      }
    } else {
      if (mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password'))
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Create Your Account'))
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Center(child: Text('Login', style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 173, 151, 103),
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 1,
                  color: Colors.grey,
                ),
              ],),
            )),
            elevation: 0,
            scrolledUnderElevation: 0.0,
            backgroundColor: Color(0xFF121212),
          ),
          body: Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  //username field
                  TextField(
                    controller: _usernameController,
                    textAlign: TextAlign.center, // Centers the input text
                    decoration: const InputDecoration(
                      label: Align(
                        alignment: Alignment.center, // Centers the label
                        child: Text(
                          'U S E R N A M E',
                          textAlign: TextAlign.center, // Ensures text within label is centered
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  //password field
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    textAlign: TextAlign.center, // Centers the input text
                    decoration: const InputDecoration(
                      label: Align(
                        alignment: Alignment.center, // Centers the label
                        child: Text(
                          'P A S S W O R D',
                          textAlign: TextAlign.center, // Ensures text within label is centered
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login, 
                    child: const Text(
                      'L O G I N', 
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) =>  const CreateAccount(),
                        ),
                      );
                    }, 
                    child: const Text(
                      'Create Account', 
                      style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height:500),
                  const Text(
                      'S U P P O R T :  \$GeorgiyLapin', 
                      style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// Streak updater
Future<void> updateStreak() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String lastLogin = prefs.getString('lastLogin') ?? ''; 
  int streak = prefs.getInt('streak') ?? 0;

  DateTime today = DateTime.now();
  DateTime? lastLoginDate = lastLogin.isNotEmpty ? DateTime.tryParse(lastLogin) : null;

  if (lastLoginDate == null || !_isSameDay(today, lastLoginDate)) {
    if (lastLoginDate != null && _isYesterday(today, lastLoginDate)) {
      streak++;
    } else {
      streak = 1;
    }

    await prefs.setString('lastLogin', today.toIso8601String());
    await prefs.setInt('streak', streak);
  }
}

bool _isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

bool _isYesterday(DateTime today, DateTime last) {
  return today.difference(last).inDays == 1;
}