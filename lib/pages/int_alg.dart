import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/widgets/question.dart';
import 'package:math_derust/theme/app_theme.dart';
import '../problems/int_alg_problems.dart';

class IntAlgPage extends StatefulWidget {
  const IntAlgPage({super.key});

  @override
  State<IntAlgPage> createState() => _IntAlgPageState();
}

class _IntAlgPageState extends State<IntAlgPage> with SingleTickerProviderStateMixin {
  DbHelper db = DbHelper.instance;
  List<Map<String, dynamic>> questions = [];
  List<Map<String, dynamic>> newProblems = intalgProblems;
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

  Future<void> _addProblems(List<Map<String, dynamic>> newProblems) async {
    for (Map<String, dynamic> newProblem in newProblems) {
      await db.insert('questions', newProblem);
    }
  }

  Future<void> _loadProblems() async {
    List<Map<String, dynamic>> questions = await db.queryWhere('questions', 'category', 'Intermediate Algebra');
    if (!mounted) return;
    setState(() {
      this.questions = questions;
      _isLoading = false;
    });
  }

  void _initializeProblems() async {
    await _addProblems(newProblems);
    await _loadProblems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          const AnimatedBackground(
            primaryColor: AppColors.intAlgColor,
            secondaryColor: Color(0xFF8B5A2B),
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
                              color: AppColors.intAlgColor,
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
                                'INT. ALGEBRA',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.intAlgColor,
                                  letterSpacing: 4,
                                ),
                              ),
                              Text(
                                '${questions.length} problems',
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
                            color: AppColors.intAlgColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.show_chart_rounded,
                            color: AppColors.intAlgColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Questions list
                  Expanded(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.intAlgColor,
                            ),
                          )
                        : questions.isEmpty
                            ? _buildEmptyState()
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.only(top: 8, bottom: 100),
                                itemCount: questions.length,
                                itemBuilder: (context, index) {
                                  return QuestionWidget(
                                    topic: 'Intermediate Algebra',
                                    name: questions[index]['name'],
                                    difficulty: questions[index]['difficulty'],
                                    content: questions[index]['content'],
                                    answers: questions[index]['answers'],
                                    db: db,
                                  );
                                },
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.intAlgColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.show_chart_rounded,
              size: 40,
              color: AppColors.intAlgColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No problems yet',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
