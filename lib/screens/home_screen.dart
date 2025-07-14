import 'package:flutter/material.dart';
import '../models/bmi_data.dart';
import '../services/bmi_calculator_service.dart';
import '../widgets/gradient_button.dart';
import '../widgets/custom_text_field.dart';
import '../constants/app_constants.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool isMale = true;
  int age = 25;

  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void _calculateBmi() {
    if (_formKey.currentState!.validate()) {
      final data = BmiData(
        isMale: isMale,
        height: double.parse(heightController.text),
        weight: double.parse(weightController.text),
        age: age,
      );

      try {
        final result = BmiCalculatorService.calculateBmi(data);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              bmiResult: result,
              bmiData: data,
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
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
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildGenderSelection(),
                        SizedBox(height: 25),
                        _buildInputFields(),
                        SizedBox(height: 25),
                        _buildAgeSection(),
                        SizedBox(height: 40),
                        _buildCalculateButton(),
                      ],
                    ),
                  ),
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
      centerTitle: true,
      title: Text(
        'BMI CALCULATOR',
        style: AppTextStyles.title,
      ),
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

  Widget _buildGenderSelection() {
    return Row(
      children: [
        Expanded(
          child: _buildGenderCard(
            'MALE',
            Icons.male,
            true,
            AppColors.maleColor,
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: _buildGenderCard(
            'FEMALE',
            Icons.female,
            false,
            AppColors.femaleColor,
          ),
        ),
      ],
    );
  }

  Widget _buildGenderCard(
      String gender, IconData icon, bool isCurrentMale, Color color) {
    bool isSelected = isMale == isCurrentMale;

    return GestureDetector(
      onTap: () {
        setState(() {
          isMale = isCurrentMale;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 180,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [color, color.withOpacity(0.7)]
                : [AppColors.cardBackground, AppColors.cardSurface],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: color, width: 3) : null,
          boxShadow: [
            BoxShadow(
              color: isSelected ? color.withOpacity(0.4) : Colors.black26,
              spreadRadius: isSelected ? 3 : 1,
              blurRadius: isSelected ? 15 : 8,
              offset: Offset(0, isSelected ? 8 : 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Colors.white,
            ),
            SizedBox(height: 15),
            Text(
              gender,
              style: AppTextStyles.subtitle.copyWith(
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        CustomTextField(
          hint: '170.5',
          label: 'Height (cm)',
          controller: heightController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter height';
            }
            final height = double.tryParse(value);
            if (height == null || height <= 0) {
              return 'Please enter a valid height';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        CustomTextField(
          hint: '77.5',
          label: 'Weight (kg)',
          controller: weightController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter weight';
            }
            final weight = double.tryParse(value);
            if (weight == null || weight <= 0) {
              return 'Please enter a valid weight';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAgeSection() {
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
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'AGE',
            style: AppTextStyles.caption.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 20),
          Text(
            '$age',
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCircularButton(Icons.remove, () {
                setState(() {
                  if (age > 1) age--;
                });
              }),
              SizedBox(width: 40),
              _buildCircularButton(Icons.add, () {
                setState(() {
                  if (age < 100) age++;
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppColors.primary, Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onPressed,
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildCalculateButton() {
    return GradientButton(
      text: 'CALCULATE BMI',
      onPressed: _calculateBmi,
      gradientColors: [AppColors.primary, Color(0xFF1976D2)],
    );
  }
}
