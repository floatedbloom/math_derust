import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/* 
  Add stuff for community page later, like upvoting posts and things like that
  Add user stuff later, like user xp

*/

class DbHelper {
  static final DbHelper instance = DbHelper._privateConstructor(); //singleton -- only one instance allowed to exist
  static Database? _database; // static var that holds the sqlite Database object

  DbHelper._privateConstructor(); // this is here to make the singleton actually only create one instance

  //a getter function for the initialisation
  Future<Database> get database async {
    if (_database != null) return _database!; // if it already got instantiated, return that one
    _database = await _initDb(); // if not, instantiate it
    return _database!; // ! protects against null values
  }

  // Initiali
  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'math_derust.db');
    print("Database created!");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        xp INTEGER DEFAULT 0,
        friends TEXT,
        class TEXT
        streak INTEGER DEFAULT 0,
      )
    ''');

    await db.execute('''
      CREATE TABLE questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        difficulty TEXT NOT NULL,
        content TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE quests (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        condition TEXT NOT NULL,
        xp INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE community (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        creator_id INTEGER NOT NULL,
        title TEXT,
        content TEXT NOT NULL,
        likes INTEGER DEFAULT 0,
        parent_id INTEGER,
        FOREIGN KEY (creator_id) REFERENCES users (id),
        FOREIGN KEY (parent_id) REFERENCES community (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE mistakes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        question_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id),
        FOREIGN KEY (question_id) REFERENCES questions (id)
      )
    ''');
  }

  Future<bool> validateUser(String username, String password) async {
    Database db = await database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty;
  }

  // BASIC METHODS FOR DB.UPDATE and DB.INSERT
  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert(table, row);
  }

  Future<int> update(String table, Map<String, dynamic> row, String whereClause, List<dynamic> whereArgs) async {
    Database db = await database;
    return await db.update(table, row, where: whereClause, whereArgs: whereArgs);
  }

  Future<int> delete(String table, String whereClause, List<dynamic> whereArgs) async {
    Database db = await database;
    return await db.delete(table, where: whereClause, whereArgs: whereArgs);
  }

  //query all rows
  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    Database db = await database;
    return await db.query(table);
  }

  // Query specific rows
  Future<List<Map<String, dynamic>>> queryWhere(String table, String whereClause, List<dynamic> whereArgs) async {
    Database db = await database;
    return await db.query(table, where: whereClause, whereArgs: whereArgs);
  }

  //get all mistakes
  Future<List<Map<String, dynamic>>> queryUserMistakes(String username) async {
    Database db = await database;
    List<Map<String,dynamic>> result = await db.query('users', where: 'username=?', whereArgs: [username]);
    int user_id = result.first['id'];
    List<Map<String,dynamic>> mistakes =  await db.query('mistakes', where: 'user_id = ?', whereArgs: [user_id]);
    List<Map<String,dynamic>> questions = [];
    for (Map<String, dynamic> mistake in mistakes) {
    int questionId = mistake['question_id'];
    List<Map<String, dynamic>> questionResult = await db.query(
      'questions',
      where: 'id = ?',
      whereArgs: [questionId],
    );

    if (questionResult.isNotEmpty) {
      questions.add(questionResult.first);
    }
  }
    return questions;
  }
  //only use if updating db structure and dont care abt data
  Future<void> deleteDatabaseFile() async {
    String path = join(await getDatabasesPath(), 'math_derust.db');
    await deleteDatabase(path);
    print('Database deleted!');
  }
}