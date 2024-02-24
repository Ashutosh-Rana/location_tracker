import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String prefixText;
  final String dynamicText;
  final Color prefixColor;
  final Color dynamicTextColor;
  final double fontSize;

  CustomRichText({
    required this.prefixText,
    required this.dynamicText,
    this.prefixColor = Colors.black,
    this.dynamicTextColor = Colors.grey,
    this.fontSize = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: prefixText,
            style: TextStyle(
              color: prefixColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold
            ),
          ),
          TextSpan(
            text: dynamicText,
            style: TextStyle(
              color: dynamicTextColor,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
