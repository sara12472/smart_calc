import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:smart_calc/constants/constants.dart';
import 'package:smart_calc/widgets/bottom_button.dart';
import 'package:smart_calc/widgets/custom_app_header.dart';
import 'package:smart_calc/widgets/reusable_card.dart';
import 'package:image_picker/image_picker.dart';

class SnapCalculator extends StatefulWidget {
  static const String id = 'snap_calculator';
  const SnapCalculator({super.key});

  @override
  State<SnapCalculator> createState() => _SnapCalculatorState();
}

class _SnapCalculatorState extends State<SnapCalculator> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String _recognizedText = 'No expression detected.';
  String _result = '';

  // 📌 Pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _recognizedText = 'Recognizing text...';
        _result = '';
      });
      _performCalculation();
    }
  }

  void _clearImageAndResult() {
    setState(() {
      _selectedImage = null;
      _recognizedText = 'No expression detected.';
      _result = '';
    });
  }

  Future<void> _performCalculation() async {
    if (_selectedImage == null) {
      setState(() {
        _result = 'Please select an image first.';
      });
      return;
    }

    try {
      final textRecognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );
      final inputImage = InputImage.fromFile(_selectedImage!);
      final recognizedTextObject = await textRecognizer.processImage(
        inputImage,
      );
      await textRecognizer.close();

      final rawText = recognizedTextObject.text;
      debugPrint("RAW OCR OUTPUT: $rawText");

      String expression = rawText
          .replaceAll('x', '*')
          .replaceAll('X', '*')
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll(',', '.')
          .replaceAll('O', '0')
          .replaceAll('o', '0')
          .replaceAll('I', '1')
          .replaceAll('l', '1');

      expression = expression.replaceAll(RegExp(r'\s+'), '');
      final validRuns = RegExp(
        r'[0-9+\-*/().]+',
      ).allMatches(expression).map((m) => m.group(0)!).toList();

      if (validRuns.isEmpty) {
        setState(() {
          _recognizedText = 'No expression found.';
          _result = 'Invalid Expression';
        });
        return;
      }

      validRuns.sort((a, b) => b.length.compareTo(a.length));
      expression = validRuns.first;

      setState(() {
        _recognizedText = expression;
      });

      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        double evalResult = exp.evaluate(EvaluationType.REAL, cm);

        setState(() {
          _result = evalResult.toStringAsFixed(2);
        });
      } catch (e) {
        setState(() {
          _result = 'Invalid Expression';
        });
        debugPrint('Error evaluating expression: $e');
      }
    } catch (e) {
      setState(() {
        _result = 'Error during calculation.';
      });
      debugPrint('Error during calculation: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 👆 Header Card
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: CustomAppHeader(
              text: 'Snap Calculator',
              imagePath: 'images/cam.png',
            ),
            onPress: () {},
            margin: EdgeInsets.zero,
            containerHeight: 350.0,
            containerBorderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
          ),

          // 👇 Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: ReusableCard(
                  colour: Colors.white,
                  containerBorderRadius: BorderRadius.circular(20.0),
                  cardChild: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Image or upload button
                        if (_selectedImage != null)
                          Image.file(
                            _selectedImage!,
                            height: 200,
                            fit: BoxFit.contain,
                          )
                        else
                          TextButton.icon(
                            icon: Icon(
                              Icons.photo_library,
                              size: 30,
                              color: kActiveCardColor,
                            ),
                            label: Text(
                              "Upload image",
                              style: TextStyle(
                                fontSize: 18,
                                color: kActiveCardColor,
                              ),
                            ),
                            onPressed: _pickImageFromGallery,
                          ),

                        const SizedBox(height: 20),

                        // Recognized expression
                        Text(
                          _recognizedText,
                          style: const TextStyle(
                            fontSize: 22.0,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),

                        // Result
                        Text(
                          _result.isEmpty ? '' : 'Result: $_result',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: kActiveCardColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),

                        // Bottom Button
                        BottomButton(
                          buttonTitle: _selectedImage == null
                              ? 'Select Image'
                              : 'Clear',
                          onTap: () {
                            if (_selectedImage == null) {
                              _pickImageFromGallery();
                            } else {
                              _clearImageAndResult();
                            }
                          },
                          buttonBorderRadius: BorderRadius.circular(20.0),
                          buttonHeight: 60,
                        ),
                      ],
                    ),
                  ),
                  onPress: () {},
                  margin: EdgeInsets.zero,
                  containerHeight: 0, // auto size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
