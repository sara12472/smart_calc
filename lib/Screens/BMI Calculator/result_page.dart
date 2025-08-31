import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../widgets/bottom_button.dart';
import '../../widgets/reusable_card.dart';

class ResultPage extends StatelessWidget {
  static const String id = 'result_page';
  final String bmiResult;
  final String resultText;
  final String interpretation;

  ResultPage({
    required this.bmiResult,
    required this.resultText,
    required this.interpretation,
  }) {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text('Your Result', style: kTitleTextStyle),
              ),
            ),
            Expanded(
              flex: 5,
              child: ReusableCard(
                colour: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(resultText, style: kResultTextStyle),
                    Text(bmiResult, style: kBMITextStyle),
                    Text(
                      interpretation,
                      textAlign: TextAlign.center,
                      style: kBodyTextStyle,
                    ),
                  ],
                ),
                onPress: () {},
                margin: EdgeInsets.all(20.0),
                containerHeight: 0.0,
                containerBorderRadius: BorderRadius.circular(10.0),
              ),
            ),
            BottomButton(
              buttonTitle: 'RECALCULATE',
              onTap: () {
                Navigator.pop(context);
              },
              buttonBorderRadius: BorderRadius.zero,
              buttonHeight: 80.0,
            ),
          ],
        ),
      ),
    );
  }
}
