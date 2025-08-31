import 'package:flutter/material.dart';
import 'package:smart_calc/constants/constants.dart';

class ImageTextItem extends StatelessWidget {
  late final String text;
  late final String imagePath;

  ImageTextItem({required this.text, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: Hero(
            tag: 'logo',
            child: Image(image: AssetImage(imagePath), height: 100.0),
          ),
        ),
        SizedBox(height: 20.0),
        Center(child: Text(text, style: kMainTextStyle)),
      ],
    );
  }
}
