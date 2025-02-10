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

  static Positioned contributeUserItem(
      double left, double top, double bottom, String imagePath, Color color,
      {String? text}) {
    return Positioned(
      left: left,
      top: top,
      bottom: bottom,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: (text != null) ? 30 : 16,
          height: 16,
          color: color,
          child: (text == null)
              ? Image.asset(imagePath)
              : Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  static Positioned contributeUserDescription(
      double left, double top, double bottom, String imagePath, Color color,
      {String? text}) {
    return Positioned(
      left: left,
      top: top,
      bottom: bottom,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: 16,
          color: color,
          child: (text == null)
              ? Image.asset(imagePath)
              : Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
