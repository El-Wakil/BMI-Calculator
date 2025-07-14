class BmiData {
  final bool isMale;
  final double height;
  final double weight;
  final int age;

  BmiData({
    required this.isMale,
    required this.height,
    required this.weight,
    required this.age,
  });

  bool get isValid => height > 0 && weight > 0 && age > 0;
}
