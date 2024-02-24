import 'package:flutter/material.dart';
import 'package:location_tracker/utils/app_colors.dart';
import 'package:location_tracker/utils/text_styles.dart';

void showConfirmationDialog(BuildContext context, IconData icon, String msg,
    String btnLeftTitle, String btnRightTitle, VoidCallback onLeftPressed, VoidCallback onRightPressed) {
  showDialog(
    context: context,
    builder: (BuildContext context2) {
      return AlertDialog(
        backgroundColor: AppColors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: <Widget>[
            Icon(
              icon,
              size: 64,
            ), // Error icon

            SizedBox(height: 10),

            Text(
              msg,
              style: AppTextStyles.fontSize18
            ),
          ],
        ),
        // content: const Text('OOPS, Invalid OTP!'),
        content: Container(
          height: 0,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onLeftPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppColors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      100.0), // Adjust the value as needed
                ),
              ), // Background color
            ),
            child: Text(
              btnLeftTitle,
              style: AppTextStyles.fontSize16.copyWith(color: AppColors.white),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width*.15), // Add some space between buttons
          TextButton(
            onPressed: onRightPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppColors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      100.0), // Adjust the value as needed
                ),
              ), // Background color
            ),
            child: Text(
              btnRightTitle,
              style: AppTextStyles.fontSize16.copyWith(color: AppColors.white),
            ),
          ),
        ],
      );
    },
  );
}