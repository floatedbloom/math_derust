import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../session.dart';

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
        xp_tot INTEGER GENERATED ALWAYS AS (xp_algebra + xp_geometry + xp_intalg + xp_trig + xp_quest) STORED,
        xp_algebra INTEGER DEFAULT 0,
        xp_geometry INTEGER DEFAULT 0,
        xp_intalg INTEGER DEFAULT 0,
        xp_trig INTEGER DEFAULT 0,
        xp_quest INTEGER DEFAULT 0,
        friends TEXT,
        class TEXT,
        streak INTEGER DEFAULT 1
      )
    ''');

    await db.execute('''
      CREATE TABLE questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        topic INTEGER NOT NULL,
        difficulty INTEGER NOT NULL,
        content TEXT NOT NULL,
        answers TEXT NOT NULL,
        correct TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE quests (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        condition TEXT NOT NULL,
        xp INTEGER NOT NULL,
        goal INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE user_quests (
        user_id INTEGER NOT NULL,
        quest_id INTEGER NOT NULL,
        progress INTEGER DEFAULT 0,  -- Tracks progress
        completed BOOLEAN DEFAULT 0, -- Marks quest completion
        PRIMARY KEY (user_id, quest_id),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (quest_id) REFERENCES quests(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE posts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        creator_id INTEGER NOT NULL,
        title TEXT,
        content TEXT NOT NULL,
        likes INTEGER DEFAULT 0,
        FOREIGN KEY (creator_id) REFERENCES users (id)
      )
    ''');

     await db.execute('''
      CREATE TABLE comments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        creator_id INTEGER NOT NULL,
        content TEXT NOT NULL,
        likes INTEGER DEFAULT 0,
        parent_id INTEGER NOT NULL,
        FOREIGN KEY (parent_id) REFERENCES community (id),
        FOREIGN KEY (creator_id) REFERENCES users (id)
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
  Future<List<Map<String, dynamic>>> queryUserMistakes(int userId) async {
    Database db = await database;
    int user_id = userId;
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

  Future<String> getUsernameById(int id) async {
    Database db = await database;
    var result = await db.query('users', columns: ['username'], where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first['username'] as String : "Unknown User";
  }

  Future<bool> checkAnswer(String questionName, String userAnswer, String category) async {
    Database db = await database;
    category = category.trim();
    List<Map<String, dynamic>> result = await db.query(
      'questions',
      columns: ['id','correct'],
      where: 'name = ? AND category = ?',
      whereArgs: [questionName,category],
    );
    
    if (result.isEmpty) return false;

    int questionId = result.first['id'] as int;
    
    String correct = result.first['correct'] as String;
    String correctAnswer = correct.trim();
    bool isCorrect = correctAnswer.toLowerCase() == userAnswer.trim().toLowerCase();

     if (!isCorrect) {
      List<Map<String, dynamic>> mistakeExists = await db.query(
        'mistakes',
        where: 'user_id = ? AND question_id = ?',
        whereArgs: [Session.instance.currentUserId, questionId],
      );

      if (mistakeExists.isEmpty) {
        await db.insert('mistakes', {
          'user_id': Session.instance.currentUserId,
          'question_id': questionId,
        });
      }
    }
    
    return isCorrect;
  }

  Future<List<Map<String, dynamic>>> getUserQuests(int userId) async {
    final db = await database;
    
    // the initial quests for everyone
    List<Map<String, dynamic>> quests = await db.query('quests');
    for (var quest in quests) {
      int questId = quest['id'];
      List<Map<String, dynamic>> existing = await db.query(
        'user_quests',
        where: 'user_id = ? AND quest_id = ?',
        whereArgs: [userId, questId],
      );

      if (existing.isEmpty) {
        await db.insert('user_quests', {
          'user_id': userId,
          'quest_id': questId,
          'progress': 0,
          'completed': 0,
        });
        print("Assigned quest '${quest['name']}' to user $userId");
      }
    }
    final List<Map<String, dynamic>> userQuests = await db.rawQuery('''
      SELECT quests.id, quests.name, quests.xp, user_quests.progress, user_quests.completed, quests.goal
      FROM user_quests
      JOIN quests ON user_quests.quest_id = quests.id
      WHERE user_quests.user_id = ?
    ''', [userId]);

    return userQuests;
  }

  Future<void> initializeQuests() async {
    final db = await database;
    //check if its already initialized
    List<Map<String, dynamic>> existingQuests = await db.query('quests');
    if (existingQuests.isNotEmpty) return;

    List<Map<String, dynamic>> quests = [
      {"name": "Finish 10 Lessons", "condition": "Complete 10 lessons", "xp": 50, "goal": 10},
      {"name": "Do 2 Mastery Challenges", "condition": "Complete 2 mastery challenges", "xp": 100, "goal": 2},
      {"name": "Fix 10 Mistakes", "condition": "Correct 10 incorrect answers", "xp": 20, "goal": 10},
      {"name": "Earn 500 XP", "condition": "Gain a total of 500 XP", "xp": 200, "goal": 500},
    ];

    for (var quest in quests) {
      await db.insert("quests", quest);
    }
  }

  Future<void> updateUserQuestProgress(int userId, int questId, int progressIncrease) async {
    final db = await database;
      List<Map<String, dynamic>> existingQuest = await db.query(
      'user_quests',
      where: 'user_id = ? AND quest_id = ?',
      whereArgs: [userId, questId],
    );

    if (existingQuest.isEmpty) {
      print("Quest not found for user: $userId");
      return;
    }

    int currentProgress = existingQuest.first['progress'] as int;

    List<Map<String, dynamic>> questData = await db.query(
      'quests',
      where: 'id = ?',
      whereArgs: [questId],
    );

    if (questData.isEmpty) {
      print("Quest details not found for quest ID: $questId");
      return;
    }

    int goal = questData.first['goal'] as int;
    int newProgress = currentProgress + progressIncrease;

    bool completed = newProgress >= goal;
    // UPDATE XPPPPPPP
    if (completed) {
      List<Map<String, dynamic>> result = await db.query(
        'users',
        columns: ['xp_quest'],
        where: 'id = ?',
        whereArgs: [userId],
      );

      int currentXp = result.isNotEmpty ? result.first['xp_quest'] as int : 0;
      int newXp = currentXp + (questData.first['xp'] as int);

      await db.update(
        'users',
        {'xp_quest': newXp},
        where: 'id = ?',
        whereArgs: [userId],
      );
    }

    await db.update(
      'user_quests',
      {
        'progress': newProgress > goal ? goal : newProgress, 
        'completed': completed ? 1 : 0
      },
      where: 'user_id = ? AND quest_id = ?',
      whereArgs: [userId, questId],
    );

    print("Updated progress for User $userId on Quest $questId: $newProgress / $goal");
  }

  Future<void> resetDailyQuests() async {
    final prefs = await SharedPreferences.getInstance();
    final lastReset = prefs.getString('last_reset_date');
    final today = DateTime.now().toIso8601String().substring(0, 10); // Format: YYYY-MM-DD

    if (lastReset == today) {
      print("Quests already reset today.");
      return; // Avoid resetting multiple times in a day
    }

    final db = await database;
    await db.update(
      'user_quests',
      {'completed': 0},
    );

    await prefs.setString('last_reset_date', today); // Store today's date
    print("Daily quests reset!");
  }

  Future<void> removeMistake(int userId, int questionId) async {
    Database db = await database;

    await db.delete(
      'mistakes',
      where: 'user_id = ? AND question_id = ?',
      whereArgs: [userId, questionId],
    );
  }

  Future<int?> getQuestionIdByNameAndCategory(String questionName, String category) async {
    Database db = await database;

    List<Map<String, dynamic>> result = await db.query(
      'questions',
      columns: ['id'],
      where: 'name = ? AND category = ?',
      whereArgs: [questionName,category],
    );

    if (result.isNotEmpty) {
      return result.first['id'] as int;
    }
    return null;
  }
  
  Future<String?> getQuestionCategoryById(int questionId) async {
    Database db = await database;

    List<Map<String, dynamic>> result = await db.query(
      'questions',
      columns: ['category'],
      where: 'id = ?',
      whereArgs: [questionId],
    );

    if (result.isNotEmpty) {
      return result.first['category'] as String;
    }

    return null;
  }

  Future<void> broDidntMessUp(int questionId, String questionType, int userId) async {
    Database db = await database;

    List<Map<String, dynamic>> result = await db.query(
      'users',
      columns: ['xp_algebra', 'xp_geometry', 'xp_intalg', 'xp_trig'],
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (questionType == "Algebra") {
      int currentXp = result.isNotEmpty ? result.first['xp_algebra'] as int : 0;
      int newXp = currentXp + 10;
      await db.update(
        'users',
        {'xp_algebra': newXp},
        where: 'id = ?',
        whereArgs: [userId],
      );
    } else if (questionType == "Geometry") {
      int currentXp = result.isNotEmpty ? result.first['xp_geometry'] as int : 0;
      int newXp = currentXp + 10;
      await db.update(
        'users',
        {'xp_geometry': newXp},
        where: 'id = ?',
        whereArgs: [userId],
      );
    } else if (questionType == "Intermediate Algebra") {
      int currentXp = result.isNotEmpty ? result.first['xp_intalg'] as int : 0;
      int newXp = currentXp + 10;
      await db.update(
        'users',
        {'xp_intalg': newXp},
        where: 'id = ?',
        whereArgs: [userId],
      );
    } else {
      int currentXp = result.isNotEmpty ? result.first['xp_trig'] as int : 0;
      int newXp = currentXp + 10;
      await db.update(
        'users',
        {'xp_trig': newXp},
        where: 'id = ?',
        whereArgs: [userId],
      );
    }
  }
  Future<Map<String, int>> getUserXp(int userId) async {
    Database db = await database;

    List<Map<String, dynamic>> result = await db.query(
      'users',
      columns: ['xp_tot', 'xp_algebra', 'xp_geometry', 'xp_intalg', 'xp_trig'],
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return {
        'xp_tot': result.first['xp_tot'] as int,
        'xp_algebra': result.first['xp_algebra'] as int,
        'xp_geometry': result.first['xp_geometry'] as int,
        'xp_intalg': result.first['xp_intalg'] as int,
        'xp_trig': result.first['xp_trig'] as int,
      };
    }

    return {
      'xp_tot': 0,
      'xp_algebra': 0,
      'xp_geometry': 0,
      'xp_intalg': 0,
      'xp_trig': 0,
    };
  }
  // ONE USER CAN LIKE INFINITE TIMES
  Future<void> likeContent(int contentId, String contentType) async {
    final db = await DbHelper.instance.database;

    String tableName = contentType == 'post' ? 'posts' : 'comments';

    await db.rawUpdate(
      'UPDATE $tableName SET likes = likes + 1 WHERE id = ?',
      [contentId],
    );
  }

  Future<Map<String,int>> getUserFriends(int userId) async {
    Database db = await database;

    List<Map<String, dynamic>> result = await db.query(
      'users',
      columns: ['friends'],
      where: 'id = ?',
      whereArgs: [userId],
    );

     if (result.isEmpty || result.first['friends'] == null || result.first['friends'].toString().trim().isEmpty) return {};

    List<String> friendNames = [];
    if (result.isNotEmpty) {
      String friendsString = result.first['friends'] as String;
      friendNames = friendsString.split(',');
    }

    List<List<Map<String, dynamic>>> ans = [];

    for (String name in friendNames) {
      ans.add(await db.query(
        'users',
        columns: ['xp_tot'],
        where: 'username=?',
        whereArgs: [name]
      ));

    }
    Map<String,int> friends = {};
    if (ans.isNotEmpty) {
      for (int i = 0; i < friendNames.length; i++) {
        if (ans[i].isNotEmpty && ans[i][0]['xp_tot'] != null) {
          friends[friendNames[i]] = ans[i][0]['xp_tot'] as int;
        } else {
          friends[friendNames[i]] = 0;
        }
      }
    }
    return friends;
  }

  Future<void> addFriend(int userId, String friendName) async{
    Database db = await database;

    List<Map<String, Object?>> res = await db.query('users', columns: ['friends'], where: 'id=?', whereArgs: [userId]);
    String newFriends;
    if (res.isNotEmpty) {
      String currFriends = res.first['friends'] as String;
      newFriends = currFriends.isEmpty ? friendName : "$currFriends,$friendName";
    } else {
      newFriends = friendName;
    }
    await db.update(
        'users',
        {'friends': newFriends},
        where: 'id = ?',
        whereArgs: [userId],
      );
  }

  Future<void> removeFriend(int userId, String friendName) async {
    Database db = await database;

    List<Map<String,Object?>> res = await db.query(
      'users',
      columns: ['friends'],
      where: 'id = ?',
      whereArgs: [userId],
    );

    String newFriends = (res.first["friends"] as String).replaceAll(RegExp(r'(^|,)' + RegExp.escape(friendName) + r'(?=,|$)'), '').replaceAll(RegExp(r'^,|,$'), '');;
    await db.update(
      'users',
      {'friends': newFriends},
      where: 'id=?',
      whereArgs: [userId]
    );
  }

}