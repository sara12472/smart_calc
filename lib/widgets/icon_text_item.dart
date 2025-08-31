import 'package:flutter/material.dart';

class IconTextItem extends StatelessWidget {
  const IconTextItem({
    super.key,
    required this.image,
    required this.name,
    required this.textStyle,
    required this.imageHeight,
  });

  final String image;
  final String name;
  final TextStyle textStyle;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 70),
        SizedBox(height: 10),
        Text(name, textAlign: TextAlign.center, style: textStyle),
      ],
    );
  }
}
