import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:math_derust/data/db.dart';
import 'package:math_derust/pages/settings.dart';
import 'package:math_derust/session.dart';
import 'package:math_derust/theme/app_theme.dart';

import 'community.dart';
import 'learn.dart';
import 'mistakes.dart';
import 'profile.dart';
import 'quests.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  DbHelper db = DbHelper.instance;
  
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  int questNum = 0;
  int mistakesNum = 0;

  static const List<Widget> _pages = [
    Profile(),
    Learn(),
    Community(),
    Mistakes(),
    Quests(),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
    awaitVals();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onElementTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) async {
    await getUserVals();
    setState(() {
      _selectedIndex = index;
    });
  }

  void settingsRedirect(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const SettingsPage(),
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

  Future<void> getUserVals() async {
    List<Map<String, dynamic>> res1 = await db.getUserQuests(Session.instance.currentUserId ?? 0);
    List<Map<String, dynamic>> uncompleted = res1.where((quest) => quest['completed'] == 0).toList();
    questNum = uncompleted.isEmpty ? 0 : uncompleted.length;
    List<Map<String, dynamic>> res2 = await db.queryUserMistakes(Session.instance.currentUserId ?? 0);
    mistakesNum = res2.isEmpty ? 0 : res2.length;
    if (mounted) setState(() {});
  }

  void awaitVals() async {
    await getUserVals();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark,
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundDark,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade800.withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 48),
                      ShaderMask(
                        shaderCallback: (bounds) => AppGradients.goldShimmer.createShader(bounds),
                        child: const Text(
                          'MATH DERUST',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
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
                            Icons.settings_rounded,
                            size: 24,
                            color: AppColors.goldMuted,
                          ),
                          onPressed: () => settingsRedirect(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pages,
          ),
        ),
        bottomNavigationBar: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade800.withOpacity(0.3),
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, Icons.person_rounded, 'Profile', null),
                    _buildNavItem(1, Icons.auto_stories_rounded, 'Learn', null),
                    _buildNavItem(2, Icons.forum_rounded, 'Community', null),
                    _buildNavItem(3, Icons.replay_rounded, 'Mistakes', mistakesNum > 0 ? mistakesNum : null),
                    _buildNavItem(4, Icons.emoji_events_rounded, 'Quests', questNum > 0 ? questNum : null),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, int? badgeCount) {
    final isSelected = _selectedIndex == index;
    
    return GestureDetector(
      onTap: () => _onElementTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gold.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            badgeCount != null
                ? badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: AppColors.error,
                      padding: const EdgeInsets.all(5),
                    ),
                    badgeContent: Text(
                      '$badgeCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Icon(
                      icon,
                      size: 24,
                      color: isSelected ? AppColors.gold : AppColors.textMuted,
                    ),
                  )
                : Icon(
                    icon,
                    size: 24,
                    color: isSelected ? AppColors.gold : AppColors.textMuted,
                  ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.gold : AppColors.textMuted,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
