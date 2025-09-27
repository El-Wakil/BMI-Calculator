import 'package:flutter/material.dart';
import '../services/localization_service.dart';

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
        return LocalizationService.underweight;
      case BmiCategory.normal:
        return LocalizationService.normal;
      case BmiCategory.overweight:
        return LocalizationService.overweight;
      case BmiCategory.obese:
        return LocalizationService.obese;
    }
  }

  String get localizedAdvice {
    switch (category) {
      case BmiCategory.underweight:
        return LocalizationService.underweightAdvice;
      case BmiCategory.normal:
        return LocalizationService.normalAdvice;
      case BmiCategory.overweight:
        return LocalizationService.overweightAdvice;
      case BmiCategory.obese:
        return LocalizationService.obeseAdvice;
    }
  }
}
