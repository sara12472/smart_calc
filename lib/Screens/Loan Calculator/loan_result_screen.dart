import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../widgets/bottom_button.dart';
import '../../widgets/reusable_card.dart';

class LoanResultScreen extends StatelessWidget {
  static const String id = 'loan_result_screen';
  final double totalAmount;
  final double loanAmount;
  final double interestRate;
  final double loanTerm;
  final String loanFrequency;
  final double totalInterest;

  LoanResultScreen({
    required this.totalAmount,
    required this.loanAmount,
    required this.interestRate,
    required this.loanTerm,
    required this.loanFrequency,
    required this.totalInterest,
  });

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
                cardChild: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        totalAmount.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Loan Amount: ${loanAmount.toStringAsFixed(2)}",
                                  style: kBodyTextStyle,
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "Interest Rate: ${interestRate.toString()}%",
                                  style: kBodyTextStyle,
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "Loan Term: ${loanTerm.toString()} $loanFrequency",
                                  style: kBodyTextStyle,
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "Total Interest Rate: ${totalInterest.toStringAsFixed(2)}",
                                  style: kBodyTextStyle,
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "Total Amount : ${totalAmount.toStringAsFixed(2)} ",
                                  style: kBodyTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                onPress: () {},
                margin: EdgeInsets.all(20.0),
                containerHeight: 0.0,
                containerBorderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 30.0,
              ),
              child: BottomButton(
                buttonTitle: 'RECALCULATE',
                onTap: () {
                  Navigator.pop(context);
                },
                buttonBorderRadius: BorderRadius.circular(10.0),
                buttonHeight: 70.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
