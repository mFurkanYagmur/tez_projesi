import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/constants.dart';

// enum UIType {
//   success,
//   info,
//   warning,
//   danger,
// }
//
// extension UITypeExtension on UIType {
//   Color getColor() {
//     switch(this) {
//       case UIType.success: return
//     }
//   }
// }

class UIHelper {
  static showSnackBar({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kPrimaryColor,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        content: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
