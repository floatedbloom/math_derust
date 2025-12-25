import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/theme/app_theme.dart';

import '../session.dart';

class Quests extends StatefulWidget {
  const Quests({super.key});

  @override
  QuestsState createState() => QuestsState();
}

class QuestsState extends State<Quests> with SingleTickerProviderStateMixin {
  DbHelper db = DbHelper.instance;
  List<Map<String, dynamic>> quests = [];
  
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  // Icon mapping from string names to IconData
  static const Map<String, IconData> iconMap = {
    'star': Icons.star_rounded,
    'stars': Icons.stars_rounded,
    'book': Icons.book_rounded,
    'school': Icons.school_rounded,
    'menu_book': Icons.menu_book_rounded,
    'auto_stories': Icons.auto_stories_rounded,
    'functions': Icons.functions_rounded,
    'category': Icons.category_rounded,
    'show_chart': Icons.show_chart_rounded,
    'analytics': Icons.analytics_rounded,
    'build': Icons.build_rounded,
    'construction': Icons.construction_rounded,
    'precision_manufacturing': Icons.precision_manufacturing_rounded,
    'check_circle': Icons.check_circle_rounded,
    'verified': Icons.verified_rounded,
    'task_alt': Icons.task_alt_rounded,
    'military_tech': Icons.military_tech_rounded,
    'workspace_premium': Icons.workspace_premium_rounded,
    'edit_note': Icons.edit_note_rounded,
    'forum': Icons.forum_rounded,
    'favorite': Icons.favorite_rounded,
    'thumb_up': Icons.thumb_up_rounded,
    'comment': Icons.comment_rounded,
    'chat': Icons.chat_rounded,
    'today': Icons.today_rounded,
    'local_fire_department': Icons.local_fire_department_rounded,
    'whatshot': Icons.whatshot_rounded,
  };

  // Category colors
  static const Map<String, Color> categoryColors = {
    'learning': Color(0xFF4CAF50),
    'subject': Color(0xFF2196F3),
    'practice': Color(0xFFFF9800),
    'accuracy': Color(0xFF9C27B0),
    'achievement': Color(0xFFD4AF37),
    'social': Color(0xFFE91E63),
    'streak': Color(0xFFFF5722),
  };

  // Category display names
  static const Map<String, String> categoryNames = {
    'learning': 'Learning',
    'subject': 'Subject',
    'practice': 'Practice',
    'accuracy': 'Accuracy',
    'achievement': 'Achievement',
    'social': 'Social',
    'streak': 'Streak',
  };

  // Category descriptions for the detail sheet
  static const Map<String, String> categoryDescriptions = {
    'learning': 'Complete lessons to expand your knowledge and master new concepts.',
    'subject': 'Focus on specific math subjects to become an expert in that area.',
    'practice': 'Review and fix your mistakes to improve your understanding.',
    'accuracy': 'Answer questions correctly to demonstrate your skills.',
    'achievement': 'Earn XP by completing activities throughout the app.',
    'social': 'Engage with the community through social interactions.',
    'streak': 'Log in consistently to build and maintain your streak.',
  };

  // Tips for completing quests - will be customized based on quest name
  static const Map<String, String> categoryTips = {
    'learning': '💡 Start a lesson from the Learn tab to make progress.',
    'subject': '💡 Choose lessons from the specific subject to complete this quest.',
    'practice': '💡 Go to the Mistakes tab to review and correct your errors.',
    'accuracy': '💡 Take your time with questions - accuracy matters more than speed!',
    'achievement': '💡 Every correct answer earns you 10 XP towards this goal.',
    'social': '💡 Visit the Community tab to interact with other learners.',
    'streak': '💡 Log in every day to keep your streak going!',
  };

  // Get a specific tip based on quest name
  String _getQuestTip(String questName, String category) {
    final nameLower = questName.toLowerCase();
    
    if (nameLower.contains('comment') || nameLower.contains('conversationalist') || nameLower.contains('participant')) {
      return '💡 Write comments on posts in the Community tab.';
    } else if (nameLower.contains('post') || nameLower.contains('contributor') || nameLower.contains('discussion')) {
      return '💡 Create new posts in the Community tab.';
    } else if (nameLower.contains('like') || nameLower.contains('friendly') || nameLower.contains('supportive')) {
      return '💡 Like posts and comments in the Community tab.';
    }
    
    return categoryTips[category] ?? '';
  }

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _animController.forward();
    loadQuests();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> loadQuests() async {
    await db.initializeQuests();
    List<Map<String, dynamic>> data = await db.getUserQuests(Session.instance.currentUserId ?? 0);
    if (mounted) {
      setState(() {
        // Sort: incomplete first, then by category
        data.sort((a, b) {
          final aCompleted = a['completed'] == 1;
          final bCompleted = b['completed'] == 1;
          if (aCompleted != bCompleted) return aCompleted ? 1 : -1;
          return (a['category'] as String).compareTo(b['category'] as String);
        });
        quests = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              
              const GradientTitle(text: 'QUESTS', fontSize: 24),
              
              const SizedBox(height: 16),
              
              Text(
                'Complete daily challenges',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  letterSpacing: 0.5,
                ),
              ),
              
              const SizedBox(height: 30),
              
              Expanded(
                child: quests.isEmpty
                    ? _buildEmptyState()
                    : RefreshIndicator(
                        onRefresh: loadQuests,
                        color: AppColors.gold,
                        backgroundColor: AppColors.backgroundCard,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          itemCount: quests.length + 1, // +1 for header
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return _buildQuestSummary();
                            }
                            return _buildQuestCard(quests[index - 1], index - 1);
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.emoji_events_outlined,
              size: 40,
              color: AppColors.goldMuted,
            ),
          ),
          const SizedBox(height: 20),
          const CircularProgressIndicator(color: AppColors.gold),
          const SizedBox(height: 16),
          Text(
            'Loading quests...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestSummary() {
    final completedCount = quests.where((q) => q['completed'] == 1).length;
    final totalCount = quests.length;
    final totalXpAvailable = quests.fold<int>(0, (sum, q) => sum + (q['xp'] as int));
    final xpEarned = quests
        .where((q) => q['completed'] == 1)
        .fold<int>(0, (sum, q) => sum + (q['xp'] as int));
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.gold.withOpacity(0.15),
            AppColors.goldDark.withOpacity(0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.25),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s Progress',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade400,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '$completedCount',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gold,
                        ),
                      ),
                      Text(
                        ' / $totalCount',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.backgroundDark,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.gold.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.gold,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$xpEarned / $totalXpAvailable XP',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Container(
                  height: 10,
                  width: double.infinity,
                  color: AppColors.backgroundDark,
                ),
                FractionallySizedBox(
                  widthFactor: totalCount > 0 ? completedCount / totalCount : 0,
                  child: Container(
                    height: 10,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.gold, AppColors.goldDark],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (completedCount == totalCount && totalCount > 0) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.celebration_rounded,
                    color: AppColors.success,
                    size: 16,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'All quests completed!',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showQuestDetails(Map<String, dynamic> quest) {
    final name = quest['name'] as String;
    final xp = quest['xp'] as int;
    final progress = quest['progress'] as int;
    final completed = quest['completed'] as int;
    final goal = quest['goal'] as int;
    final category = quest['category'] as String? ?? 'achievement';
    final difficulty = quest['difficulty'] as String? ?? 'easy';
    final iconName = quest['icon'] as String? ?? 'star';
    
    final isCompleted = completed > 0;
    final progressPercent = goal > 0 ? (progress / goal).clamp(0.0, 1.0) : 0.0;
    final categoryColor = categoryColors[category] ?? AppColors.gold;
    final questIcon = iconMap[iconName] ?? Icons.star_rounded;
    final description = categoryDescriptions[category] ?? '';
    final tip = _getQuestTip(name, category);
    
    String difficultyLabel;
    Color difficultyColor;
    switch (difficulty) {
      case 'hard':
        difficultyLabel = 'Hard';
        difficultyColor = const Color(0xFFFF5252);
        break;
      case 'medium':
        difficultyLabel = 'Medium';
        difficultyColor = const Color(0xFFFFB74D);
        break;
      default:
        difficultyLabel = 'Easy';
        difficultyColor = const Color(0xFF81C784);
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Quest icon large
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: isCompleted
                      ? const LinearGradient(
                          colors: [AppColors.success, Color(0xFF2E7D32)],
                        )
                      : LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            categoryColor.withOpacity(0.3),
                            categoryColor.withOpacity(0.15),
                          ],
                        ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isCompleted 
                        ? AppColors.success.withOpacity(0.5) 
                        : categoryColor.withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: Icon(
                  isCompleted ? Icons.check_rounded : questIcon,
                  color: isCompleted ? Colors.white : categoryColor,
                  size: 40,
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Quest name
              Text(
                name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isCompleted ? Colors.grey.shade400 : Colors.white,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 12),
              
              // Category and difficulty row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: categoryColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      categoryNames[category] ?? category,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: categoryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: difficultyColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      difficultyLabel,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: difficultyColor,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Description
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 24),
              
              // Progress section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.backgroundDark,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '$progress / $goal',
                          style: TextStyle(
                            fontSize: 16,
                            color: isCompleted ? AppColors.success : categoryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        children: [
                          Container(
                            height: 12,
                            width: double.infinity,
                            color: Colors.grey.shade800,
                          ),
                          FractionallySizedBox(
                            widthFactor: progressPercent,
                            child: Container(
                              height: 12,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: isCompleted 
                                      ? [AppColors.success, const Color(0xFF2E7D32)]
                                      : [categoryColor, categoryColor.withOpacity(0.7)],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 18,
                          color: AppColors.gold,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isCompleted ? 'Earned $xp XP!' : 'Reward: $xp XP',
                          style: TextStyle(
                            fontSize: 15,
                            color: isCompleted ? AppColors.gold : Colors.grey.shade300,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Tip section (only if not completed)
              if (!isCompleted && tip.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: categoryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    tip,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade300,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              
              // Status badge
              if (isCompleted) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.success,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Quest Completed!',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestCard(Map<String, dynamic> quest, int index) {
    final name = quest['name'] as String;
    final xp = quest['xp'] as int;
    final progress = quest['progress'] as int;
    final completed = quest['completed'] as int;
    final goal = quest['goal'] as int;
    final category = quest['category'] as String? ?? 'achievement';
    final difficulty = quest['difficulty'] as String? ?? 'easy';
    final iconName = quest['icon'] as String? ?? 'star';
    
    final isCompleted = completed > 0;
    final progressPercent = goal > 0 ? (progress / goal).clamp(0.0, 1.0) : 0.0;
    final categoryColor = categoryColors[category] ?? AppColors.gold;
    final questIcon = iconMap[iconName] ?? Icons.star_rounded;
    
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => _showQuestDetails(quest),
        child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isCompleted
                ? AppColors.success.withOpacity(0.4)
                : categoryColor.withOpacity(0.2),
          ),
          boxShadow: [
            if (isCompleted)
              BoxShadow(
                color: AppColors.success.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Quest icon with category color
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: isCompleted
                        ? const LinearGradient(
                            colors: [AppColors.success, Color(0xFF2E7D32)],
                          )
                        : LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              categoryColor.withOpacity(0.25),
                              categoryColor.withOpacity(0.1),
                            ],
                          ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isCompleted 
                          ? AppColors.success.withOpacity(0.5) 
                          : categoryColor.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    isCompleted ? Icons.check_rounded : questIcon,
                    color: isCompleted ? Colors.white : categoryColor,
                    size: 26,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Quest info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category badge and difficulty
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: categoryColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              categoryNames[category] ?? category,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: categoryColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          _buildDifficultyBadge(difficulty),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isCompleted ? Colors.grey.shade500 : Colors.white,
                          decoration: isCompleted ? TextDecoration.lineThrough : null,
                          decorationColor: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: AppColors.gold.withOpacity(0.8),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '+$xp XP',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Progress indicator
                if (!isCompleted)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDark,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: categoryColor.withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      '$progress / $goal',
                      style: TextStyle(
                        fontSize: 13,
                        color: categoryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.success.withOpacity(0.2),
                          AppColors.success.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.success.withOpacity(0.3),
                      ),
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.success,
                      size: 22,
                    ),
                  ),
              ],
            ),
            
            if (!isCompleted) ...[
              const SizedBox(height: 16),
              
              // Progress bar with category color
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  children: [
                    Container(
                      height: 8,
                      width: double.infinity,
                      color: AppColors.backgroundDark,
                    ),
                    FractionallySizedBox(
                      widthFactor: progressPercent,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [categoryColor, categoryColor.withOpacity(0.7)],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildDifficultyBadge(String difficulty) {
    Color bgColor;
    String label;
    
    switch (difficulty) {
      case 'hard':
        bgColor = const Color(0xFFFF5252);
        label = '★★★';
        break;
      case 'medium':
        bgColor = const Color(0xFFFFB74D);
        label = '★★';
        break;
      default:
        bgColor = const Color(0xFF81C784);
        label = '★';
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: bgColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
