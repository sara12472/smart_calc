import 'package:flutter/material.dart';
import 'package:smart_calc/Screens/BMI%20Calculator/BMI_home.dart';
import 'package:smart_calc/Screens/Loan%20Calculator/loan_result_screen.dart';
import 'package:smart_calc/Screens/Basic%20Calculator/basic_calculator.dart';
import 'package:smart_calc/Screens/home_screen.dart';
import 'package:smart_calc/Screens/splash_screen.dart';
import 'package:smart_calc/Screens/unit_converter.dart';
import 'Screens/BMI Calculator/result_page.dart';
import 'Screens/currency_converter.dart';
import 'Screens/date_converter.dart';
import 'Screens/Loan Calculator/loan_calculator_home.dart';
import 'Screens/percentage_converter.dart';
import 'Screens/snap_calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        BasicCalculator.id: (context) => BasicCalculator(),
        CurrencyConverter.id: (context) => CurrencyConverter(),
        BMICalculator.id: (context) => BMICalculator(),
        DateConverter.id: (context) => DateConverter(),
        LoanConverter.id: (context) => LoanConverter(),
        PercentageConverter.id: (context) => PercentageConverter(),
        UnitConverter.id: (context) => UnitConverter(),
        SnapCalculator.id: (context) => SnapCalculator(),
      },
    );
  }
}
