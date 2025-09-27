import 'package:flutter/material.dart';

enum AppLanguage { english, arabic }

class LocalizationService {
  static AppLanguage _currentLanguage = AppLanguage.arabic;

  static AppLanguage get currentLanguage => _currentLanguage;

  static bool get isArabic => _currentLanguage == AppLanguage.arabic;

  static TextDirection get textDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;

  static void setLanguage(AppLanguage language) {
    _currentLanguage = language;
  }

  static String get appTitle =>
      isArabic ? 'حاسبة مؤشر كتلة الجسم' : 'BMI CALCULATOR';

  // Gender labels
  static String get male => isArabic ? 'ذكر' : 'MALE';
  static String get female => isArabic ? 'أنثى' : 'FEMALE';

  // Input labels
  static String get height => isArabic ? 'الطول' : 'Height';
  static String get weight => isArabic ? 'الوزن' : 'Weight';
  static String get age => isArabic ? 'العمر' : 'AGE';

  // Units
  static String get heightUnit => isArabic ? '(سم)' : '(cm)';
  static String get weightUnit => isArabic ? '(كيلو)' : '(kg)';

  // Placeholders
  static String get heightPlaceholder => isArabic ? '170.5' : '170.5';
  static String get weightPlaceholder => isArabic ? '77.5' : '77.5';

  // Button labels
  static String get calculateBmi =>
      isArabic ? 'احسب مؤشر كتلة الجسم' : 'CALCULATE BMI';
  static String get recalculate => isArabic ? 'احسب مرة أخرى' : 'RECALCULATE';

  // Language dialog
  static String get changeLanguage =>
      isArabic ? 'تغيير اللغة' : 'Change Language';
  static String get english => isArabic ? 'English' : 'English';
  static String get arabic => isArabic ? 'العربية' : 'العربية';
  static String languageChanged(String language) => isArabic
      ? 'تم تغيير اللغة إلى $language'
      : 'Language changed to $language';

  // Validation messages
  static String get pleaseEnterHeight =>
      isArabic ? 'يرجى إدخال الطول' : 'Please enter height';
  static String get pleaseEnterWeight =>
      isArabic ? 'يرجى إدخال الوزن' : 'Please enter weight';
  static String get pleaseEnterValidHeight =>
      isArabic ? 'يرجى إدخال طول صحيح' : 'Please enter a valid height';
  static String get pleaseEnterValidWeight =>
      isArabic ? 'يرجى إدخال وزن صحيح' : 'Please enter a valid weight';

  // BMI Results
  static String get yourResult => isArabic ? 'النتيجة' : 'Your Result';
  static String get bmiScore => isArabic ? 'مؤشر كتلة الجسم' : 'BMI Score';

  // BMI Categories
  static String get underweight => isArabic ? 'نقص في الوزن' : 'Underweight';
  static String get normal => isArabic ? 'وزن طبيعي' : 'Normal';
  static String get overweight => isArabic ? 'زيادة في الوزن' : 'Overweight';
  static String get obese => isArabic ? 'سمنة' : 'Obese';

  // BMI Advice
  static String get underweightAdvice => isArabic
      ? 'لديك نقص في الوزن. يُنصح بتناول المزيد من الطعام الصحي وممارسة التمارين لبناء العضلات.'
      : 'You are underweight. Consider eating more healthy foods and exercising to build muscle mass.';

  static String get normalAdvice => isArabic
      ? 'لديك وزن طبيعي ومثالي! حافظ على نمط الحياة الصحي والتمارين المنتظمة.'
      : 'You have a normal and ideal weight! Maintain your healthy lifestyle and regular exercise.';

  static String get overweightAdvice => isArabic
      ? 'لديك زيادة في الوزن. يُنصح بممارسة التمارين بانتظام واتباع نظام غذائي صحي.'
      : 'You are overweight. Consider regular exercise and following a healthy diet plan.';

  static String get obeseAdvice => isArabic
      ? 'لديك سمنة. يُنصح بشدة بمراجعة طبيب مختص واتباع نظام غذائي وممارسة التمارين.'
      : 'You are obese. It is highly recommended to consult a specialist doctor and follow a diet and exercise plan.';

  // Info cards
  static String get healthTips => isArabic ? 'نصائح صحية' : 'Health Tips';
  static String get healthAdvice => isArabic ? 'نصائح صحية' : 'Health Advice';
  static String get idealRange => isArabic ? 'النطاق المثالي' : 'Ideal Range';
  static String get yourStats => isArabic ? 'إحصائياتك' : 'Your Stats';

  static String get healthTipsContent => isArabic
      ? '• اشرب 8 أكواب ماء يومياً\n• تناول 5 حصص من الخضار والفواكه\n• مارس الرياضة 30 دقيقة يومياً'
      : '• Drink 8 glasses of water daily\n• Eat 5 servings of fruits and vegetables\n• Exercise for 30 minutes daily';

  static String get idealRangeContent => isArabic
      ? 'النطاق الصحي لمؤشر كتلة الجسم هو بين 18.5 و 24.9'
      : 'Healthy BMI range is between 18.5 and 24.9';

  static String yourStatsContent(
          String gender, int age, double height, double weight) =>
      isArabic
          ? 'الجنس: $gender\nالعمر: $age سنة\nالطول: ${height.toStringAsFixed(1)} سم\nالوزن: ${weight.toStringAsFixed(1)} كيلو'
          : 'Gender: $gender\nAge: $age years\nHeight: ${height.toStringAsFixed(1)} cm\nWeight: ${weight.toStringAsFixed(1)} kg';

  // Error messages
  static String errorMessage(String error) =>
      isArabic ? 'خطأ: $error' : 'Error: $error';
}
