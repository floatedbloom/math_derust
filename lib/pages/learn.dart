import 'package:flutter/material.dart';
import 'package:math_derust/theme/app_theme.dart';
import 'algebra.dart';
import 'calculus.dart';
import 'combinatorics.dart';
import 'geometry.dart';
import 'trig.dart';

class Learn extends StatefulWidget {
  const Learn({super.key});

  @override
  LearnState createState() => LearnState();
}

class LearnState extends State<Learn> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

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
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                
                const GradientTitle(text: 'LEARN', fontSize: 24),
                
                const SizedBox(height: 16),
                
                Text(
                  'Choose a subject to practice',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.5,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                _buildTopicCard(
                  name: 'Algebra',
                  description: 'Equations, expressions, and functions',
                  icon: Icons.functions_rounded,
                  secondaryIcon: Icons.calculate_rounded,
                  color: AppColors.algebraColor,
                  onTap: () => _navigateTo(const AlgebraPage()),
                ),
                
                const SizedBox(height: 16),
                
                _buildTopicCard(
                  name: 'Geometry',
                  description: 'Shapes, angles, and spatial reasoning',
                  icon: Icons.change_history_rounded,
                  secondaryIcon: Icons.straighten_rounded,
                  color: AppColors.geometryColor,
                  onTap: () => _navigateTo(const GeometryPage()),
                ),
                
                const SizedBox(height: 16),
                
                _buildTopicCard(
                  name: 'Trigonometry',
                  description: 'Triangles, circles, and waves',
                  icon: Icons.circle_outlined,
                  secondaryIcon: Icons.square_foot_rounded,
                  color: AppColors.trigColor,
                  onTap: () => _navigateTo(const TrigPage()),
                ),
                
                const SizedBox(height: 16),
                
                _buildTopicCard(
                  name: 'Combinatorics',
                  description: 'Counting, permutations, and probability',
                  icon: Icons.casino_rounded,
                  secondaryIcon: Icons.pie_chart_rounded,
                  color: AppColors.combinatoricsColor,
                  onTap: () => _navigateTo(const CombinatoricsPage()),
                ),
                
                const SizedBox(height: 16),
                
                _buildTopicCard(
                  name: 'Calculus',
                  description: 'Limits, derivatives, integrals, and series',
                  icon: Icons.integration_instructions_rounded,
                  secondaryIcon: Icons.auto_graph_rounded,
                  color: AppColors.calculusColor,
                  onTap: () => _navigateTo(const CalculusPage()),
                ),
                
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateTo(Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget _buildTopicCard({
    required String name,
    required String description,
    required IconData icon,
    required IconData secondaryIcon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withOpacity(0.2),
                    color.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 28,
                  color: color,
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: color,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            
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
