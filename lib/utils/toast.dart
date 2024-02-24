import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location_tracker/utils/app_colors.dart';

class ToastUtils {
  static void showToast(BuildContext context,String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.black,
      textColor: AppColors.white,
      fontSize: 16.0,
    );
  }
}