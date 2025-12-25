import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/session.dart';
import 'package:math_derust/theme/app_theme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  DbHelper db = DbHelper.instance;
  
  // Class options with icons and colors
  static final Map<String, Map<String, dynamic>> classInfo = {
    'Pre-Algebra': {'icon': Icons.looks_one_rounded, 'color': const Color(0xFF6B8E23)},
    'Introductory Algebra': {'icon': Icons.functions_rounded, 'color': const Color(0xFF4169E1)},
    'Geometry': {'icon': Icons.category_rounded, 'color': const Color(0xFFDC143C)},
    'Intermediate Algebra': {'icon': Icons.analytics_rounded, 'color': const Color(0xFF9932CC)},
    'Precalculus': {'icon': Icons.show_chart_rounded, 'color': const Color(0xFFFF8C00)},
    'Calculus I': {'icon': Icons.trending_up_rounded, 'color': const Color(0xFF20B2AA)},
    'Calculus II': {'icon': Icons.stacked_line_chart_rounded, 'color': const Color(0xFF4682B4)},
    'Calculus III': {'icon': Icons.blur_on_rounded, 'color': const Color(0xFF8B4513)},
    'Calculus IV': {'icon': Icons.hub_rounded, 'color': const Color(0xFF708090)},
    'Linear Algebra': {'icon': Icons.grid_on_rounded, 'color': const Color(0xFFB22222)},
    'Differential Equations': {'icon': Icons.waves_rounded, 'color': const Color(0xFF2E8B57)},
    'Beyond': {'icon': Icons.rocket_launch_rounded, 'color': const Color(0xFFD4AF37)},
  };
  
  Map<String, int> xps = {
    'xp_tot': 0,
    'xp_algebra': 0,
    'xp_geometry': 0,
    'xp_intalg': 0,
    'xp_trig': 0,
  };

  Map<String, int> friends = {};
  final TextEditingController friendController = TextEditingController();
  
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
    loadUser();
  }

  @override
  void dispose() {
    _animController.dispose();
    friendController.dispose();
    super.dispose();
  }

  Future<void> loadUser() async {
    Map<String, int> fetchedXp = await db.getUserXp(Session.instance.currentUserId ?? 0);
    Map<String, int> fetchedFriends = await db.getUserFriends(Session.instance.currentUserId ?? 0);
    if (mounted) {
      setState(() {
        xps = fetchedXp;
        friends = fetchedFriends;
      });
    }
  }

  Future<String?> getClassValue() async {
    List<Map<String, dynamic>> result = await db.queryWhere(
      'users',
      'username',
      Session.instance.currentUsername ?? '',
    );
    if (result.isNotEmpty) {
      return result.first['class'];
    }
    return null;
  }

  Future<int?> getStreak() async {
    List<Map<String, dynamic>> result = await db.queryWhere(
      'users',
      'username',
      Session.instance.currentUsername ?? '',
    );
    if (result.isNotEmpty) {
      return result.first['streak'];
    }
    return null;
  }

  void _addFriend(TextEditingController friendName) async {
    bool res = await db.checkExistence(friendName.text);
    bool exists = res && friendName.text.trim() != Session.instance.currentUsername?.trim();
    if (exists) {
      db.addFriend(Session.instance.currentUserId ?? 0, friendName.text);
      await loadUser();
    } else {
      showStyledSnackBar(context, "Username doesn't exist or is already your friend", isError: true);
    }
    friendController.clear();
    FocusScope.of(context).unfocus();
  }

  void _removeFriend(String friendName) async {
    await db.removeFriend(Session.instance.currentUserId ?? 0, friendName);
    await loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                  
                  // Section title
                  const GradientTitle(text: 'PROFILE', fontSize: 24),
                  
                  const SizedBox(height: 40),
                  
                  // User avatar and info
                  _buildUserHeader(),
                  
                  const SizedBox(height: 40),
                  
                  // Stats grid
                  _buildStatsGrid(),
                  
                  const SizedBox(height: 24),
                  
                  // XP Chart
                  _buildXpChart(),
                  
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    final avatarUrl = Session.instance.avatarUrl;
    final initials = (Session.instance.currentUsername ?? 'U')[0].toUpperCase();
    
    return Column(
      children: [
        // Avatar with glow
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: avatarUrl == null 
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.gold, AppColors.goldDark],
                  )
                : null,
            image: avatarUrl != null
                ? DecorationImage(
                    image: NetworkImage(avatarUrl),
                    fit: BoxFit.cover,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withOpacity(0.3),
                blurRadius: 25,
                spreadRadius: 2,
              ),
            ],
          ),
          child: avatarUrl == null
              ? Center(
                  child: Text(
                    initials,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                      color: AppColors.backgroundDark,
                    ),
                  ),
                )
              : null,
        ),
        
        const SizedBox(height: 20),
        
        // Username
        Text(
          Session.instance.currentUsername ?? 'User',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w300,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Class with icon
        FutureBuilder<String?>(
          future: getClassValue(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              );
            }
            
            final className = snapshot.data ?? 'No Class';
            final info = classInfo[className];
            final IconData icon = info?['icon'] as IconData? ?? Icons.school_rounded;
            final Color color = info?['color'] as Color? ?? AppColors.goldMuted;
            
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: color.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 16,
                    color: color,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    className,
                    style: TextStyle(
                      fontSize: 14,
                      color: color,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        // Streak card
        Expanded(
          child: _buildStatCard(
            icon: '🔥',
            isEmoji: true,
            futureValue: getStreak(),
            label: 'Day Streak',
          ),
        ),
        const SizedBox(width: 16),
        // Total XP card
        Expanded(
          child: _buildStatCardStatic(
            icon: Icons.star_rounded,
            value: '${xps['xp_tot'] ?? 0}',
            label: 'Total XP',
            color: AppColors.gold,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String icon,
    required bool isEmoji,
    required Future<int?> futureValue,
    required String label,
  }) {
    return StyledCard(
      padding: const EdgeInsets.all(20),
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          FutureBuilder<int?>(
            future: futureValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 40,
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                );
              }
              return ShaderMask(
                shaderCallback: (bounds) => AppGradients.goldShimmer.createShader(bounds),
                child: Text(
                  '${snapshot.data ?? 0}',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            icon,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCardStatic({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return StyledCard(
      padding: const EdgeInsets.all(20),
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => AppGradients.goldShimmer.createShader(bounds),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXpChart() {
    return StyledCard(
      padding: const EdgeInsets.all(24),
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'XP BY SUBJECT',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${xps['xp_tot'] ?? 0} total',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Pie chart
          Center(
            child: SizedBox(
              width: 180,
              height: 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size(180, 180),
                    painter: PieChartPainter(
                      xpAlgebra: xps['xp_algebra'] ?? 0,
                      xpGeometry: xps['xp_geometry'] ?? 0,
                      xpIntAlg: xps['xp_intalg'] ?? 0,
                      xpTrig: xps['xp_trig'] ?? 0,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.backgroundCard,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => AppGradients.goldShimmer.createShader(bounds),
                            child: Text(
                              '${xps['xp_tot'] ?? 0}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'XP',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Legend
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _buildLegendItem('Algebra', AppColors.algebraColor, xps['xp_algebra'] ?? 0),
              _buildLegendItem('Geometry', AppColors.geometryColor, xps['xp_geometry'] ?? 0),
              _buildLegendItem('Int. Algebra', AppColors.intAlgColor, xps['xp_intalg'] ?? 0),
              _buildLegendItem('Trigonometry', AppColors.trigColor, xps['xp_trig'] ?? 0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, int value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '$label ($value)',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}

class PieChartPainter extends CustomPainter {
  final int xpAlgebra;
  final int xpGeometry;
  final int xpIntAlg;
  final int xpTrig;

  PieChartPainter({
    required this.xpAlgebra,
    required this.xpGeometry,
    required this.xpIntAlg,
    required this.xpTrig,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    double startAngle = -pi / 2;

    List<Color> colors = [
      AppColors.algebraColor,
      AppColors.geometryColor,
      AppColors.intAlgColor,
      AppColors.trigColor,
    ];

    List<int> xpValues = [xpAlgebra, xpGeometry, xpIntAlg, xpTrig];
    int totalXp = xpValues.reduce((a, b) => a + b);

    if (totalXp == 0) {
      // Draw empty state circle
      paint.color = Colors.grey.shade800;
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        size.width / 2,
        paint,
      );
      return;
    }

    for (int i = 0; i < xpValues.length; i++) {
      if (xpValues[i] == 0) continue;
      
      paint.color = colors[i % colors.length];
      double sweepAngle = (xpValues[i] / totalXp) * (2 * pi);
      
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2,
        ),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

