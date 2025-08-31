import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_calc/constants/constants.dart';
import 'package:smart_calc/data/API_service.dart';
import 'package:smart_calc/widgets/bottom_button.dart';
import 'package:smart_calc/widgets/custom_app_header.dart';
import 'package:smart_calc/widgets/reusable_card.dart';

import '../data/date_converter_data.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_textfield.dart';

class DateConverter extends StatefulWidget {
  static const String id = 'date_converter';
  const DateConverter({super.key});

  @override
  State<DateConverter> createState() => _DateConverterState();
}

class _DateConverterState extends State<DateConverter> {
  final TextEditingController dateController = TextEditingController();
  String fromCalender = 'Gregorian';
  String toCalender = 'Hijri';
  String? result = '';
  String? day = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(600),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text =
            "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
      });
    }
  }

  void getData() async {
    if (dateController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please select a date first")));
      return;
    }

    String formattedDate = dateController.text; // ab direct hyphen wala hai
    ApiService calenderData = ApiService();
    var data = await calenderData.getCalenderData(
      fromCalender,
      toCalender,
      formattedDate,
    );
    print(data);

    setState(() {
      if (fromCalender == "Gregorian" && toCalender == "Hijri") {
        result = data['data']['hijri']['date'].toString();
        day = data['data']['hijri']['weekday']['en'].toString();
      } else if (fromCalender == "Hijri" && toCalender == "Gregorian") {
        result = data['data']['gregorian']['date'].toString();
        day = data['data']['gregorian']['weekday']['en'].toString();
      } else {
        result = data['data']['gregorian']['date'].toString();
        day = data['data']['gregorian']['weekday']['en'].toString();
      }
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
      body: Column(
        children: [
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: CustomAppHeader(
              text: 'Date Converter',
              imagePath: 'images/cal.png',
            ),
            onPress: () {},
            margin: EdgeInsets.zero,
            containerHeight: 350.0,
            containerBorderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: dateController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: "Select Date",
                                    labelStyle: TextStyle(
                                      color: dateController.text.isEmpty
                                          ? Colors.grey
                                          : kBottomContainerColor, // label text color
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    suffixIcon: Icon(
                                      Icons.calendar_today,
                                      color: kActiveCardColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color: kActiveCardColor,
                                        width: 1.5,
                                      ), // default border color
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color: kBottomContainerColor,
                                        width: 2.0,
                                      ), // border color when focused
                                    ),
                                  ),
                                  onTap: () => _selectDate(context),
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
                                  selectedCurrency: fromCalender,
                                  currencies: calendersList,
                                  onChanged: (fromValue) {
                                    setState(() {
                                      fromCalender = fromValue!;
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
                                  selectedCurrency: toCalender,
                                  currencies: calendersList,
                                  onChanged: (toValue) {
                                    setState(() {
                                      toCalender = toValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 30.0),
                                child: BottomButton(
                                  buttonTitle: 'CONVERT',
                                  onTap: () {
                                    getData();
                                  },
                                  buttonBorderRadius: BorderRadius.circular(
                                    20.0,
                                  ),
                                  buttonHeight: 70.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onPress: () {},
                    margin: EdgeInsets.zero,
                    containerHeight: 0,
                    containerBorderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ),
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Converted date: $result',
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Day: $day',
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                    SizedBox(height: 30),

                    // 👇 Row for icons with text
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomIconButton(
                          text: 'share',
                          icon: Icons.share,
                          onPressed: () {
                            if (result != null && result!.isNotEmpty) {
                              Share.share("Converted amount is $result");
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("No result to share!"),
                                ),
                              );
                            }
                          },
                          color: Colors.white,
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Copied: $result")),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("No result to copy!"),
                                ),
                              );
                            }
                          },
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            onPress: () {},
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            containerHeight: 200.0,
            containerBorderRadius: BorderRadius.circular(20.0),
          ),
        ],
      ),
    );
  }
}
