import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/pages/login.dart';
import 'package:math_derust/session.dart';
import 'package:math_derust/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Session;

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  
  String? selectedClass;
  bool _isPasswordVisible = false;
  bool _isConfirmVisible = false;
  bool _isLoading = false;
  
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  final List<Map<String, dynamic>> classOptions = [
    {'name': 'Pre-Algebra', 'icon': Icons.looks_one_rounded, 'color': const Color(0xFF6B8E23)},
    {'name': 'Introductory Algebra', 'icon': Icons.functions_rounded, 'color': const Color(0xFF4169E1)},
    {'name': 'Geometry', 'icon': Icons.category_rounded, 'color': const Color(0xFFDC143C)},
    {'name': 'Intermediate Algebra', 'icon': Icons.analytics_rounded, 'color': const Color(0xFF9932CC)},
    {'name': 'Precalculus', 'icon': Icons.show_chart_rounded, 'color': const Color(0xFFFF8C00)},
    {'name': 'Calculus I', 'icon': Icons.trending_up_rounded, 'color': const Color(0xFF20B2AA)},
    {'name': 'Calculus II', 'icon': Icons.stacked_line_chart_rounded, 'color': const Color(0xFF4682B4)},
    {'name': 'Calculus III', 'icon': Icons.blur_on_rounded, 'color': const Color(0xFF8B4513)},
    {'name': 'Calculus IV', 'icon': Icons.hub_rounded, 'color': const Color(0xFF708090)},
    {'name': 'Linear Algebra', 'icon': Icons.grid_on_rounded, 'color': const Color(0xFFB22222)},
    {'name': 'Differential Equations', 'icon': Icons.waves_rounded, 'color': const Color(0xFF2E8B57)},
    {'name': 'Beyond', 'icon': Icons.rocket_launch_rounded, 'color': const Color(0xFFD4AF37)},
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _createAccount() async {
    setState(() => _isLoading = true);
    
    String username = _usernameController.text.trim();
    String clas = selectedClass ?? '';
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String confirm = _confirmController.text;

    if (username.isEmpty) {
      showStyledSnackBar(context, 'Username cannot be empty', isError: true);
      setState(() => _isLoading = false);
      return;
    }

    if (email.isEmpty) {
      showStyledSnackBar(context, 'Email cannot be empty', isError: true);
      setState(() => _isLoading = false);
      return;
    }

    if (password.isEmpty) {
      showStyledSnackBar(context, 'Password cannot be empty', isError: true);
      setState(() => _isLoading = false);
      return;
    }

    if (password.length < 6) {
      showStyledSnackBar(context, 'Password must be at least 6 characters', isError: true);
      setState(() => _isLoading = false);
      return;
    }

    if (confirm != password) {
      showStyledSnackBar(context, 'Passwords do not match', isError: true);
      setState(() => _isLoading = false);
      return;
    }

    if (clas.isEmpty) {
      showStyledSnackBar(context, 'Please select your math class', isError: true);
      setState(() => _isLoading = false);
      return;
    }

    // Check if username is already taken
    final existingUser = await DbHelper.instance.queryWhere('users', 'username', username);
    if (existingUser.isNotEmpty) {
      showStyledSnackBar(context, 'Username is already taken', isError: true);
      setState(() => _isLoading = false);
      return;
    }

    try {
      final response = await Session.instance.signUp(
        email: email,
        password: password,
        username: username,
        mathClass: clas,
      );
      
      setState(() => _isLoading = false);

      if (mounted) {
        // Check if email confirmation is required
        if (response.session == null && response.user != null) {
          // Email confirmation is required
          showStyledSnackBar(context, 'Check your email to confirm your account');
        } else {
          showStyledSnackBar(context, 'Account created successfully!');
        }
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const Login(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
      }
    } on AuthException catch (e) {
      setState(() => _isLoading = false);
      showStyledSnackBar(context, e.message, isError: true);
    } on PostgrestException catch (e) {
      setState(() => _isLoading = false);
      if (e.message.contains('unique') || e.message.contains('duplicate')) {
        showStyledSnackBar(context, 'Username or email is already taken', isError: true);
      } else {
        showStyledSnackBar(context, 'Error creating account', isError: true);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      showStyledSnackBar(context, 'Error creating account', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          const AnimatedBackground(),
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      
                      // Back button
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
                            color: AppColors.goldMuted,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Title
                      Center(
                        child: ShaderMask(
                          shaderCallback: (bounds) =>
                              AppGradients.goldShimmer.createShader(bounds),
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      Center(
                        child: Text(
                          'Join the math journey',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 50),
                      
                      // Username field
                      StyledTextField(
                        controller: _usernameController,
                        label: 'Username',
                        icon: Icons.person_outline_rounded,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Email field
                      StyledTextField(
                        controller: _emailController,
                        label: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Password field
                      Container(
                        decoration: AppDecorations.cardDecoration,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: AppColors.goldMuted,
                              size: 22,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() => _isPasswordVisible = !_isPasswordVisible);
                              },
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                              letterSpacing: 1,
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: AppColors.gold,
                              fontSize: 14,
                              letterSpacing: 1,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                          ),
                          cursorColor: AppColors.gold,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Confirm password field
                      Container(
                        decoration: AppDecorations.cardDecoration,
                        child: TextField(
                          controller: _confirmController,
                          obscureText: !_isConfirmVisible,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: AppColors.goldMuted,
                              size: 22,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmVisible
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() => _isConfirmVisible = !_isConfirmVisible);
                              },
                            ),
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                              letterSpacing: 1,
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: AppColors.gold,
                              fontSize: 14,
                              letterSpacing: 1,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                          ),
                          cursorColor: AppColors.gold,
                        ),
                      ),
                      
                      const SizedBox(height: 28),
                      
                      // Class selector label
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.school_rounded,
                              color: AppColors.gold,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'SELECT YOUR CLASS',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Class grid selector
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 2.2,
                        ),
                        itemCount: classOptions.length,
                        itemBuilder: (context, index) {
                          final option = classOptions[index];
                          final isSelected = selectedClass == option['name'];
                          final Color optionColor = option['color'] as Color;
                          
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedClass = option['name'] as String;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? optionColor.withOpacity(0.15)
                                    : AppColors.backgroundCard,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected 
                                      ? optionColor
                                      : Colors.grey.shade800.withOpacity(0.3),
                                  width: isSelected ? 2 : 1,
                                ),
                                boxShadow: isSelected ? [
                                  BoxShadow(
                                    color: optionColor.withOpacity(0.2),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ] : null,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: isSelected 
                                            ? optionColor.withOpacity(0.2)
                                            : Colors.grey.shade800.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        option['icon'] as IconData,
                                        color: isSelected ? optionColor : Colors.grey.shade500,
                                        size: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        option['name'] as String,
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : Colors.grey.shade400,
                                          fontSize: 12,
                                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                          letterSpacing: 0.3,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check_circle_rounded,
                                        color: optionColor,
                                        size: 18,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Create button
                      PrimaryButton(
                        text: 'CREATE ACCOUNT',
                        onPressed: _createAccount,
                        isLoading: _isLoading,
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Login link
                      Center(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                              children: const [
                                TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                    color: AppColors.gold,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
