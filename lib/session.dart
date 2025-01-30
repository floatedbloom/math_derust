import 'package:math_derust/data/db.dart';

class Session {
  //stuff for instances
  static Session? _instance;
  static Session get instance {
    _instance ??= Session._internal();
    return _instance!;
  }

  Session._internal();

  //session variables
  String? currentUsername;
  int? currentUserId;

  Future<void> setUser(String username) async {
    //get user from database and set it as session
    final DbHelper db = DbHelper.instance;
    List<Map<String, dynamic>> users = await db.queryWhere('users','username = ?',[username]);
    if (users.isNotEmpty) {
      Map<String, dynamic> user = users.first;
      currentUsername = username;
      currentUserId = user['id'];
    }
  }

  //clear session
  void clearUser() {
    currentUsername = null;
    currentUserId = null;
  }
  
  //logged in check
  Future<bool> get isLoggedIn => Future.value(currentUsername != null);
}