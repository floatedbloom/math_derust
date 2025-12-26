import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/theme/app_theme.dart';
import 'package:math_derust/widgets/skill_tree_view.dart';
import '../problems/combinatorics_problems.dart';

class CombinatoricsPage extends StatefulWidget {
  const CombinatoricsPage({super.key});

  @override
  State<CombinatoricsPage> createState() => _CombinatoricsPageState();
}

class _CombinatoricsPageState extends State<CombinatoricsPage> with SingleTickerProviderStateMixin {
  DbHelper db = DbHelper.instance;
  List<Map<String, dynamic>> questions = [];
  bool _isLoading = true;
  
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _animController.forward();
    _initializeProblems();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _initializeProblems() async {
    await _loadProblems();
  }

  Future<void> _loadProblems() async {
    List<Map<String, dynamic>> questions = await db.queryWhere('questions', 'category', 'Combinatorics');
    if (!mounted) return;
    setState(() {
      this.questions = questions;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          const AnimatedBackground(
            primaryColor: AppColors.combinatoricsColor,
            secondaryColor: Color(0xFF2A9D8F),
          ),
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundCard,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.grey.shade800.withOpacity(0.3),
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: AppColors.combinatoricsColor,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'COMBINATORICS',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.combinatoricsColor,
                                  letterSpacing: 3,
                                ),
                              ),
                              Text(
                                '18 topics • ${questions.length} problems',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.combinatoricsColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.casino_rounded,
                            color: AppColors.combinatoricsColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Skill tree
                  Expanded(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.combinatoricsColor,
                            ),
                          )
                        : SkillTreeView(
                            subject: 'Combinatorics',
                            subjectColor: AppColors.combinatoricsColor,
                            allQuestions: questions,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

