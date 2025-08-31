import 'package:flutter/material.dart';
import 'package:smart_calc/constants/constants.dart';

class CustomAppHeader extends StatelessWidget {
  final String text;
  final String imagePath;

  const CustomAppHeader({
    super.key,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
            ),
          ),
          SizedBox(height: 10),
          Image(image: AssetImage(imagePath), height: 80.0),

          SizedBox(height: 20.0),

          Text(
            text,
            textAlign: TextAlign.center,
            style: kHeaderMainText
          ),
        ],
      ),
    );
  }
}
