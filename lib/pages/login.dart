import 'package:flutter/material.dart';
import 'package:math_derust/pages/home.dart';

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
      if (mounted) {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const Home()),
        );
      }
    } else {
      if (mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password'))
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
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
          child: Column(
            children: [
              //username field
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'U S E R N A M E'),
              ),
              //password field
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'P A S S W O R D'),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}