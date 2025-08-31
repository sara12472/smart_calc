import 'dart:ffi';

import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color colour;
  final Widget cardChild;
  final VoidCallback? onPress; //Function
  final EdgeInsetsGeometry margin;
  final double containerHeight;
  final BorderRadius containerBorderRadius;

  ReusableCard({
    required this.colour,
    required this.cardChild,
    required this.onPress,
    required this.margin,
    required this.containerHeight,
    required this.containerBorderRadius,
  }) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        clipBehavior: Clip.none,
        height: containerHeight > 0 ? containerHeight : null,
        margin: margin,
        decoration: BoxDecoration(
          color: colour,
          borderRadius: containerBorderRadius,
        ),
        child: cardChild,
      ),
    );
  }
}
