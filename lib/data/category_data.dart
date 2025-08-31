import 'package:flutter/material.dart';
import 'package:smart_calc/Screens/Basic%20Calculator/basic_calculator.dart';
import 'package:smart_calc/models/category.dart';

class CategoryData {
  final List<Category> categories = [
    Category(name: 'Basic Calculator', icon: 'images/basic.png'),
    Category(name: 'Loan Calculator', icon: 'images/loan.png'),
    Category(name: 'Snap Calculator', icon: 'images/cam.png'),
    Category(name: 'Date Converter', icon: 'images/cal.png'),
    Category(name: 'BMI Calculator', icon: 'images/bmi.png'),
    Category(name: 'Currency Converter', icon: 'images/currency.png'),
    Category(name: 'Unit Converter', icon: 'images/unit.png'),
  ];
}
