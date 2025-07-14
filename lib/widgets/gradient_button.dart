import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final List<Color> gradientColors;
  final double height;
  final double? width;

  const GradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.gradientColors,
    this.height = 60,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.subtitle.copyWith(
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
