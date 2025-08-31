import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  CustomIconButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Row(
        children: [
          Icon(icon, color: color, size: 30.0),
          SizedBox(width: 5),
          Text(text, style: TextStyle(color: color, fontSize: 15.0)),
        ],
      ),
    );
  }
}
