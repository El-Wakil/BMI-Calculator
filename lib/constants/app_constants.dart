import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFFE91E63);
  static const Color background = Color(0xFF0D1B2A);
  static const Color surface = Color(0xFF1B263B);
  static const Color cardBackground = Color(0xFF3B4252);
  static const Color cardSurface = Color(0xFF434C5E);

  // Gender colors
  static const Color maleColor = Color(0xFF2196F3);
  static const Color femaleColor = Color(0xFFE91E63);

  // BMI category colors
  static const Color underweight = Color(0xFF3498DB);
  static const Color normal = Color(0xFF27AE60);
  static const Color overweight = Color(0xFFF39C12);
  static const Color obese = Color(0xFFE74C3C);
}

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 1.2,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: Colors.white70,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: Colors.white60,
  );
}
