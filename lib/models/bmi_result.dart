import 'package:flutter/material.dart';

enum BmiCategory {
  underweight,
  normal,
  overweight,
  obese,
}

class BmiResult {
  final double value;
  final BmiCategory category;
  final Color color;
  final String advice;

  BmiResult({
    required this.value,
    required this.category,
    required this.color,
    required this.advice,
  });

  String get categoryText {
    switch (category) {
      case BmiCategory.underweight:
        return 'Underweight';
      case BmiCategory.normal:
        return 'Normal';
      case BmiCategory.overweight:
        return 'Overweight';
      case BmiCategory.obese:
        return 'Obese';
    }
  }
}
