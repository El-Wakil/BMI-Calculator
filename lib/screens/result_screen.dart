import 'package:flutter/material.dart';
import '../models/bmi_data.dart';
import '../models/bmi_result.dart';
import '../widgets/gradient_button.dart';
import '../widgets/info_card.dart';
import '../constants/app_constants.dart';

class ResultScreen extends StatefulWidget {
  final BmiResult bmiResult;
  final BmiData bmiData;

  const ResultScreen({
    Key? key,
    required this.bmiResult,
    required this.bmiData,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.background, AppColors.surface],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom -
                    kToolbarHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildBmiCircle(),
                          SizedBox(height: 40),
                          _buildCategoryBadge(),
                          SizedBox(height: 30),
                          _buildInfoCards(),
                          SizedBox(height: 30),
                          _buildAdviceCard(),
                        ],
                      ),
                    ),
                    _buildRecalculateButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
      ),
      centerTitle: true,
      title: Text('BMI RESULT', style: AppTextStyles.title),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.surface, Color(0xFF415A77)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildBmiCircle() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              widget.bmiResult.color,
              widget.bmiResult.color.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.bmiResult.color.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.bmiResult.value.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              Text(
                'BMI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        color: widget.bmiResult.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: widget.bmiResult.color, width: 2),
      ),
      child: Text(
        widget.bmiResult.categoryText.toUpperCase(),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: widget.bmiResult.color,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildInfoCards() {
    return Row(
      children: [
        Expanded(
          child: InfoCard(
            title: 'Gender',
            value: widget.bmiData.isMale ? 'Male' : 'Female',
            icon: widget.bmiData.isMale ? Icons.male : Icons.female,
            color: widget.bmiData.isMale
                ? AppColors.maleColor
                : AppColors.femaleColor,
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: InfoCard(
            title: 'Age',
            value: '${widget.bmiData.age} years',
            icon: Icons.cake,
            color: Color(0xFF66BB6A),
          ),
        ),
      ],
    );
  }

  Widget _buildAdviceCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.cardBackground, AppColors.cardSurface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: Color(0xFFF39C12),
                size: 28,
              ),
              SizedBox(width: 10),
              Text(
                'Health Advice',
                style: AppTextStyles.subtitle,
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            widget.bmiResult.advice,
            style: AppTextStyles.body.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecalculateButton() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: GradientButton(
        text: 'RECALCULATE BMI',
        onPressed: () => Navigator.pop(context),
        gradientColors: [AppColors.primary, Color(0xFF1976D2)],
      ),
    );
  }
}
