import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/pages/login.dart';
import 'package:sqflite/sqflite.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  //fields values
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  String? selectedClass;
  final List<String> classOptions = ['Pre-Algebra', 'Introductory Algebra', 'Geometry','Intermediate Algebra','Precalculus','Calculus I','Calculus II','Calculus III','Calculus IV','Linear Algebra','Differential Equations'];

  Future<void> _createAccount() async {
    String username = _usernameController.text.trim();
    String clas = selectedClass as String;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirm = _confirmController.text;

    //capture context
    BuildContext currentContext = context;

    // Check for empty username
    if (username.isEmpty) {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text('Username cannot be empty'))
      );
      return;
    }

    //check the 2 passwords
    if (confirm != password) {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text('Passwords do not match'))
      );
      return;
    }
    //create new user as Map
    Map<String, dynamic> userMap = {
      'username': username,
      'email': email,
      'password': password,
      'friends': "",
      'class': clas,
    };      
    //put into db
    try {
      await DbHelper.instance.insert('users', userMap);
    }  on DatabaseException {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text('Name or email is taken'))
      );
      return;
    }
    //send to login screen
    if (mounted) {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text('Account Creation Successful!'))
      );
      Navigator.of(currentContext).push(
        MaterialPageRoute(
          builder: (context) => const Login()
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Center(child: Text('Create Account', style: TextStyle(
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
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
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  label: Align(
                    alignment: Alignment.center, // Centers the label
                    child: Text(
                      'E M A I L',
                      textAlign: TextAlign.center, // Ensures text within label is centered
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  label: Align(
                    alignment: Alignment.center, // Centers the label
                    child: Text(
                      'P A S S W O R D',
                      textAlign: TextAlign.center, // Ensures text within label is centered
                    ),
                  ),
                ),
                obscureText: true,
              ),
              TextField(
                controller: _confirmController,
                decoration: const InputDecoration(
                  label: Align(
                    alignment: Alignment.center, // Centers the label
                    child: Text(
                      'C O N F I R M   P A S S W O R D',
                      textAlign: TextAlign.center, // Ensures text within label is centered
                    ),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height:15),
              Text(
                'C U R R E N T   M A T H   C L A S S',
              ),
              DropdownButtonFormField<String>(
                value: selectedClass,
                items: classOptions.map((String className) {
                  return DropdownMenuItem(
                    value: className,
                    child: Text(className),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedClass = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createAccount,
                child: const Text('C R E A T E'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}