import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/* 
  Add stuff for community page later, like upvoting posts and things like that
  Add user stuff later, like user xp

*/

class DbHelper {
  static Database? _database;

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'math_derust.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL UNIQUE,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL
          )
        ''');
        await db.execute(''' 
          CREATE TABLE user
        ''');
      },
    );
  }

  // USER METHODS
 
  // COMMUNITY METHODS
  
}