import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/theme/app_theme.dart';
import 'package:math_derust/widgets/skill_tree_view.dart';
import '../problems/calculus_problems.dart';

class CalculusPage extends StatefulWidget {
  const CalculusPage({super.key});

  @override
  State<CalculusPage> createState() => _CalculusPageState();
}

class _CalculusPageState extends State<CalculusPage> with SingleTickerProviderStateMixin {
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
    List<Map<String, dynamic>> questions = await db.queryWhere('questions', 'category', 'Calculus');
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
            primaryColor: AppColors.calculusColor,
            secondaryColor: Color(0xFF5E4B8B),
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
                              color: AppColors.calculusColor,
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
                                'CALCULUS',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.calculusColor,
                                  letterSpacing: 4,
                                ),
                              ),
                              Text(
                                '25 topics • ${questions.length} problems',
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
                            color: AppColors.calculusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.integration_instructions_rounded,
                            color: AppColors.calculusColor,
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
                              color: AppColors.calculusColor,
                            ),
                          )
                        : SkillTreeView(
                            subject: 'Calculus',
                            subjectColor: AppColors.calculusColor,
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

