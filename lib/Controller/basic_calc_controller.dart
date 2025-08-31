import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorController {
  final List<String> Buttons = [
    'C',
    '⌫',
    '%',
    '/',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '=',
  ];

  final TextEditingController inputController = TextEditingController();
  String result = '';

  /// Handle button press
  void onButtonPressed(String value) {
    if (value == 'C') {
      inputController.clear();
      result = '';
    } else if (value == '⌫') {
      if (inputController.text.isNotEmpty) {
        inputController.text = inputController.text.substring(
          0,
          inputController.text.length - 1,
        );
      }
    } else if (value == '=') {
      calculate();
    } else {
      inputController.text += value;
    }
  }

  /// Calculate the result
  void calculate() {
    String expression = inputController.text.replaceAll('×', '*');

    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // This is the added logic to check for a whole number
      if (eval % 1 == 0) {
        result = eval
            .toInt()
            .toString(); // Convert to int if it's a whole number
      } else {
        result = eval.toString(); // Keep as double for decimal numbers
      }
    } catch (e) {
      result = 'Error';
    }
  }
}
