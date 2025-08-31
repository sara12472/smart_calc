import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/constants.dart';

class IconContent extends StatelessWidget {
  IconContent(this.icon, this.label);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(icon, size: 80.0, color: Colors.white),
        SizedBox(height: 5.0),
        Text(label, style: kLabelTextStyle),
      ],
    );
  }
}
