import 'dart:math';

class CalculatorBrain {
  late final int weight;
  late final int height;

  double _bmi = 0;
  CalculatorBrain({required this.weight, required this.height});

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String interpretation() {
    if (_bmi >= 25) {
      return 'You have higher than normal body weight, Try to exercise more';
    } else if (_bmi > 18.5) {
      return 'You have normal body weight ! good job';
    } else {
      return 'You have a lower than normal body weight, you can eat a bit more!';
    }
  }
}
