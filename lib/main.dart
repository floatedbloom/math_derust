import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'pages/home.dart';
import 'pages/login.dart';
import 'session.dart' as app_session;
//import 'data/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? "";
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? "";

  if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
    throw Exception('Supabase credentials are missing. Set SUPABASE_URL and SUPABASE_ANON_KEY using --dart-define.');
  }

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  //await DbHelper.instance.deleteDatabaseFile();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: FutureBuilder<bool>(
        future: app_session.Session.instance.isLoggedIn, 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == true) return Home();
          return Login();
        },
      ),
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => Login(),
      },
    );
  }
}