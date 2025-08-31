import 'package:flutter/material.dart';

class BasicCalcButton extends StatelessWidget {
  late final String text;
  late final VoidCallback onPressed;
  late final Color? color;

  BasicCalcButton({
    required this.text,
    required this.onPressed,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(backgroundColor: color ?? Colors.grey[200]),

      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
        ),
      ),
    );
  }
}
