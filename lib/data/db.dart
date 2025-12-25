import 'dart:math';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../session.dart' as app_session;

class DbHelper {
  static final DbHelper instance = DbHelper._privateConstructor();
  DbHelper._privateConstructor();

  SupabaseClient get _client => Supabase.instance.client;

  // Insert a row into any table
  Future<Map<String, dynamic>?> insert(String table, Map<String, dynamic> row) async {
    final result = await _client.from(table).insert(row).select().maybeSingle();
    return result;
  }

  // Update rows in a table
  Future<void> update(String table, Map<String, dynamic> row, String whereColumn, dynamic whereValue) async {
    await _client.from(table).update(row).eq(whereColumn, whereValue);
  }

  // Delete rows from a table
  Future<void> delete(String table, String whereColumn, dynamic whereValue) async {
    await _client.from(table).delete().eq(whereColumn, whereValue);
  }

  // Query all rows from a table
  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final result = await _client.from(table).select();
    return List<Map<String, dynamic>>.from(result);
  }

  // Query with where clause
  Future<List<Map<String, dynamic>>> queryWhere(String table, String whereColumn, dynamic whereValue) async {
    final result = await _client.from(table).select().eq(whereColumn, whereValue);
    return List<Map<String, dynamic>>.from(result);
  }

  // Get all mistakes for a user with question details
  Future<List<Map<String, dynamic>>> queryUserMistakes(int userId) async {
    final mistakes = await _client
        .from('mistakes')
        .select('question_id')
        .eq('user_id', userId);

    List<Map<String, dynamic>> questions = [];
    for (var mistake in mistakes) {
      final questionResult = await _client
          .from('questions')
          .select()
          .eq('id', mistake['question_id'])
          .maybeSingle();

      if (questionResult != null) {
        questions.add(Map<String, dynamic>.from(questionResult));
      }
    }
    return questions;
  }

  // Get username by ID
  Future<String> getUsernameById(int id) async {
    final result = await _client
        .from('users')
        .select('username')
        .eq('id', id)
        .maybeSingle();
    return result?['username'] as String? ?? "Unknown User";
  }

  // Get user info by ID (username and avatar)
  Future<Map<String, String?>> getUserInfoById(int id) async {
    final result = await _client
        .from('users')
        .select('username, avatar_url')
        .eq('id', id)
        .maybeSingle();
    return {
      'username': result?['username'] as String? ?? "Unknown User",
      'avatar_url': result?['avatar_url'] as String?,
    };
  }

  // Check answer and record mistakes
  Future<bool> checkAnswer(String questionName, String userAnswer, String category) async {
    category = category.trim();
    final result = await _client
        .from('questions')
        .select('id, correct')
        .eq('name', questionName)
        .eq('category', category)
        .maybeSingle();

    if (result == null) return false;

    int questionId = result['id'] as int;
    String correct = result['correct'] as String;
    String correctAnswer = correct.trim();
    bool isCorrect = correctAnswer.toLowerCase() == userAnswer.trim().toLowerCase();

    if (!isCorrect && app_session.Session.instance.currentUserId != null) {
      // Check if mistake already exists
      final mistakeExists = await _client
          .from('mistakes')
          .select('id')
          .eq('user_id', app_session.Session.instance.currentUserId!)
          .eq('question_id', questionId)
          .maybeSingle();

      if (mistakeExists == null) {
        await _client.from('mistakes').insert({
          'user_id': app_session.Session.instance.currentUserId,
          'question_id': questionId,
        });
      }
    }

    return isCorrect;
  }

  // Number of daily quests to assign
  static const int dailyQuestCount = 5;

  // Get user quests for today
  Future<List<Map<String, dynamic>>> getUserQuests(int userId) async {
    final today = DateTime.now().toUtc().toIso8601String().substring(0, 10);
    
    // Get user's quests for today with quest details
    final userQuests = await _client
        .from('user_quests')
        .select('quest_id, progress, completed, assigned_date, quests(id, name, xp, goal, category, difficulty, icon)')
        .eq('user_id', userId)
        .eq('assigned_date', today);

    return userQuests.map<Map<String, dynamic>>((uq) {
      final quest = uq['quests'] as Map<String, dynamic>;
      return {
        'id': quest['id'],
        'name': quest['name'],
        'xp': quest['xp'],
        'goal': quest['goal'],
        'category': quest['category'],
        'difficulty': quest['difficulty'],
        'icon': quest['icon'],
        'progress': uq['progress'],
        'completed': (uq['completed'] == true || uq['completed'] == 1) ? 1 : 0,
      };
    }).toList();
  }

  // Initialize quests - assigns random quests for today if needed
  Future<void> initializeQuests() async {
    final userId = app_session.Session.instance.currentUserId;
    if (userId == null) return;
    
    final today = DateTime.now().toUtc().toIso8601String().substring(0, 10);
    
    // Check if quests already assigned for today
    final existingToday = await _client
        .from('user_quests')
        .select('id')
        .eq('user_id', userId)
        .eq('assigned_date', today)
        .limit(1);
    
    if (existingToday.isNotEmpty) return; // Already assigned for today
    
    // Delete old quest assignments for this user
    await _client
        .from('user_quests')
        .delete()
        .eq('user_id', userId);
    
    // Get all available quests
    final allQuests = await _client.from('quests').select('id, category, difficulty');
    
    // Select random quests with category diversity
    final selectedQuestIds = _selectDiverseQuests(allQuests);
    
    // Assign selected quests to user
    for (var questId in selectedQuestIds) {
      await _client.from('user_quests').insert({
        'user_id': userId,
        'quest_id': questId,
        'progress': 0,
        'completed': false,
        'assigned_date': today,
      });
    }
  }

  // Select diverse quests from different categories
  List<int> _selectDiverseQuests(List<dynamic> allQuests) {
    final rand = Random();
    final selectedIds = <int>[];
    
    // Group quests by category
    final byCategory = <String, List<int>>{};
    for (var quest in allQuests) {
      final category = quest['category'] as String;
      final id = quest['id'] as int;
      byCategory.putIfAbsent(category, () => []).add(id);
    }
    
    // Prioritize categories to ensure variety
    final priorityCategories = ['learning', 'accuracy', 'practice', 'social', 'achievement', 'subject', 'streak'];
    
    // First pass: pick one from each priority category
    for (var category in priorityCategories) {
      if (selectedIds.length >= dailyQuestCount) break;
      if (byCategory.containsKey(category) && byCategory[category]!.isNotEmpty) {
        final questsInCategory = byCategory[category]!;
        final randomQuest = questsInCategory[rand.nextInt(questsInCategory.length)];
        if (!selectedIds.contains(randomQuest)) {
          selectedIds.add(randomQuest);
        }
      }
    }
    
    // Second pass: fill remaining slots with random quests
    final allIds = allQuests.map((q) => q['id'] as int).toList()..shuffle(rand);
    for (var id in allIds) {
      if (selectedIds.length >= dailyQuestCount) break;
      if (!selectedIds.contains(id)) {
        selectedIds.add(id);
      }
    }
    
    return selectedIds;
  }

  // Update quest progress
  Future<void> updateUserQuestProgress(int userId, int questId, int progressIncrease) async {
    final today = DateTime.now().toUtc().toIso8601String().substring(0, 10);
    
    final existingQuest = await _client
        .from('user_quests')
        .select('progress, completed')
        .eq('user_id', userId)
        .eq('quest_id', questId)
        .eq('assigned_date', today)
        .maybeSingle();

    if (existingQuest == null) return;
    if (existingQuest['completed'] == true) return; // Already completed

    int currentProgress = existingQuest['progress'] as int;

    final questData = await _client
        .from('quests')
        .select('goal, xp')
        .eq('id', questId)
        .maybeSingle();

    if (questData == null) return;

    int goal = questData['goal'] as int;
    int newProgress = currentProgress + progressIncrease;
    bool completed = newProgress >= goal;

    // Award XP if completed
    if (completed) {
      final userData = await _client
          .from('users')
          .select('xp_quest')
          .eq('id', userId)
          .maybeSingle();

      int currentXp = userData?['xp_quest'] as int? ?? 0;
      int newXp = currentXp + (questData['xp'] as int);

      await _client
          .from('users')
          .update({'xp_quest': newXp})
          .eq('id', userId);
    }

    await _client
        .from('user_quests')
        .update({
          'progress': newProgress > goal ? goal : newProgress,
          'completed': completed,
        })
        .eq('user_id', userId)
        .eq('quest_id', questId)
        .eq('assigned_date', today);
  }

  // Update quest progress by category/condition
  Future<void> updateQuestsByCondition(int userId, String questCondition, {int progressIncrease = 1}) async {
    final today = DateTime.now().toUtc().toIso8601String().substring(0, 10);
    
    // Get quests matching the condition that are assigned today
    List<int> questIdsToUpdate = [];
    
    // Map condition types to quest names/patterns
    switch (questCondition) {
      case 'lesson_complete':
        // Update all lesson-related quests
        final lessonQuests = await _client
            .from('user_quests')
            .select('quest_id, quests!inner(id, name)')
            .eq('user_id', userId)
            .eq('assigned_date', today);
        
        for (var uq in lessonQuests) {
          final questName = (uq['quests'] as Map)['name'] as String;
          if (questName.toLowerCase().contains('lesson') || 
              questName.toLowerCase().contains('learner') ||
              questName.toLowerCase().contains('student') ||
              questName.toLowerCase().contains('scholar') ||
              questName.toLowerCase().contains('knowledge')) {
            questIdsToUpdate.add(uq['quest_id'] as int);
          }
        }
        break;
        
      case 'algebra_lesson':
        final algebraQuests = await _client
            .from('user_quests')
            .select('quest_id, quests!inner(id, name)')
            .eq('user_id', userId)
            .eq('assigned_date', today);
        for (var uq in algebraQuests) {
          final questName = (uq['quests'] as Map)['name'] as String;
          if (questName.toLowerCase().contains('algebra')) {
            questIdsToUpdate.add(uq['quest_id'] as int);
          }
        }
        break;
        
      case 'geometry_lesson':
        final geomQuests = await _client
            .from('user_quests')
            .select('quest_id, quests!inner(id, name)')
            .eq('user_id', userId)
            .eq('assigned_date', today);
        for (var uq in geomQuests) {
          final questName = (uq['quests'] as Map)['name'] as String;
          if (questName.toLowerCase().contains('geometry')) {
            questIdsToUpdate.add(uq['quest_id'] as int);
          }
        }
        break;
        
      case 'trig_lesson':
        final trigQuests = await _client
            .from('user_quests')
            .select('quest_id, quests!inner(id, name)')
            .eq('user_id', userId)
            .eq('assigned_date', today);
        for (var uq in trigQuests) {
          final questName = (uq['quests'] as Map)['name'] as String;
          if (questName.toLowerCase().contains('trig')) {
            questIdsToUpdate.add(uq['quest_id'] as int);
          }
        }
        break;
        
      case 'intalg_lesson':
        final intalgQuests = await _client
            .from('user_quests')
            .select('quest_id, quests!inner(id, name)')
            .eq('user_id', userId)
            .eq('assigned_date', today);
        for (var uq in intalgQuests) {
          final questName = (uq['quests'] as Map)['name'] as String;
          if (questName.toLowerCase().contains('int.') || 
              questName.toLowerCase().contains('intermediate')) {
            questIdsToUpdate.add(uq['quest_id'] as int);
          }
        }
        break;
        
      case 'mistake_fixed':
        final mistakeQuests = await _client
            .from('user_quests')
            .select('quest_id, quests!inner(id, name)')
            .eq('user_id', userId)
            .eq('assigned_date', today);
        for (var uq in mistakeQuests) {
          final questName = (uq['quests'] as Map)['name'] as String;
          if (questName.toLowerCase().contains('mistake') || 
              questName.toLowerCase().contains('error') ||
              questName.toLowerCase().contains('perfectionist') ||
              questName.toLowerCase().contains('fix')) {
            questIdsToUpdate.add(uq['quest_id'] as int);
          }
        }
        break;
        
      case 'correct_answer':
        final answerQuests = await _client
            .from('user_quests')
            .select('quest_id, quests!inner(id, name)')
            .eq('user_id', userId)
            .eq('assigned_date', today);
        for (var uq in answerQuests) {
          final questName = (uq['quests'] as Map)['name'] as String;
          if (questName.toLowerCase().contains('answer') || 
              questName.toLowerCase().contains('first steps') ||
              questName.toLowerCase().contains('warmed up') ||
              questName.toLowerCase().contains('roll') ||
              questName.toLowerCase().contains('machine')) {
            questIdsToUpdate.add(uq['quest_id'] as int);
          }
        }
        break;
        
      case 'xp_earned':
        final xpQuests = await _client
            .from('user_quests')
            .select('quest_id, quests!inner(id, name)')
            .eq('user_id', userId)
            .eq('assigned_date', today);
        for (var uq in xpQuests) {
          final questName = (uq['quests'] as Map)['name'] as String;
          if (questName.toLowerCase().contains('xp') || 
              questName.toLowerCase().contains('earn')) {
            questIdsToUpdate.add(uq['quest_id'] as int);
          }
        }
        break;
        
      case 'post_created':
        final postQuests = await _client
            .from('user_quests')
            .select('quest_id, quests!inner(id, name)')
            .eq('user_id', userId)
            .eq('assigned_date', today);
        for (var uq in postQuests) {
          final questName = (uq['quests'] as Map)['name'] as String;
          if (questName.toLowerCase().contains('post') || 
              questName.toLowerCase().contains('community contributor') ||
              questName.toLowerCase().contains('discussion')) {
            questIdsToUpdate.add(uq['quest_id'] as int);
          }
        }
        break;
        
      case 'like_given':
        final likeQuests = await _client
            .from('user_quests')
            .select('quest_id, quests!inner(id, name)')
            .eq('user_id', userId)
            .eq('assigned_date', today);
        for (var uq in likeQuests) {
          final questName = (uq['quests'] as Map)['name'] as String;
          if (questName.toLowerCase().contains('like') || 
              questName.toLowerCase().contains('friendly') ||
              questName.toLowerCase().contains('supportive')) {
            questIdsToUpdate.add(uq['quest_id'] as int);
          }
        }
        break;
        
      case 'comment_created':
        final commentQuests = await _client
            .from('user_quests')
            .select('quest_id, quests!inner(id, name)')
            .eq('user_id', userId)
            .eq('assigned_date', today);
        for (var uq in commentQuests) {
          final questName = (uq['quests'] as Map)['name'] as String;
          if (questName.toLowerCase().contains('comment') || 
              questName.toLowerCase().contains('conversationalist') ||
              questName.toLowerCase().contains('participant')) {
            questIdsToUpdate.add(uq['quest_id'] as int);
          }
        }
        break;
        
      case 'daily_login':
        final loginQuests = await _client
            .from('user_quests')
            .select('quest_id, quests!inner(id, name)')
            .eq('user_id', userId)
            .eq('assigned_date', today);
        for (var uq in loginQuests) {
          final questName = (uq['quests'] as Map)['name'] as String;
          if (questName.toLowerCase().contains('daily') || 
              questName.toLowerCase().contains('dedication') ||
              questName.toLowerCase().contains('log in')) {
            questIdsToUpdate.add(uq['quest_id'] as int);
          }
        }
        break;
        
      case 'streak_update':
        final streakQuests = await _client
            .from('user_quests')
            .select('quest_id, quests!inner(id, name, goal)')
            .eq('user_id', userId)
            .eq('assigned_date', today);
        for (var uq in streakQuests) {
          final questName = (uq['quests'] as Map)['name'] as String;
          if (questName.toLowerCase().contains('streak')) {
            questIdsToUpdate.add(uq['quest_id'] as int);
          }
        }
        break;
    }
    
    // Update progress for all matching quests
    for (var questId in questIdsToUpdate) {
      await updateUserQuestProgress(userId, questId, progressIncrease);
    }
  }

  // Update streak-based quests with actual streak value
  Future<void> updateStreakQuests(int userId, int currentStreak) async {
    final today = DateTime.now().toUtc().toIso8601String().substring(0, 10);
    
    final streakQuests = await _client
        .from('user_quests')
        .select('quest_id, quests!inner(id, name, goal)')
        .eq('user_id', userId)
        .eq('assigned_date', today);
    
    for (var uq in streakQuests) {
      final questName = (uq['quests'] as Map)['name'] as String;
      final goal = (uq['quests'] as Map)['goal'] as int;
      
      if (questName.toLowerCase().contains('streak')) {
        // Set progress to current streak (not incremental)
        final questId = uq['quest_id'] as int;
        bool completed = currentStreak >= goal;
        
        // Check if already completed
        final existingQuest = await _client
            .from('user_quests')
            .select('completed')
            .eq('user_id', userId)
            .eq('quest_id', questId)
            .eq('assigned_date', today)
            .maybeSingle();
        
        if (existingQuest != null && existingQuest['completed'] == true) continue;
        
        // Award XP if completing now
        if (completed) {
          final questData = await _client
              .from('quests')
              .select('xp')
              .eq('id', questId)
              .maybeSingle();
          
          if (questData != null) {
            final userData = await _client
                .from('users')
                .select('xp_quest')
                .eq('id', userId)
                .maybeSingle();
            
            int currentXp = userData?['xp_quest'] as int? ?? 0;
            int newXp = currentXp + (questData['xp'] as int);
            
            await _client
                .from('users')
                .update({'xp_quest': newXp})
                .eq('id', userId);
          }
        }
        
        await _client
            .from('user_quests')
            .update({
              'progress': currentStreak > goal ? goal : currentStreak,
              'completed': completed,
            })
            .eq('user_id', userId)
            .eq('quest_id', questId)
            .eq('assigned_date', today);
      }
    }
  }

  // Reset daily quests (called on login - now handles random quest assignment)
  Future<void> resetDailyQuests() async {
    // Initialize quests for today (will only assign if not already done)
    await initializeQuests();
    
    // Update daily login quest
    final userId = app_session.Session.instance.currentUserId;
    if (userId != null) {
      await updateQuestsByCondition(userId, 'daily_login');
    }
  }

  // Remove a mistake
  Future<void> removeMistake(int userId, int questionId) async {
    await _client
        .from('mistakes')
        .delete()
        .eq('user_id', userId)
        .eq('question_id', questionId);
  }

  // Get question ID by name and category
  Future<int?> getQuestionIdByNameAndCategory(String questionName, String category) async {
    final result = await _client
        .from('questions')
        .select('id')
        .eq('name', questionName)
        .eq('category', category)
        .maybeSingle();

    return result?['id'] as int?;
  }

  // Get question category by ID
  Future<String?> getQuestionCategoryById(int questionId) async {
    final result = await _client
        .from('questions')
        .select('category')
        .eq('id', questionId)
        .maybeSingle();

    return result?['category'] as String?;
  }

  // Award XP for correct answer
  Future<void> broDidntMessUp(int questionId, String questionType, int userId) async {
    final userData = await _client
        .from('users')
        .select('xp_algebra, xp_geometry, xp_intalg, xp_trig')
        .eq('id', userId)
        .maybeSingle();

    if (userData == null) return;

    Map<String, dynamic> updateData = {};

    if (questionType == "Algebra") {
      int currentXp = userData['xp_algebra'] as int? ?? 0;
      updateData['xp_algebra'] = currentXp + 10;
    } else if (questionType == "Geometry") {
      int currentXp = userData['xp_geometry'] as int? ?? 0;
      updateData['xp_geometry'] = currentXp + 10;
    } else if (questionType == "Intermediate Algebra") {
      int currentXp = userData['xp_intalg'] as int? ?? 0;
      updateData['xp_intalg'] = currentXp + 10;
    } else {
      int currentXp = userData['xp_trig'] as int? ?? 0;
      updateData['xp_trig'] = currentXp + 10;
    }

    await _client.from('users').update(updateData).eq('id', userId);
  }

  // Get user XP breakdown
  Future<Map<String, int>> getUserXp(int userId) async {
    final result = await _client
        .from('users')
        .select('xp_tot, xp_algebra, xp_geometry, xp_intalg, xp_trig')
        .eq('id', userId)
        .maybeSingle();

    if (result != null) {
      return {
        'xp_tot': result['xp_tot'] as int? ?? 0,
        'xp_algebra': result['xp_algebra'] as int? ?? 0,
        'xp_geometry': result['xp_geometry'] as int? ?? 0,
        'xp_intalg': result['xp_intalg'] as int? ?? 0,
        'xp_trig': result['xp_trig'] as int? ?? 0,
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

  // Check if user has liked content
  Future<bool> hasUserLiked(int contentId, String contentType) async {
    final userId = app_session.Session.instance.currentUserId;
    if (userId == null) return false;
    
    final result = await _client
        .from('user_likes')
        .select('id')
        .eq('user_id', userId)
        .eq('content_type', contentType)
        .eq('content_id', contentId)
        .maybeSingle();
    
    return result != null;
  }

  // Toggle like on content (post or comment) - returns new like count and liked status
  Future<Map<String, dynamic>> toggleLike(int contentId, String contentType) async {
    final userId = app_session.Session.instance.currentUserId;
    if (userId == null) return {'likes': 0, 'liked': false};
    
    String tableName = contentType == 'post' ? 'posts' : 'comments';
    
    // Check if already liked
    final existingLike = await _client
        .from('user_likes')
        .select('id')
        .eq('user_id', userId)
        .eq('content_type', contentType)
        .eq('content_id', contentId)
        .maybeSingle();
    
    // Get current like count
    final current = await _client
        .from(tableName)
        .select('likes')
        .eq('id', contentId)
        .maybeSingle();
    
    int currentLikes = current?['likes'] as int? ?? 0;
    bool nowLiked;
    
    if (existingLike != null) {
      // Unlike - remove the like
      await _client
          .from('user_likes')
          .delete()
          .eq('user_id', userId)
          .eq('content_type', contentType)
          .eq('content_id', contentId);
      
      currentLikes = (currentLikes - 1).clamp(0, 999999);
      nowLiked = false;
    } else {
      // Like - add the like
      await _client.from('user_likes').insert({
        'user_id': userId,
        'content_type': contentType,
        'content_id': contentId,
      });
      
      currentLikes++;
      nowLiked = true;
      
      // Update quest progress for giving likes (only when liking, not unliking)
      await updateQuestsByCondition(userId, 'like_given');
    }
    
    // Update the like count on the content
    await _client
        .from(tableName)
        .update({'likes': currentLikes})
        .eq('id', contentId);
    
    return {'likes': currentLikes, 'liked': nowLiked};
  }

  // Get comment count for a post
  Future<int> getCommentCount(int postId) async {
    final result = await _client
        .from('comments')
        .select('id')
        .eq('parent_id', postId);
    
    return (result as List).length;
  }

  // Get user friends with XP
  Future<Map<String, int>> getUserFriends(int userId) async {
    final result = await _client
        .from('users')
        .select('friends')
        .eq('id', userId)
        .maybeSingle();

    if (result == null || result['friends'] == null || result['friends'].toString().trim().isEmpty) {
      return {};
    }

    List<String> friendNames = (result['friends'] as String).split(',');
    Map<String, int> friends = {};

    for (String name in friendNames) {
      if (name.trim().isEmpty) continue;
      
      final friendData = await _client
          .from('users')
          .select('xp_tot')
          .eq('username', name.trim())
          .maybeSingle();

      friends[name.trim()] = friendData?['xp_tot'] as int? ?? 0;
    }

    return friends;
  }

  // Add a friend
  Future<void> addFriend(int userId, String friendName) async {
    final res = await _client
        .from('users')
        .select('friends')
        .eq('id', userId)
        .maybeSingle();

    String currFriends = res?['friends'] as String? ?? '';
    String newFriends = currFriends.isEmpty ? friendName : "$currFriends,$friendName";

    await _client
        .from('users')
        .update({'friends': newFriends})
        .eq('id', userId);
  }

  // Remove a friend
  Future<void> removeFriend(int userId, String friendName) async {
    final res = await _client
        .from('users')
        .select('friends')
        .eq('id', userId)
        .maybeSingle();

    String currFriends = res?['friends'] as String? ?? '';
    String newFriends = currFriends
        .replaceAll(RegExp(r'(^|,)' + RegExp.escape(friendName) + r'(?=,|$)'), '')
        .replaceAll(RegExp(r'^,|,$'), '');

    await _client
        .from('users')
        .update({'friends': newFriends})
        .eq('id', userId);
  }

  // Check if username exists
  Future<bool> checkExistence(String username) async {
    username = username.trim();
    final res = await _client
        .from('users')
        .select('id')
        .eq('username', username)
        .maybeSingle();
    return res != null;
  }

  // Insert user if not exists (for OAuth-like flows)
  Future<void> insertUserIfNotExists({required String username, required String email}) async {
    final existing = await _client
        .from('users')
        .select('id')
        .eq('username', username)
        .maybeSingle();

    if (existing == null) {
      final randomPass = generateRandomPassword(16);
      await _client.from('users').insert({
        'username': username,
        'email': email,
        'password': randomPass,
      });
    }
  }

  String generateRandomPassword(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz'
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        '0123456789'
        '!@#\$%^&*()-_=+[]{}|;:,.<>?';
    final rand = Random.secure();
    return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
  }

  // Insert questions if missing (for seeding)
  Future<void> insertQuestionsIfMissing(String category, List<Map<String, dynamic>> problems) async {
    final existing = await _client
        .from('questions')
        .select('id')
        .eq('category', category)
        .limit(1);

    if (existing.isEmpty) {
      for (var problem in problems) {
        await _client.from('questions').insert(problem);
      }
    }
  }
}
