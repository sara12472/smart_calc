import 'package:flutter/material.dart';
import 'package:smart_calc/Screens/Loan%20Calculator/loan_result_screen.dart';
import 'package:smart_calc/constants/constants.dart';
import 'package:smart_calc/Controller/loan_calc_controller.dart';
import 'package:smart_calc/widgets/bottom_button.dart';
import 'package:smart_calc/widgets/custom_radiobutton.dart';
import 'package:smart_calc/widgets/custom_textfield.dart';

class LoanConverter extends StatefulWidget {
  const LoanConverter({super.key});

  static const String id = 'loan_converter';

  @override
  State<LoanConverter> createState() => _LoanConverterState();
}

class _LoanConverterState extends State<LoanConverter> {
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController loanTermController = TextEditingController();
  String? selectedFrequency = "Monthly";
  String? selectedTerm = "Monthly";

  @override
  void dispose() {
    // Memory leak avoid karne ke liye controllers dispose karna zaroori hai
    loanAmountController.dispose();
    interestRateController.dispose();
    loanTermController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kActiveCardColor,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
              ),
            ),
            SizedBox(height: 5.0),
            Image(image: AssetImage('images/loan.png'), height: 70.0),
            SizedBox(height: 20.0),
            Center(
              child: Text(
                'Loan Calculator',
                textAlign: TextAlign.center,
                style: kHeaderMainText,
              ),
            ),
            SizedBox(height: 30.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 50,
                      left: 30,
                      right: 30,
                      bottom: 30,
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: 'Enter loan amount',
                          controller: loanAmountController,
                        ),
                        SizedBox(height: 30.0),
                        CustomTextField(
                          hintText: 'Enter interest rate',
                          controller: interestRateController,
                        ),
                        SizedBox(height: 30.0),
                        CustomTextField(
                          hintText: 'Enter loan term',
                          controller: loanTermController,
                        ),

                        SizedBox(height: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loan Frequency",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ), // spacing between label and buttons
                            Row(
                              children: [
                                CustomRadioButton<String>(
                                  value: 'Monthly',
                                  groupValue: selectedFrequency,
                                  title: 'Monthly',
                                  onChanged: (value) {
                                    setState(() {
                                      selectedFrequency = value!;
                                    });
                                  },
                                ),
                                SizedBox(width: 16), // spacing between buttons
                                CustomRadioButton<String>(
                                  value: 'Yearly',
                                  groupValue: selectedFrequency,
                                  title: 'Yearly',
                                  onChanged: (value) {
                                    setState(() {
                                      selectedFrequency = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 120.0),
                            BottomButton(
                              buttonTitle: 'CALCULATE',
                              onTap: () {
                                double loanAmount =
                                    double.tryParse(
                                      loanAmountController.text,
                                    ) ??
                                    0.0;
                                double interestRate =
                                    double.tryParse(
                                      interestRateController.text,
                                    ) ??
                                    0.0;
                                double loanTerm =
                                    double.tryParse(loanTermController.text) ??
                                    0.0;

                                LoanCalculatorController controller =
                                    LoanCalculatorController(
                                      loanAmount: loanAmount,
                                      interestRate: interestRate,
                                      loanTerm: loanTerm,
                                      frequency: selectedFrequency ?? "Monthly",
                                    );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoanResultScreen(
                                      totalAmount: controller
                                          .calculateTotalPayment(),
                                      loanAmount: controller.loanAmount,
                                      interestRate: controller.interestRate,
                                      loanTerm: controller.loanTerm,
                                      loanFrequency: controller.frequency,
                                      totalInterest: controller
                                          .calculateTotalInterest(),
                                    ),
                                  ),
                                );
                                //Navigator.pushNamed(context, LoanResultScreen.id);
                              },

                              buttonBorderRadius: BorderRadius.circular(10.0),
                              buttonHeight: 70.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
