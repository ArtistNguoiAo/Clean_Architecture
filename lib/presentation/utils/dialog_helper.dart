import 'package:flutter/material.dart';
import 'package:risky_coin/presentation/utils/text_style_utils.dart';
import 'package:risky_coin/presentation/utils/text_utils.dart';

class DialogHelper {
  static bool _isShowing = false;

  static void showLoadingDialog(BuildContext context) {
    if (_isShowing) return;
    _isShowing = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 8.0,
          contentPadding: const EdgeInsets.all(16.0),
          content: SizedBox(
            height: 150.0,
            width: 150.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
                Text(
                  TextUtils.loading,
                  style: TextStyleUtils.textStyleNunitoS18W500Black,
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context).pop();
      _isShowing = false;
    }
  }
}