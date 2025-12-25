import 'package:flutter/material.dart';
import 'dart:math' as math;

/// App color palette - Gold & Dark theme
class AppColors {
  // Primary gold/brown shades
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFE8D5A3);
  static const Color goldDark = Color(0xFF8B7355);
  static const Color goldMuted = Color(0xFFAD9767);
  
  // Background colors
  static const Color backgroundDark = Color(0xFF0A0A0A);
  static const Color backgroundCard = Color(0xFF1A1A1A);
  static const Color backgroundElevated = Color(0xFF242424);
  
  // Surface colors
  static const Color surfaceDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFF2A2A2A);
  
  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color textMuted = Color(0xFF6E6E6E);
  
  // Subject colors (matching existing)
  static const Color algebraColor = Color(0xFFB0BEC5);
  static const Color geometryColor = Color(0xFF689E6A);
  static const Color intAlgColor = Color(0xFFC58342);
  static const Color trigColor = Color(0xFFCC5D5D);
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE57373);
  static const Color warning = Color(0xFFFFB74D);
}

/// Gradient presets
class AppGradients {
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.gold, AppColors.goldDark],
  );
  
  static const LinearGradient goldShimmer = LinearGradient(
    colors: [AppColors.gold, AppColors.goldLight, AppColors.goldMuted],
  );
  
  static LinearGradient fadeLeft = LinearGradient(
    colors: [Colors.transparent, Colors.grey.shade800],
  );
  
  static LinearGradient fadeRight = LinearGradient(
    colors: [Colors.grey.shade800, Colors.transparent],
  );
}

/// Common text styles
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w300,
    color: Colors.white,
    letterSpacing: 2,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    letterSpacing: 1.5,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    letterSpacing: 1,
  );
  
  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
    letterSpacing: 1,
  );
  
  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: Colors.white,
    letterSpacing: 0.5,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textMuted,
    letterSpacing: 0.5,
  );
  
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 3,
  );
  
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w300,
    letterSpacing: 4,
  );
}

/// Shared decorations
class AppDecorations {
  static BoxDecoration cardDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: AppColors.backgroundCard,
    border: Border.all(
      color: Colors.grey.shade800.withOpacity(0.3),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
  
  static BoxDecoration goldGlowDecoration = BoxDecoration(
    gradient: AppGradients.goldGradient,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppColors.gold.withOpacity(0.3),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  );
  
  static BoxDecoration circleGoldDecoration = BoxDecoration(
    shape: BoxShape.circle,
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.gold, AppColors.goldDark, AppColors.goldMuted],
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.gold.withOpacity(0.3),
        blurRadius: 30,
        spreadRadius: 5,
      ),
    ],
  );
}

/// Common input decoration
class AppInputDecoration {
  static InputDecoration textField({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: AppColors.goldMuted, size: 22),
      suffixIcon: suffixIcon,
      labelText: label,
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    );
  }
}

/// Animated background widget for consistency
class AnimatedBackground extends StatefulWidget {
  final Color primaryColor;
  final Color secondaryColor;
  
  const AnimatedBackground({
    super.key,
    this.primaryColor = AppColors.gold,
    this.secondaryColor = AppColors.goldDark,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _BackgroundPainter(
            _controller.value,
            widget.primaryColor,
            widget.secondaryColor,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final double animationValue;
  final Color primaryColor;
  final Color secondaryColor;

  _BackgroundPainter(this.animationValue, this.primaryColor, this.secondaryColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < 5; i++) {
      final progress = (animationValue + i * 0.2) % 1.0;
      final opacity = (0.05 + 0.03 * math.sin(progress * math.pi * 2)).clamp(0.0, 1.0);
      
      paint.color = primaryColor.withOpacity(opacity);
      
      final centerX = size.width * (0.2 + i * 0.15);
      final centerY = size.height * (0.3 + math.sin(progress * math.pi * 2 + i) * 0.1);
      final radius = 50.0 + i * 30 + math.sin(progress * math.pi * 2) * 20;
      
      canvas.drawCircle(Offset(centerX, centerY), radius, paint);
    }

    for (int i = 0; i < 3; i++) {
      final offset = animationValue * 100 + i * 200;
      paint.color = secondaryColor.withOpacity(0.03);
      
      canvas.drawLine(
        Offset(-50 + offset % (size.width + 100), 0),
        Offset(size.width * 0.3 + offset % (size.width + 100), size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

/// Styled snackbar helper
void showStyledSnackBar(BuildContext context, String message, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isError 
                  ? Colors.white.withOpacity(0.2) 
                  : AppColors.gold.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isError ? Icons.error_outline_rounded : Icons.check_circle_outline_rounded,
              color: isError ? Colors.white : AppColors.gold,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: isError 
          ? const Color(0xFFB33A3A) 
          : const Color(0xFF1E3A2F),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.all(16),
      elevation: 8,
      duration: const Duration(seconds: 3),
    ),
  );
}

/// Gradient title widget
class GradientTitle extends StatelessWidget {
  final String text;
  final double fontSize;
  
  const GradientTitle({
    super.key,
    required this.text,
    this.fontSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => AppGradients.goldShimmer.createShader(bounds),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w300,
          color: Colors.white,
          letterSpacing: 4,
        ),
      ),
    );
  }
}

/// Styled card widget
class StyledCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? borderColor;
  
  const StyledCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.backgroundCard,
          border: Border.all(
            color: borderColor ?? Colors.grey.shade800.withOpacity(0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

/// Primary button with gradient
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  
  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Ink(
          decoration: AppDecorations.goldGlowDecoration,
          child: Container(
            alignment: Alignment.center,
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.backgroundDark,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    text,
                    style: const TextStyle(
                      color: AppColors.backgroundDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

/// Secondary outlined button
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  
  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: AppColors.goldMuted.withOpacity(0.5),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.goldMuted,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

/// Styled text field container
class StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  
  const StyledTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.cardDecoration,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          letterSpacing: 0.5,
        ),
        decoration: AppInputDecoration.textField(
          label: label,
          icon: icon,
          suffixIcon: suffixIcon,
        ),
        cursorColor: AppColors.gold,
      ),
    );
  }
}

