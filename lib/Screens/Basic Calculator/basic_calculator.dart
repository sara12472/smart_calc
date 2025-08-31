import 'package:flutter/material.dart';
import 'package:smart_calc/constants/constants.dart';
import 'package:smart_calc/Controller/basic_calc_controller.dart';
import 'package:smart_calc/widgets/reusable_card.dart';

import '../../widgets/Basic_calc_buttons.dart';

class BasicCalculator extends StatefulWidget {
  static const String id = 'basic_calculator';
  const BasicCalculator({super.key});

  @override
  State<BasicCalculator> createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends State<BasicCalculator> {
  final CalculatorController _controller =
      CalculatorController(); // ✅ controller object
  late final List<String> _buttons; // ✅ buttons list

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _buttons = _controller.Buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kActiveCardColor,
        title: Text('Basic Calculator', style: kTopHeaderTextStyle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to previous screen
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: Padding(
              padding: EdgeInsets.only(right: 30.0, bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _controller.inputController,
                    style: TextStyle(
                      fontSize: 70,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none, // no border
                    ),
                    textAlign: TextAlign.right,
                    readOnly: true,
                  ),
                  SizedBox(height: 3),
                  Text(
                    _controller.result,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ],
              ),
            ),
            onPress: () {},
            margin: EdgeInsets.zero,
            containerHeight: 250.0,
            containerBorderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(top: 30),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
              ),
              itemCount: _controller.Buttons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: BasicCalcButton(
                    text: _buttons[index],
                    onPressed: () {
                      setState(() {
                        _controller.onButtonPressed(_buttons[index]);
                      });
                    },
                    color: (_buttons[index] == 'C')
                        ? Colors
                              .grey // Clear button ka color
                        : (_buttons[index] == '=')
                        ? Colors
                              .grey // Equal button ka color
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
