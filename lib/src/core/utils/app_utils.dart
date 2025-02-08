import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/themes/app_colors.dart';

class AppUtils {
  AppUtils._();

  static void errorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.error,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void successToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
