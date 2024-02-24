import 'package:flutter/material.dart';
import 'package:location_tracker/utils/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  PrimaryButton({required this.buttonText, required this.buttonColor, required this.textColor, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * (screenWidth < 600 ? 0.9 : 0.45);
    double buttonHeight = 50;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor
        ),
        child: Text(buttonText, style: AppTextStyles.fontSize16.copyWith(color: textColor).copyWith(fontWeight: FontWeight.bold),),
      ),
    );
  }
}