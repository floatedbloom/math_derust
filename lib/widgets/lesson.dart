import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/session.dart';
import 'package:math_derust/theme/app_theme.dart';

class LessonWidget extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final DbHelper db;
  final String? topic;
  final int? topicId;
  final bool isChallenge;

  const LessonWidget({
    super.key,
    required this.questions,
    required this.db,
    this.topic,
    this.topicId,
    this.isChallenge = false,
  });

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> with TickerProviderStateMixin {
  int _currentIndex = 0;
  String? _selectedAnswer;
  bool? _lastAnswerCorrect;
  int _correctCount = 0;
  
  // Track questions for retry phase
  List<Map<String, dynamic>> _currentQuestions = [];
  List<Map<String, dynamic>> _incorrectQuestions = [];
  bool _isRetryPhase = false;
  
  // Shuffled answers for current question (to avoid re-shuffling on rebuild)
  // Cache shuffled answers by index to ensure consistency
  final Map<int, List<String>> _shuffledAnswersCache = {};
  
  late AnimationController _fadeController;
  late AnimationController _resultController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _resultSlideAnimation;

  @override
  void initState() {
    super.initState();
    _currentQuestions = List.from(widget.questions);

    // Cache will be populated on demand
    
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

  List<String> _getShuffledAnswers(int index) {
    if (!_shuffledAnswersCache.containsKey(index)) {
      final question = _currentQuestions[index];
      _shuffledAnswersCache[index] = (question['answers'] as String).split(';')..shuffle(Random());
    }
    return _shuffledAnswersCache[index]!;
  }

  // Challenge gold color
  static const Color _challengeColor = Color(0xFFFFD700);

  /// Parses a string with LaTeX delimiters and returns InlineSpan list.
  /// Supports \(...\) for inline math.
  List<InlineSpan> _parseLatexInline(String input, TextStyle textStyle) {
    // Match \(...\) for inline LaTeX
    final regex = RegExp(r'\\\((.+?)\\\)');
    final spans = <InlineSpan>[];

    int currentIndex = 0;

    for (final match in regex.allMatches(input)) {
      if (match.start > currentIndex) {
        spans.add(
          TextSpan(
            text: input.substring(currentIndex, match.start),
            style: textStyle,
          ),
        );
      }

      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Math.tex(
            match.group(1)!.trim(),
            textStyle: textStyle,
          ),
        ),
      );

      currentIndex = match.end;
    }

    if (currentIndex < input.length) {
      spans.add(
        TextSpan(
          text: input.substring(currentIndex),
          style: textStyle,
        ),
      );
    }

    // If no matches, return single TextSpan
    if (spans.isEmpty) {
      spans.add(TextSpan(text: input, style: textStyle));
    }

    return spans;
  }
  
  Color _getTopicColor() {
    // Challenges always use gold color
    if (widget.isChallenge) {
      return _challengeColor;
    }
    
    final topic = widget.topic ?? 
        (_currentQuestions.isNotEmpty ? _currentQuestions.first['category'] : 'Algebra');
    switch (topic.toString().toLowerCase()) {
      case 'algebra':
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
        return AppColors.goldMuted;
    }
  }

  Future<void> _checkAnswer(String answer) async {
    if (_selectedAnswer != null) return;
    
    final question = _currentQuestions[_currentIndex];
    final questionName = question['name'];
    final category = question['category'] ?? widget.topic ?? 'Algebra';
    
    setState(() {
      _selectedAnswer = answer;
    });

    // Check answer (this also adds to mistakes automatically if wrong)
    bool isCorrect = await widget.db.checkAnswer(questionName, answer, category);
    
    if (isCorrect) {
      _correctCount++;
      final userId = Session.instance.currentUserId ?? 0;
      int questionId = await widget.db.getQuestionIdByNameAndCategory(questionName, category) ?? 0;
      await widget.db.broDidntMessUp(questionId, category, userId);
      
      // Update quest progress
      await widget.db.updateQuestsByCondition(userId, 'correct_answer');
      await widget.db.updateQuestsByCondition(userId, 'xp_earned', progressIncrease: 10);
    } else {
      // Track for retry phase (only in first phase)
      if (!_isRetryPhase) {
        _incorrectQuestions.add(question);
      }
    }

    setState(() {
      _lastAnswerCorrect = isCorrect;
    });
    
    // Show result bar and auto-continue after delay
    _resultController.forward().then((_) {
      // Wait 0.3s after animation completes, then auto-continue
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted && _lastAnswerCorrect != null) {
          _continueToNext();
        }
      });
    });
  }

  void _continueToNext() {
    if (_lastAnswerCorrect == null) return; // Already continued
    _resultController.reverse();
    
    if (_currentIndex < _currentQuestions.length - 1) {
      _fadeController.reset();
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _lastAnswerCorrect = null;
      });
      _fadeController.forward();
    } else {
      // End of current phase
      if (!_isRetryPhase && _incorrectQuestions.isNotEmpty) {
        // Start retry phase
        _fadeController.reset();
  
        setState(() {
          _isRetryPhase = true;
          _currentQuestions = List.from(_incorrectQuestions);
          _incorrectQuestions.clear();
          // Clear cache for retry phase as indices and questions changed
          _shuffledAnswersCache.clear();
          _currentIndex = 0;
          _selectedAnswer = null;
          _lastAnswerCorrect = null;
        });
        _fadeController.forward();
        _showRetryMessage();
      } else {
        _onLessonComplete();
      }
    }
  }

  void _showRetryMessage() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.replay_rounded, color: AppColors.gold),
            const SizedBox(width: 12),
            const Text('Let\'s try again!', style: TextStyle(color: Colors.white)),
          ],
        ),
        content: Text(
          'You got ${_currentQuestions.length} question${_currentQuestions.length > 1 ? 's' : ''} wrong. Let\'s review them.',
          style: TextStyle(color: Colors.grey.shade400),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CONTINUE', style: TextStyle(color: AppColors.gold)),
          ),
        ],
      ),
    );
  }

  Future<void> _onLessonComplete() async {
    final userId = Session.instance.currentUserId;
    if (userId != null) {
      if (widget.isChallenge) {
        // Handle challenge completion
        if (widget.topicId != null && widget.topic != null) {
          await widget.db.updateChallengeProgress(
            userId, 
            widget.topic!, 
            widget.topicId!, 
            _correctCount, 
            widget.questions.length,
          );
        }
      } else {
        // Handle regular lesson completion
        await widget.db.updateQuestsByCondition(userId, 'lesson_complete');
        
        // Mark topic as completed
        if (widget.topicId != null && widget.topic != null) {
          await widget.db.markTopicCompleted(userId, widget.topic!, widget.topicId!);
        }
        
        final topic = widget.topic ?? 
            (widget.questions.isNotEmpty ? widget.questions.first['category'] : null);
        if (topic != null) {
          switch (topic.toLowerCase()) {
            case 'algebra':
              await widget.db.updateQuestsByCondition(userId, 'algebra_lesson');
              break;
            case 'geometry':
              await widget.db.updateQuestsByCondition(userId, 'geometry_lesson');
              break;
            case 'trigonometry':
              await widget.db.updateQuestsByCondition(userId, 'trig_lesson');
              break;
            case 'calculus':
              await widget.db.updateQuestsByCondition(userId, 'calculus_lesson');
              break;
            case 'combinatorics':
              await widget.db.updateQuestsByCondition(userId, 'combinatorics_lesson');
              break;
          }
        }
      }
    }
    
    if (!mounted) return;
    
    if (widget.isChallenge) {
      _showChallengeCompletionSheet();
    } else {
      _showCompletionSheet();
    }
  }

  void _showCompletionSheet() {
    final color = _getTopicColor();
    final total = widget.questions.length;
    
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
            // Trophy icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gold.withOpacity(0.3),
                    AppColors.gold.withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                color: AppColors.gold,
                size: 40,
              ),
            ),
            
            const SizedBox(height: 24),
            
            const Text(
              'Topic Complete!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCompletionStat('Questions', '$total', color),
                _buildCompletionStat('XP Earned', '+${_correctCount * 10}', AppColors.gold),
              ],
            ),
            
            const SizedBox(height: 32),
            
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close sheet
                Navigator.pop(context); // Return to topic list
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

  Widget _buildCompletionStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  void _showChallengeCompletionSheet() {
    final total = widget.questions.length;
    final percentage = (((_correctCount / total) * 100).round());
    final passed = percentage >= 70;
    final bonusXp = _correctCount * 15; // Challenges give 15 XP per correct answer
    
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(
            top: BorderSide(
              color: passed ? _challengeColor.withOpacity(0.5) : AppColors.error.withOpacity(0.5),
              width: 2,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Challenge badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: _challengeColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _challengeColor.withOpacity(0.3)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_fire_department_rounded,
                    color: _challengeColor,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'CHALLENGE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: _challengeColor,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Result icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: passed
                      ? [_challengeColor.withOpacity(0.3), _challengeColor.withOpacity(0.1)]
                      : [AppColors.error.withOpacity(0.3), AppColors.error.withOpacity(0.1)],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                passed ? Icons.emoji_events_rounded : Icons.replay_rounded,
                color: passed ? _challengeColor : AppColors.error,
                size: 40,
              ),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              passed ? 'Challenge Complete!' : 'Challenge Failed',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: passed ? _challengeColor : Colors.white,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              passed 
                  ? 'You scored $percentage%!'
                  : 'You need 70% to pass. Try again!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCompletionStat('Score', '$percentage%', passed ? _challengeColor : AppColors.error),
                _buildCompletionStat('Correct', '$_correctCount/$total', Colors.white),
                if (passed)
                  _buildCompletionStat('Bonus XP', '+$bonusXp', _challengeColor),
              ],
            ),
            
            const SizedBox(height: 32),
            
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close sheet
                Navigator.pop(context); // Return to topic list
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: passed 
                        ? [_challengeColor, _challengeColor.withOpacity(0.85)]
                        : [AppColors.error, AppColors.error.withOpacity(0.85)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'CONTINUE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: passed ? AppColors.backgroundDark : Colors.white,
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
    final color = _getTopicColor();
    final question = _currentQuestions[_currentIndex];
    final answers = _getShuffledAnswers(_currentIndex);
    final totalInPhase = _currentQuestions.length;
    final progress = (_currentIndex + 1) / totalInPhase;
    
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          AnimatedBackground(
            primaryColor: color,
            secondaryColor: color.withOpacity(0.5),
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
                      
                      // Progress bar
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    if (_isRetryPhase) ...[
                                      const Icon(Icons.replay_rounded, 
                                        color: AppColors.gold, size: 14),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Retry ${_currentIndex + 1}/$totalInPhase',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.gold,
                                        ),
                                      ),
                                    ] else
                                      Text(
                                        '${_currentIndex + 1}/$totalInPhase',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  '+${_correctCount * 10} XP',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.gold,
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
                                      colors: _isRetryPhase
                                          ? [AppColors.gold, AppColors.goldMuted]
                                          : [color, color.withOpacity(0.7)],
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
                          
                          // Difficulty
                          Row(
                            children: [
                              ...List.generate(
                                3,
                                (i) => Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Icon(
                                    Icons.star_rounded,
                                    size: 16,
                                    color: i < (question['difficulty'] ?? 1)
                                        ? AppColors.gold
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Question box
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundCard,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: color.withOpacity(0.2),
                              ),
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: _parseLatexInline(
                                  question['content'] ?? '',
                                  const TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Answer options
                          ...answers.asMap().entries.map((entry) {
                            final index = entry.key;
                            final answer = entry.value;
                            return _buildAnswerOption(answer, index, color);
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
          
          // Inline result bar at bottom
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

  Widget _buildAnswerOption(String answer, int index, Color color) {
    final isSelected = _selectedAnswer == answer;
    final showingResult = _lastAnswerCorrect != null;
    
    // Determine correct answer for highlighting
    final question = _currentQuestions[_currentIndex];
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
              // Letter circle
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
              
              // Answer text
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: _parseLatexInline(
                      answer,
                      TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              
              // Result icon
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
          // Icon
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
          
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isCorrect ? 'Correct!' : 'Incorrect',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (isCorrect)
                  const Text(
                    '+10 XP',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
              ],
            ),
          ),
          
          // Continue button
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
          'Exit Lesson?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Your progress will not be saved.',
          style: TextStyle(color: Colors.grey.shade400),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'CANCEL',
              style: TextStyle(color: Colors.grey.shade400),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Exit lesson
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
