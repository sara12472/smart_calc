import 'package:flutter/material.dart';
import 'package:smart_calc/Screens/BMI%20Calculator/BMI_home.dart';
import 'package:smart_calc/Screens/Basic%20Calculator/basic_calculator.dart';
import 'package:smart_calc/Screens/currency_converter.dart';
import 'package:smart_calc/Screens/date_converter.dart';
import 'package:smart_calc/Screens/Loan%20Calculator/loan_calculator_home.dart';
import 'package:smart_calc/Screens/percentage_converter.dart';
import 'package:smart_calc/Screens/snap_calculator.dart';
import 'package:smart_calc/Screens/unit_converter.dart';
import 'package:smart_calc/constants/constants.dart';
import 'package:smart_calc/data/category_data.dart';
import 'package:smart_calc/widgets/icon_text_item.dart';
import 'package:smart_calc/widgets/reusable_card.dart';
import '../widgets/Category_card.dart';
import '../widgets/image_text_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final categories = CategoryData().categories;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: ImageTextItem(
              text: ' Smart Calculator',
              imagePath: 'images/logo.png',
            ),
            onPress: () {},
            margin: EdgeInsets.zero,
            containerHeight: 300.0,
            containerBorderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(
                top: 50,
                left: 50,
                right: 50,
                bottom: 70,
              ),
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return categoriesCard(
                  image: categories[index].icon,
                  name: categories[index].name,
                  onTap: () {
                    if (categories[index].name == 'Basic Calculator') {
                      Navigator.pushNamed(context, BasicCalculator.id);
                    } else if (categories[index].name == 'BMI Calculator') {
                      Navigator.pushNamed(context, BMICalculator.id);
                    } else if (categories[index].name == 'Currency Converter') {
                      Navigator.pushNamed(context, CurrencyConverter.id);
                    } else if (categories[index].name == 'Date Converter') {
                      Navigator.pushNamed(context, DateConverter.id);
                    } else if (categories[index].name == 'Loan Calculator') {
                      Navigator.pushNamed(context, LoanConverter.id);
                    } else if (categories[index].name ==
                        'Percentage Converter') {
                      Navigator.pushNamed(context, PercentageConverter.id);
                    } else if (categories[index].name == 'Unit Converter') {
                      Navigator.pushNamed(context, UnitConverter.id);
                    } else if (categories[index].name == 'Snap Calculator') {
                      Navigator.pushNamed(context, SnapCalculator.id);
                    } else {
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
