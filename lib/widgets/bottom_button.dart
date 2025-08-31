import 'package:flutter/material.dart';
import '../constants/constants.dart';

class BottomButton extends StatelessWidget {
  late final String buttonTitle;
  late final VoidCallback? onTap;
  late final BorderRadius buttonBorderRadius;
  late final double buttonHeight;

  BottomButton({
    required this.buttonTitle,
    required this.onTap,
    required this.buttonBorderRadius,
    required this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: buttonBorderRadius,
          color: kBottomContainerColor,
        ),

        // padding: EdgeInsets.only(bottom: 15.0),
        margin: EdgeInsets.only(top: 15.0),
        height: buttonHeight,
        child: Center(
          child: Text(
            buttonTitle,
            style: kLargeButtonTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
