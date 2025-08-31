import 'package:flutter/material.dart';
import 'package:smart_calc/constants/constants.dart';

import 'icon_text_item.dart';

class categoriesCard extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final String name;
  categoriesCard({
    required this.image,
    required this.name,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: IconTextItem(
          image: image,
          name: name,
          textStyle: kCardCategoryText,
          imageHeight: 50.0,
        ),
      ),
    );
  }
}

/**/
