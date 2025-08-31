import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_calc/data/API_service.dart';
import 'package:smart_calc/data/unit_converter_data.dart';
import 'package:smart_calc/widgets/custom_app_header.dart';

import '../constants/constants.dart';
import '../widgets/bottom_button.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/reusable_card.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_textfield.dart';

class UnitConverter extends StatefulWidget {
  static const String id = 'unit_converter';

  const UnitConverter({super.key});

  @override
  State<UnitConverter> createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  final TextEditingController unitValue = TextEditingController();
  String fromUnit = 'm';
  String toUnit = 'cm';
  String? result = '';

  void getData() async {
    double value = double.tryParse(unitValue.text) ?? 0.0;
    ApiService uniConversion = ApiService();
    var data = await uniConversion.getUnitData(fromUnit, toUnit, value);
    print(data);

    setState(() {
      result = data['convertedValue'].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
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
                text: 'Unit Converter',
                imagePath: 'images/unit.png',
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
              offset: Offset(0, -50), // yaha se overlap control hota hai
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20.0),
                    child: ReusableCard(
                      colour: Colors.white,
                      cardChild: Padding(
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
                                    hintText: 'Enter unit',
                                    controller: unitValue,
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
                                    selectedCurrency: fromUnit,
                                    currencies: unitList,
                                    onChanged: (fromValue) {
                                      setState(() {
                                        fromUnit = fromValue!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 30),
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
                                    selectedCurrency: toUnit,
                                    currencies: unitList,
                                    onChanged: (toValue) {
                                      setState(() {
                                        toUnit = toValue!;
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
                                  buttonBorderRadius: BorderRadius.circular(
                                    20.0,
                                  ),
                                  buttonHeight: 70.0,
                                ),
                                SizedBox(height: 30.0),
                                Text(
                                  'Converted Unit: $result$toUnit',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kActiveCardColor,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomIconButton(
                                  text: 'share',
                                  icon: Icons.share,
                                  onPressed: () {
                                    if (result != null && result!.isNotEmpty) {
                                      Share.share(
                                        "Converted amount is $result",
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("No result to share!"),
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
                                    if (result != null && result!.isNotEmpty) {
                                      Clipboard.setData(
                                        ClipboardData(text: result.toString()),
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Copied: $result"),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("No result to copy!"),
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
