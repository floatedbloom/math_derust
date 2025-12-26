import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/session.dart';
import 'package:math_derust/theme/app_theme.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import 'package:flutter_math_fork/flutter_math.dart';

class QuestionWidget extends StatelessWidget {
  final String topic;
  final String name;
  final int difficulty;
  final String content;
  final String answers;
  final DbHelper db;

  const QuestionWidget({
    super.key,
    required this.topic,
    required this.name,
    required this.difficulty,
    required this.content,
    required this.answers,
    required this.db,
  });

  Color _getTopicColor() {
    switch (topic.toLowerCase()) {
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

  /// Parses a string with LaTeX delimiters and returns InlineSpan list.
  /// Supports \(...\) for inline math.
  List<InlineSpan> _parseLatexInline(String input, TextStyle textStyle) {
    // Debug: print the input to see actual escape sequences
    print('LaTeX input: $input');
    print('Input codeunits: ${input.codeUnits}');
    
    // Try matching \(...\) - handles both escaped and unescaped backslashes
    final regex = RegExp(r'\\+\((.*?)\\+\)');
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

    return spans;
  }

  void _showQuestion(BuildContext context, String topic, String name, String content, List<String> answers) {
    final color = _getTopicColor();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Topic badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: color.withOpacity(0.3)),
                      ),
                      child: Text(
                        topic,
                        style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Question title
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Difficulty stars
                    Row(
                      children: List.generate(
                        3,
                        (i) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: i < difficulty
                                ? AppColors.gold
                                : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
            // Question content
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundDark,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: color.withOpacity(0.2),
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: _parseLatexInline(
                            content,
                            TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    Text(
                      'SELECT YOUR ANSWER',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Answer buttons
                    ...answers.map((answer) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildAnswerButton(context, answer, name, topic, color),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerButton(BuildContext context, String answer, String questionName, String topic, Color color) {
    return GestureDetector(
      onTap: () async {
        bool isCorrect = await db.checkAnswer(questionName, answer, topic);
        if (isCorrect) {
          final userId = Session.instance.currentUserId ?? 0;
          int questionId = await db.getQuestionIdByNameAndCategory(questionName, topic) ?? 0;
          await db.broDidntMessUp(questionId, topic, userId);
          
          // Update quest progress for correct answers
          await db.updateQuestsByCondition(userId, 'correct_answer');
          // Update XP earned quests (10 XP per correct answer)
          await db.updateQuestsByCondition(userId, 'xp_earned', progressIncrease: 10);
        }
        Navigator.pop(context);
        await _showResultAnimation(context, isCorrect);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.backgroundDark,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: color.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.5), width: 2),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: _parseLatexInline(
                    answer,
                    const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showResultAnimation(BuildContext context, bool isCorrect) async {
    late BuildContext dialogContext;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black87,
      builder: (BuildContext ctx) {
        dialogContext = ctx;
        return Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.backgroundCard,
              borderRadius: BorderRadius.circular(24),
            ),
            child: RiveWidget.asset(
              isCorrect ? 'assets/checkmark_icon.riv' : 'assets/error_icon.riv',
            ),
          ),
        );
      },
    );

    await Future.delayed(const Duration(milliseconds: 1500));

    if (Navigator.canPop(dialogContext)) {
      Navigator.pop(dialogContext);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> answersSplit = answers.split(';');
    final color = _getTopicColor();
    
    return GestureDetector(
      onTap: () => _showQuestion(context, topic, name, content, answersSplit),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            // Left color indicator
            Container(
              width: 4,
              height: 60,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      // Difficulty
                      ...List.generate(
                        3,
                        (i) => Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: i < difficulty
                                ? AppColors.gold
                                : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Arrow
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: color,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
