import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_calc/constants/constants.dart';
import 'package:smart_calc/data/API_service.dart';
import 'package:smart_calc/widgets/bottom_button.dart';
import 'package:smart_calc/widgets/reusable_card.dart';
import 'package:smart_calc/widgets/custom_dropdown.dart';
import 'package:smart_calc/widgets/custom_textfield.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/custom_app_header.dart';
import '../widgets/custom_icon_button.dart';

class CurrencyConverter extends StatefulWidget {
  static const String id = 'currency_converter';
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController currencyAmount = TextEditingController();
  List<String> currencyList = [];
  late String fromCurrency = 'AUD';
  late String toCurrency = 'BGN';
  String? result = '';
  bool isLoading = true;

  void getData() async {
    try {
      ApiService currencyData = ApiService();
      String amountText = currencyAmount.text;
      double amount = double.tryParse(amountText) ?? 1.0;

      var data = await currencyData.getCurrencyData(
        fromCurrency,
        toCurrency,
        amount,
      );

      setState(() {
        result = data['rates'][toCurrency].toString();
        // isLoading = false; <-- Yeh line yahan se hata di gayi hai
      });
    } catch (e) {
      print('getData Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to convert currency. Please try again later.'),
        ),
      );
    }
  }

  Future<void> loadCurrencies() async {
    setState(() {
      isLoading = true; // Loading shuru karein
    });
    try {
      ApiService currencyData = ApiService();
      var currencies = await currencyData.getCurrencies();

      setState(() {
        currencyList = currencies.keys.toList();
        if (currencyList.isNotEmpty) {
          fromCurrency = currencyList.first;
          toCurrency = currencyList[1];
        }
        isLoading = false; // Loading khatam hone par false karein
      });
    } catch (e) {
      print('loadCurrencies Error: $e');
      setState(() {
        isLoading = false; // Error par bhi false karein
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load currencies. Check your connection.'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Top big card
            ReusableCard(
              colour: kActiveCardColor,
              cardChild: CustomAppHeader(
                text: 'Currency Converter',
                imagePath: 'images/currency.png',
              ),
              onPress: () {},
              margin: EdgeInsets.zero,
              containerHeight: 350.0,
              containerBorderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),

            /// Second card overlapped with Transform
            Transform.translate(
              offset: Offset(0, -50),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20.0),
                    child: ReusableCard(
                      colour: Colors.white,
                      cardChild: isLoading
                          ? Container(
                              height: 450.0,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: kActiveCardColor,
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 20.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 325,
                                        child: CustomTextField(
                                          hintText: 'Amount',
                                          controller: currencyAmount,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: CustomDropdown(
                                          selectedCurrency: fromCurrency,
                                          currencies: currencyList,
                                          onChanged: (fromValue) {
                                            setState(() {
                                              fromCurrency = fromValue!;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        'To',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Flexible(
                                        child: CustomDropdown(
                                          selectedCurrency: toCurrency,
                                          currencies: currencyList,
                                          onChanged: (toValue) {
                                            setState(() {
                                              toCurrency = toValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30.0),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BottomButton(
                                        buttonTitle: 'CONVERT',
                                        onTap: () {
                                          setState(() {
                                            getData();
                                          });
                                        },
                                        buttonBorderRadius:
                                            BorderRadius.circular(20.0),
                                        buttonHeight: 70.0,
                                      ),
                                      SizedBox(height: 30.0),
                                      Text(
                                        'Converted Amount :$result',
                                        style: kShowResultText,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomIconButton(
                                        text: 'share',
                                        icon: Icons.share,
                                        onPressed: () {
                                          if (result != null &&
                                              result!.isNotEmpty) {
                                            Share.share(
                                              "Converted amount is $result",
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "No result to share!",
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 10),
                                      CustomIconButton(
                                        text: 'copy',
                                        icon: Icons.copy,
                                        onPressed: () {
                                          if (result != null &&
                                              result!.isNotEmpty) {
                                            Clipboard.setData(
                                              ClipboardData(
                                                text: result.toString(),
                                              ),
                                            );
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Copied: $result",
                                                ),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "No result to copy!",
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      onPress: () {},
                      margin: EdgeInsets.zero,
                      containerHeight: 450.0,
                      containerBorderRadius: BorderRadius.circular(20.0),
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
