import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/pages/login.dart';
import 'package:math_derust/session.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _usernameController = TextEditingController();
  //final TextEditingController _emailController = TextEditingController();
  //final TextEditingController _passwordController = TextEditingController();
  String? selectedClass;
  final List<String> classOptions = ['Pre-Algebra', 'Introductory Algebra', 'Geometry','Intermediate Algebra','Precalculus','Calculus I','Calculus II','Calculus III','Calculus IV','Linear Algebra','Differential Equations'];

  void _showLogoutConfirmation(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            CupertinoDialogAction(
              child: Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: Text("Logout", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Session.instance.clearUser();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Math Derust',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 173, 151, 103),
            shadows: [
              Shadow(offset: Offset(2, 2), blurRadius: 1, color: Colors.grey),
            ],
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0.0,
        backgroundColor: Color(0xFF121212),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Change Username",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: "Enter new username (or leave blank)",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Set Class",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    DbHelper db = DbHelper.instance;
                    if (_usernameController.text != "") {
                      Map<String, dynamic> row = {'username': _usernameController.text};
                      String whereClause = 'id = ?';
                      List<dynamic> whereArgs = [Session.instance.currentUserId];
                      try {
                          int updatedRows = await db.update('users',row,whereClause,whereArgs);
                          if (updatedRows > 0) {
                            print('Username updated successfully.');
                            Session.instance.setUser(_usernameController.text);
                          } else {
                            print('No changes made to the username.');
                          }
                      } catch (e) {
                        print('Error updating username: $e');
                      }
                    }
        
                    if (selectedClass != null) {
                      try {
                        DbHelper db = DbHelper.instance;
                        Map<String, dynamic> row = {'class': selectedClass};
                        String whereClause = 'username = ?';
                        List<dynamic> whereArgs = [Session.instance.currentUsername];
        
                        try {
                          int updatedRows = await db.update('users', row,whereClause,whereArgs);
        
                          if (updatedRows > 0) {
                            print('Class updated successfully.');
                          } else {
                            print('No changes made to the Class.');
                          }
                        } catch (e) {
                          print('Error updating Class: $e');
                        }
                      } catch(e) {
                        print('Error setting class $e');
                      }
                    }
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Settings Saved!")),
                    );
                  },
                  child: const Text("Save"),
                ),
              ),
              const SizedBox(height: 450),
              Center(
                child: ElevatedButton(
                  onPressed: () => _showLogoutConfirmation(context), 
                  child: const Text(
                    'L O G O U T',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey
                    )
                  )
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}