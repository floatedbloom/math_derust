import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/session.dart';
import 'package:math_derust/theme/app_theme.dart';
import 'package:math_derust/widgets/mistake_lesson.dart';

class Mistakes extends StatefulWidget {
  const Mistakes({super.key});

  @override
  MistakesState createState() => MistakesState();
}

class MistakesState extends State<Mistakes> with SingleTickerProviderStateMixin {
  DbHelper db = DbHelper.instance;
  Map<String, List<Map<String, dynamic>>> mistakesByCategory = {};
  bool _isLoading = true;
  
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  // Category definitions
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Algebra',
      'icon': Icons.functions_rounded,
      'color': AppColors.algebraColor,
    },
    {
      'name': 'Geometry',
      'icon': Icons.change_history_rounded,
      'color': AppColors.geometryColor,
    },
    {
      'name': 'Trigonometry',
      'icon': Icons.circle_outlined,
      'color': AppColors.trigColor,
    },
    {
      'name': 'Calculus',
      'icon': Icons.integration_instructions_rounded,
      'color': AppColors.calculusColor,
    },
    {
      'name': 'Combinatorics',
      'icon': Icons.casino_rounded,
      'color': AppColors.combinatoricsColor,
    },
  ];

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
    _loadMistakes();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _loadMistakes() async {
    final allMistakes = await db.queryUserMistakes(Session.instance.currentUserId ?? 0);
    
    // Group by category
    Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var category in categories) {
      grouped[category['name']] = [];
    }
    
    for (var mistake in allMistakes) {
      final category = mistake['category'] ?? 'Algebra';
      if (grouped.containsKey(category)) {
        grouped[category]!.add(mistake);
      }
    }
    
    if (mounted) {
      setState(() {
        mistakesByCategory = grouped;
        _isLoading = false;
      });
    }
  }

  int get totalMistakes {
    int total = 0;
    for (var list in mistakesByCategory.values) {
      total += list.length;
    }
    return total;
  }

  void _startReview(String categoryName, List<Map<String, dynamic>> mistakes, Color color) async {
    if (mistakes.isEmpty) {
      showStyledSnackBar(context, 'No mistakes in this category!', isError: true);
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MistakeLessonWidget(
          category: categoryName,
          mistakes: mistakes,
          color: color,
          db: db,
        ),
      ),
    );
    
    // Reload mistakes after returning
    _loadMistakes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              )
            : totalMistakes == 0
                ? _buildEmptyState()
                : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          
          const GradientTitle(text: 'MISTAKES', fontSize: 24),
          
          const SizedBox(height: 8),
          
          Text(
            'Review and master your weak spots',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              letterSpacing: 0.5,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Summary card
          _buildSummaryCard(),
          
          const SizedBox(height: 32),
          
          Text(
            'BY CATEGORY',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Category cards
          ...categories.asMap().entries.map((entry) {
            final index = entry.key;
            final category = entry.value;
            final categoryMistakes = mistakesByCategory[category['name']] ?? [];
            
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
              child: _buildCategoryCard(
                category['name'],
                category['icon'],
                category['color'],
                categoryMistakes,
              ),
            );
          }),
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.error.withOpacity(0.15),
            AppColors.error.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.error.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$totalMistakes mistake${totalMistakes == 1 ? '' : 's'}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'to review across all categories',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          if (totalMistakes > 0)
            GestureDetector(
              onTap: _startAllReview,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: AppGradients.goldGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'FIX ALL',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundDark,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _startAllReview() {
    List<Map<String, dynamic>> allMistakes = [];
    for (var list in mistakesByCategory.values) {
      allMistakes.addAll(list);
    }
    
    if (allMistakes.isEmpty) return;
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MistakeLessonWidget(
          category: 'All Categories',
          mistakes: allMistakes,
          color: AppColors.gold,
          db: db,
        ),
      ),
    ).then((_) => _loadMistakes());
  }

  Widget _buildCategoryCard(
    String name,
    IconData icon,
    Color color,
    List<Map<String, dynamic>> mistakes,
  ) {
    final count = mistakes.length;
    final isEmpty = count == 0;
    
    return GestureDetector(
      onTap: isEmpty ? null : () => _startReview(name, mistakes, color),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isEmpty 
                ? Colors.grey.shade800.withOpacity(0.3)
                : color.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isEmpty
                    ? Colors.grey.shade800.withOpacity(0.3)
                    : color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: isEmpty ? Colors.grey.shade600 : color,
                size: 24,
              ),
            ),
            
            const SizedBox(width: 14),
            
            // Name and count
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isEmpty ? Colors.grey.shade500 : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isEmpty
                        ? 'No mistakes - Great job!'
                        : '$count mistake${count == 1 ? '' : 's'} to review',
                    style: TextStyle(
                      fontSize: 12,
                      color: isEmpty 
                          ? AppColors.success.withOpacity(0.7)
                          : Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            
            // Action
            if (!isEmpty)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: color,
                  size: 22,
                ),
              )
            else
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.success,
                  size: 22,
                ),
              ),
          ],
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
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.success.withOpacity(0.2),
                  AppColors.success.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.check_circle_outline_rounded,
              size: 50,
              color: AppColors.success,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'All Clear!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No mistakes to fix',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
