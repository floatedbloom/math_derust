import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/session.dart';
import 'package:math_derust/theme/app_theme.dart';

/// A lesson-style widget for reviewing mistakes
class MistakeLessonWidget extends StatefulWidget {
  final String category;
  final List<Map<String, dynamic>> mistakes;
  final Color color;
  final DbHelper db;

  const MistakeLessonWidget({
    super.key,
    required this.category,
    required this.mistakes,
    required this.color,
    required this.db,
  });

  @override
  State<MistakeLessonWidget> createState() => _MistakeLessonWidgetState();
}

class _MistakeLessonWidgetState extends State<MistakeLessonWidget> with TickerProviderStateMixin {
  int _currentIndex = 0;
  String? _selectedAnswer;
  bool? _lastAnswerCorrect;
  int _fixedCount = 0;
  
  late List<Map<String, dynamic>> _remainingMistakes;
  
  late AnimationController _fadeController;
  late AnimationController _resultController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _resultSlideAnimation;

  @override
  void initState() {
    super.initState();
    _remainingMistakes = List.from(widget.mistakes);
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
    
    _resultController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _resultSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _resultController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  Color _getQuestionColor(String? category) {
    switch (category?.toLowerCase()) {
      case 'algebra':
      case 'intermediate algebra':
        return AppColors.algebraColor;
      case 'geometry':
        return AppColors.geometryColor;
      case 'trigonometry':
        return AppColors.trigColor;
      case 'calculus':
        return AppColors.calculusColor;
      case 'combinatorics':
        return AppColors.combinatoricsColor;
      default:
        return widget.color;
    }
  }

  Future<void> _checkAnswer(String answer) async {
    if (_selectedAnswer != null) return;
    
    final question = _remainingMistakes[_currentIndex];
    final questionName = question['name'];
    final category = question['category'] ?? 'Algebra';
    
    setState(() {
      _selectedAnswer = answer;
    });

    bool isCorrect = await widget.db.checkAnswer(questionName, answer, category);
    
    if (isCorrect) {
      _fixedCount++;
      final userId = Session.instance.currentUserId ?? 0;
      int questionId = await widget.db.getQuestionIdByNameAndCategory(questionName, category) ?? 0;
      
      // Remove from mistakes
      await widget.db.removeMistake(userId, questionId);
      
      // Update quest progress
      await widget.db.updateQuestsByCondition(userId, 'mistake_fixed');
    }

    setState(() {
      _lastAnswerCorrect = isCorrect;
    });
    
    // Show result bar and auto-continue
    _resultController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted && _lastAnswerCorrect != null) {
          _continueToNext();
        }
      });
    });
  }

  void _continueToNext() {
    if (_lastAnswerCorrect == null) return;
    
    final wasCorrect = _lastAnswerCorrect!;
    _resultController.reverse();
    
    // If wrong, move question to end of queue
    if (!wasCorrect) {
      final question = _remainingMistakes[_currentIndex];
      _remainingMistakes.add(Map.from(question));
    }
    
    if (_currentIndex < _remainingMistakes.length - 1) {
      _fadeController.reset();
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _lastAnswerCorrect = null;
      });
      _fadeController.forward();
    } else {
      _onComplete();
    }
  }

  void _onComplete() {
    _showCompletionSheet();
  }

  void _showCompletionSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.success.withOpacity(0.3),
                    AppColors.success.withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_fix_high_rounded,
                color: AppColors.success,
                size: 40,
              ),
            ),
            
            const SizedBox(height: 24),
            
            const Text(
              'Mistakes Fixed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'You corrected $_fixedCount mistake${_fixedCount == 1 ? '' : 's'}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
            ),
            
            const SizedBox(height: 32),
            
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close sheet
                Navigator.pop(context); // Return to mistakes list
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: AppGradients.goldGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'CONTINUE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.backgroundDark,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _remainingMistakes[_currentIndex];
    final answers = (question['answers'] as String).split(';');
    final questionColor = _getQuestionColor(question['category']);
    final progress = (_currentIndex + 1) / _remainingMistakes.length;
    
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          AnimatedBackground(
            primaryColor: questionColor,
            secondaryColor: questionColor.withOpacity(0.5),
          ),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showExitConfirmation(),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundCard,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // Progress
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.auto_fix_high_rounded,
                                      color: AppColors.gold,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${_currentIndex + 1}/${_remainingMistakes.length}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '$_fixedCount fixed',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: progress,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [questionColor, questionColor.withOpacity(0.7)],
                                    ),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Question content
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          
                          // Category badge
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: questionColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  question['category'] ?? 'Unknown',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: questionColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Difficulty
                              Row(
                                children: List.generate(
                                  3,
                                  (i) => Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: Icon(
                                      Icons.star_rounded,
                                      size: 14,
                                      color: i < (question['difficulty'] ?? 1)
                                          ? AppColors.gold
                                          : Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Question box
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundCard,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: questionColor.withOpacity(0.2),
                              ),
                            ),
                            child: Text(
                              question['content'] ?? '',
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                height: 1.5,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Answer options
                          ...answers.asMap().entries.map((entry) {
                            final index = entry.key;
                            final answer = entry.value;
                            return _buildAnswerOption(answer, index, questionColor, question);
                          }),
                          
                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Inline result bar
          if (_lastAnswerCorrect != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SlideTransition(
                position: _resultSlideAnimation,
                child: _buildResultBar(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnswerOption(String answer, int index, Color color, Map<String, dynamic> question) {
    final isSelected = _selectedAnswer == answer;
    final showingResult = _lastAnswerCorrect != null;
    
    final correctAnswer = question['correct'] as String?;
    final isCorrectAnswer = correctAnswer?.trim().toLowerCase() == answer.trim().toLowerCase();
    
    Color borderColor = Colors.grey.shade800.withOpacity(0.5);
    Color bgColor = AppColors.backgroundCard;
    IconData? trailingIcon;
    Color? trailingIconColor;
    
    if (showingResult) {
      if (isCorrectAnswer) {
        borderColor = AppColors.success;
        bgColor = AppColors.success.withOpacity(0.1);
        trailingIcon = Icons.check_circle_rounded;
        trailingIconColor = AppColors.success;
      } else if (isSelected && !_lastAnswerCorrect!) {
        borderColor = AppColors.error;
        bgColor = AppColors.error.withOpacity(0.1);
        trailingIcon = Icons.cancel_rounded;
        trailingIconColor = AppColors.error;
      }
    } else if (isSelected) {
      borderColor = color;
      bgColor = color.withOpacity(0.1);
    }
    
    final labels = ['A', 'B', 'C', 'D'];
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: _selectedAnswer == null ? () => _checkAnswer(answer) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: borderColor,
              width: isSelected || (showingResult && isCorrectAnswer) ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? color : Colors.grey.shade700,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    labels[index % 4],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? color : Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 14),
              
              Expanded(
                child: Text(
                  answer,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ),
              
              if (trailingIcon != null)
                Icon(trailingIcon, color: trailingIconColor, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultBar() {
    final isCorrect = _lastAnswerCorrect!;
    
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: isCorrect ? AppColors.success : AppColors.error,
        boxShadow: [
          BoxShadow(
            color: (isCorrect ? AppColors.success : AppColors.error).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCorrect ? Icons.check_rounded : Icons.close_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isCorrect ? 'Fixed!' : 'Not quite...',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  isCorrect ? 'Mistake removed!' : 'Let\'s try again later',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          GestureDetector(
            onTap: _continueToNext,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'CONTINUE',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isCorrect ? AppColors.success : AppColors.error,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Exit Review?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          _fixedCount > 0 
              ? 'You\'ve fixed $_fixedCount mistake${_fixedCount == 1 ? '' : 's'}. Exit now?'
              : 'Are you sure you want to exit?',
          style: TextStyle(color: Colors.grey.shade400),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'KEEP GOING',
              style: TextStyle(color: Colors.grey.shade400),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text(
              'EXIT',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

