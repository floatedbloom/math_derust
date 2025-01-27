import 'package:flutter/material.dart';

import '../data/db.dart';
import '../session.dart';
import 'create_account.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DbHelper db = DbHelper();

  Future<void> login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    bool validUser = true;//db.validateUser(email, password);
    if (validUser) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}