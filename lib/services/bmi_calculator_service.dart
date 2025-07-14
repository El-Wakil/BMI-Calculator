import 'package:flutter/material.dart';
import '../models/bmi_data.dart';
import '../models/bmi_result.dart';

class BmiCalculatorService {
  static BmiResult calculateBmi(BmiData data) {
    if (!data.isValid) {
      throw Exception('Invalid BMI data');
    }

    // Calculate BMI: weight (kg) / height (m)²
    final heightInMeters = data.height / 100;
    final bmiValue = data.weight / (heightInMeters * heightInMeters);

    return BmiResult(
      value: bmiValue,
      category: _getBmiCategory(bmiValue),
      color: _getBmiColor(bmiValue),
      advice: _getBmiAdvice(bmiValue),
    );
  }

  static BmiCategory _getBmiCategory(double bmi) {
    if (bmi < 18.5) {
      return BmiCategory.underweight;
    } else if (bmi < 25) {
      return BmiCategory.normal;
    } else if (bmi < 30) {
      return BmiCategory.overweight;
    } else {
      return BmiCategory.obese;
    }
  }

  static Color _getBmiColor(double bmi) {
    if (bmi < 18.5) {
      return Color(0xFF3498DB); // Blue
    } else if (bmi < 25) {
      return Color(0xFF27AE60); // Green
    } else if (bmi < 30) {
      return Color(0xFFF39C12); // Orange
    } else {
      return Color(0xFFE74C3C); // Red
    }
  }

  static String _getBmiAdvice(double bmi) {
    if (bmi < 18.5) {
      return 'You are underweight. Consider eating more nutritious foods and consulting a healthcare provider.';
    } else if (bmi < 25) {
      return 'Great! You have a normal weight. Keep maintaining your healthy lifestyle.';
    } else if (bmi < 30) {
      return 'You are overweight. Consider a balanced diet and regular exercise.';
    } else {
      return 'You are obese. It\'s recommended to consult with a healthcare provider for a proper plan.';
    }
  }
}
