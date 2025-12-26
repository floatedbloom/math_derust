import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/theme/app_theme.dart';
import 'package:math_derust/widgets/skill_tree_view.dart';
import '../problems/algebra_problems.dart';

class AlgebraPage extends StatefulWidget {
  const AlgebraPage({super.key});

  @override
  State<AlgebraPage> createState() => _AlgebraPageState();
}

class _AlgebraPageState extends State<AlgebraPage> with SingleTickerProviderStateMixin {
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
    List<Map<String, dynamic>> questions = await db.queryWhere('questions', 'category', 'Algebra');
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
            primaryColor: AppColors.algebraColor,
            secondaryColor: Color(0xFF78909C),
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
                              color: AppColors.algebraColor,
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
                                'ALGEBRA',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.algebraColor,
                                  letterSpacing: 4,
                                ),
                              ),
                              Text(
                                '20 topics • ${questions.length} problems',
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
                            color: AppColors.algebraColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.functions_rounded,
                            color: AppColors.algebraColor,
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
                              color: AppColors.algebraColor,
                            ),
                          )
                        : SkillTreeView(
                            subject: 'Algebra',
                            subjectColor: AppColors.algebraColor,
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
