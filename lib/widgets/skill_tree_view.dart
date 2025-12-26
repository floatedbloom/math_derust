import 'package:flutter/material.dart';
import 'package:math_derust/data/skill_tree.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/session.dart';
import 'package:math_derust/theme/app_theme.dart';
import 'package:math_derust/widgets/lesson.dart';

/// A skill tree visualization widget
class SkillTreeView extends StatefulWidget {
  final String subject;
  final Color subjectColor;
  final List<Map<String, dynamic>> allQuestions;

  const SkillTreeView({
    super.key,
    required this.subject,
    required this.subjectColor,
    required this.allQuestions,
  });

  @override
  State<SkillTreeView> createState() => _SkillTreeViewState();
}

class _SkillTreeViewState extends State<SkillTreeView> {
  final DbHelper db = DbHelper.instance;
  Set<int> completedTopics = {};
  Set<int> completedChallenges = {};
  Map<int, int> challengeBestScores = {};
  late List<SkillNode> skillTree;
  late List<SkillNode> regularNodes;
  late List<SkillNode> challengeNodes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    skillTree = getSkillTree(widget.subject);
    // Separate regular nodes from challenge nodes
    regularNodes = skillTree.where((n) => !n.isChallenge).toList();
    challengeNodes = skillTree.where((n) => n.isChallenge).toList();
    _loadCompletedTopics();
  }

  Future<void> _loadCompletedTopics() async {
    final userId = Session.instance.currentUserId;
    if (userId != null) {
      final completed = await db.getCompletedTopics(userId, widget.subject);
      final challengeProgress = await db.getChallengeProgress(userId, widget.subject);
      if (mounted) {
        setState(() {
          completedTopics = completed;
          completedChallenges = challengeProgress['completed'] as Set<int>;
          challengeBestScores = challengeProgress['bestScores'] as Map<int, int>;
          _isLoading = false;
        });
      }
    } else {
      setState(() => _isLoading = false);
    }
  }

  List<SkillNode> _getNodesAtTier(int tier) {
    // Organize regular nodes into tiers based on prerequisites
    Map<int, int> nodeTiers = {};
    
    for (var node in regularNodes) {
      if (node.prerequisites.isEmpty) {
        nodeTiers[node.id] = 0;
      }
    }
    
    // Iterate until all nodes have tiers
    bool changed = true;
    while (changed) {
      changed = false;
      for (var node in regularNodes) {
        if (nodeTiers.containsKey(node.id)) continue;
        
        // Check if all prerequisites have tiers
        bool allPrereqsHaveTiers = node.prerequisites.every(
          (prereq) => nodeTiers.containsKey(prereq)
        );
        
        if (allPrereqsHaveTiers) {
          int maxPrereqTier = node.prerequisites
              .map((p) => nodeTiers[p]!)
              .reduce((a, b) => a > b ? a : b);
          nodeTiers[node.id] = maxPrereqTier + 1;
          changed = true;
        }
      }
    }
    
    return regularNodes
        .where((node) => nodeTiers[node.id] == tier)
        .toList();
  }

  int _getMaxTier() {
    Map<int, int> nodeTiers = {};
    
    for (var node in regularNodes) {
      if (node.prerequisites.isEmpty) {
        nodeTiers[node.id] = 0;
      }
    }
    
    bool changed = true;
    while (changed) {
      changed = false;
      for (var node in regularNodes) {
        if (nodeTiers.containsKey(node.id)) continue;
        
        bool allPrereqsHaveTiers = node.prerequisites.every(
          (prereq) => nodeTiers.containsKey(prereq)
        );
        
        if (allPrereqsHaveTiers && node.prerequisites.isNotEmpty) {
          int maxPrereqTier = node.prerequisites
              .map((p) => nodeTiers[p]!)
              .reduce((a, b) => a > b ? a : b);
          nodeTiers[node.id] = maxPrereqTier + 1;
          changed = true;
        }
      }
    }
    
    return nodeTiers.values.isEmpty ? 0 : nodeTiers.values.reduce((a, b) => a > b ? a : b);
  }

  void _openTopic(SkillNode node) async {
    // For challenge nodes, filter by is_challenge flag
    final topicQuestions = widget.allQuestions
        .where((q) => q['topic'] == node.id && (q['is_challenge'] == node.isChallenge || (q['is_challenge'] == null && !node.isChallenge)))
        .toList();
    
    if (topicQuestions.isEmpty) {
      showStyledSnackBar(context, 'No questions available for this ${node.isChallenge ? 'challenge' : 'topic'} yet', isError: true);
      return;
    }

    final isCompleted = node.isChallenge 
        ? completedChallenges.contains(node.id)
        : completedTopics.contains(node.id);
    final bestScore = node.isChallenge ? challengeBestScores[node.id] : null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => node.isChallenge 
          ? _ChallengeDetailSheet(
              node: node,
              subjectColor: widget.subjectColor,
              questions: topicQuestions,
              isCompleted: isCompleted,
              bestScore: bestScore,
              onStartChallenge: () async {
                Navigator.pop(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonWidget(
                      questions: topicQuestions,
                      db: db,
                      topic: widget.subject,
                      topicId: node.id,
                      isChallenge: true,
                    ),
                  ),
                );
                _loadCompletedTopics();
              },
            )
          : _TopicDetailSheet(
              node: node,
              subjectColor: widget.subjectColor,
              questions: topicQuestions,
              isCompleted: isCompleted,
              onStartLesson: () async {
                Navigator.pop(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonWidget(
                      questions: topicQuestions,
                      db: db,
                      topic: widget.subject,
                      topicId: node.id,
                    ),
                  ),
                );
                // Refresh completed topics after returning
                _loadCompletedTopics();
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: widget.subjectColor,
        ),
      );
    }

    final maxTier = _getMaxTier();
    
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          // Start indicator
          _buildStartIndicator(),
          
          // Skill tree tiers (regular nodes only)
          for (int tier = 0; tier <= maxTier; tier++) ...[
            _buildTierConnector(),
            _buildTier(tier),
          ],
          
          // End indicator
          const SizedBox(height: 20),
          _buildEndIndicator(),
          
          // Challenge section (if there are challenge nodes)
          if (challengeNodes.isNotEmpty) ...[
            const SizedBox(height: 40),
            _buildChallengeSection(),
          ],
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildChallengeSection() {
    // Get the single challenge node
    final challengeNode = challengeNodes.first;
    final isCompleted = completedChallenges.contains(challengeNode.id);
    final bestScore = challengeBestScores[challengeNode.id];
    
    return GestureDetector(
      onTap: () => _openTopic(challengeNode),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isCompleted 
                ? challengeColor.withOpacity(0.6)
                : challengeColor.withOpacity(0.3),
            width: isCompleted ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: challengeColor.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // Fire icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    challengeColor.withOpacity(0.25),
                    challengeColor.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: challengeColor.withOpacity(0.4),
                ),
              ),
              child: Icon(
                isCompleted ? Icons.emoji_events_rounded : Icons.local_fire_department_rounded,
                color: challengeColor,
                size: 28,
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: const Text(
                          'Challenge',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: challengeColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: challengeColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'OPTIONAL',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: challengeColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isCompleted && bestScore != null
                        ? 'Best: $bestScore%'
                        : 'Extra-hard reasoning problems',
                    style: TextStyle(
                      fontSize: 12,
                      color: isCompleted ? challengeColor.withOpacity(0.7) : Colors.grey.shade500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Arrow or checkmark
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isCompleted
                    ? challengeColor.withOpacity(0.2)
                    : challengeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isCompleted ? Icons.star_rounded : Icons.arrow_forward_rounded,
                color: challengeColor,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.subjectColor.withOpacity(0.2),
            widget.subjectColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.subjectColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.play_arrow_rounded,
            color: widget.subjectColor,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'START HERE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: widget.subjectColor,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEndIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gold.withOpacity(0.2),
            AppColors.gold.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.3),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.emoji_events_rounded,
            color: AppColors.gold,
            size: 20,
          ),
          SizedBox(width: 8),
          Text(
            'MASTERY',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.gold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierConnector() {
    return Container(
      width: 3,
      height: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            widget.subjectColor.withOpacity(0.5),
            widget.subjectColor.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildTier(int tier) {
    final nodes = _getNodesAtTier(tier);
    
    if (nodes.isEmpty) return const SizedBox.shrink();
    
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: nodes.map((node) => _buildSkillNode(node)).toList(),
    );
  }

  Widget _buildSkillNode(SkillNode node) {
    final isCompleted = completedTopics.contains(node.id);
    
    return GestureDetector(
      onTap: () => _openTopic(node),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCompleted
                ? AppColors.success.withOpacity(0.5)
                : Colors.grey.shade800.withOpacity(0.3),
            width: isCompleted ? 2 : 1,
          ),
          boxShadow: [
            if (isCompleted)
              BoxShadow(
                color: AppColors.success.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon circle
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppColors.success.withOpacity(0.2)
                    : widget.subjectColor.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted
                      ? AppColors.success
                      : widget.subjectColor.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                isCompleted ? Icons.check_rounded : node.icon,
                color: isCompleted ? AppColors.success : widget.subjectColor,
                size: 22,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Short name
            Text(
              node.shortName,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isCompleted ? AppColors.success : Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            // Status indicator
            const SizedBox(height: 2),
            Text(
              isCompleted ? '✓ Done' : 'Tap to start',
              style: TextStyle(
                fontSize: 9,
                color: isCompleted 
                    ? AppColors.success.withOpacity(0.8)
                    : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Detail sheet for a topic
class _TopicDetailSheet extends StatelessWidget {
  final SkillNode node;
  final Color subjectColor;
  final List<Map<String, dynamic>> questions;
  final bool isCompleted;
  final VoidCallback onStartLesson;

  const _TopicDetailSheet({
    required this.node,
    required this.subjectColor,
    required this.questions,
    required this.isCompleted,
    required this.onStartLesson,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            
            // Topic icon with completion badge
            Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isCompleted
                          ? [AppColors.success.withOpacity(0.3), AppColors.success.withOpacity(0.15)]
                          : [subjectColor.withOpacity(0.3), subjectColor.withOpacity(0.15)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isCompleted 
                          ? AppColors.success.withOpacity(0.4)
                          : subjectColor.withOpacity(0.4),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    isCompleted ? Icons.check_rounded : node.icon,
                    color: isCompleted ? AppColors.success : subjectColor,
                    size: 40,
                  ),
                ),
                if (isCompleted)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Topic name
            Text(
              node.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 8),
            
            // Description
            Text(
              node.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
              textAlign: TextAlign.center,
            ),
            
            // Completion badge
            if (isCompleted) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.success.withOpacity(0.3)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded, color: AppColors.success, size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Completed',
                      style: TextStyle(
                        color: AppColors.success,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 24),
            
            // Stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat(
                  icon: Icons.quiz_rounded,
                  label: 'Questions',
                  value: '${questions.length}',
                ),
                _buildStat(
                  icon: Icons.star_rounded,
                  label: 'XP',
                  value: '+${questions.length * 10}',
                  valueColor: AppColors.gold,
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Difficulty breakdown
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.backgroundDark,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDifficultyChip('Easy', _countByDifficulty(1), const Color(0xFF81C784)),
                  _buildDifficultyChip('Medium', _countByDifficulty(2), const Color(0xFFFFB74D)),
                  _buildDifficultyChip('Hard', _countByDifficulty(3), const Color(0xFFFF5252)),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Start button
            GestureDetector(
              onTap: onStartLesson,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isCompleted
                        ? [AppColors.success, AppColors.success.withOpacity(0.8)]
                        : [subjectColor, subjectColor.withOpacity(0.8)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: subjectColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isCompleted ? Icons.replay_rounded : Icons.school_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isCompleted ? 'PRACTICE AGAIN' : 'START LEARNING',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  int _countByDifficulty(int difficulty) {
    return questions.where((q) => q['difficulty'] == difficulty).length;
  }

  Widget _buildStat({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey.shade500, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _buildDifficultyChip(String label, int count, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}

/// Detail sheet for a challenge
class _ChallengeDetailSheet extends StatelessWidget {
  final SkillNode node;
  final Color subjectColor;
  final List<Map<String, dynamic>> questions;
  final bool isCompleted;
  final int? bestScore;
  final VoidCallback onStartChallenge;

  const _ChallengeDetailSheet({
    required this.node,
    required this.subjectColor,
    required this.questions,
    required this.isCompleted,
    this.bestScore,
    required this.onStartChallenge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(
            color: challengeColor.withOpacity(0.3),
            width: 2,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar with gold accent
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: challengeColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Challenge badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    challengeColor.withOpacity(0.2),
                    challengeColor.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: challengeColor.withOpacity(0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.local_fire_department_rounded,
                    color: challengeColor,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'CHALLENGE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: challengeColor,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Challenge icon
            Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        challengeColor.withOpacity(0.3),
                        challengeColor.withOpacity(0.15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: challengeColor.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    isCompleted ? Icons.emoji_events_rounded : node.icon,
                    color: challengeColor,
                    size: 40,
                  ),
                ),
                if (isCompleted)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: challengeColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.star_rounded,
                        color: AppColors.backgroundDark,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Challenge name
            Text(
              node.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: challengeColor,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 8),
            
            // Description
            Text(
              node.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
              textAlign: TextAlign.center,
            ),
            
            // Best score badge (if completed)
            if (isCompleted && bestScore != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: challengeColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: challengeColor.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded, color: challengeColor, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Best Score: $bestScore%',
                      style: const TextStyle(
                        color: challengeColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 24),
            
            // Stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat(
                  icon: Icons.quiz_rounded,
                  label: 'Questions',
                  value: '${questions.length}',
                ),
                _buildStat(
                  icon: Icons.star_rounded,
                  label: 'Bonus XP',
                  value: '+${questions.length * 15}',
                  valueColor: challengeColor,
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Info box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.backgroundDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade800),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Colors.grey.shade500,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Challenges are optional and don\'t affect your mastery progress.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Start challenge button
            GestureDetector(
              onTap: onStartChallenge,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      challengeColor,
                      challengeColor.withOpacity(0.85),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: challengeColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isCompleted ? Icons.replay_rounded : Icons.local_fire_department_rounded,
                      color: AppColors.backgroundDark,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isCompleted ? 'TRY AGAIN' : 'START CHALLENGE',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.backgroundDark,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStat({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey.shade500, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}

