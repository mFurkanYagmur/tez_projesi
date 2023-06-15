import 'package:flutter/material.dart';

enum UIType {
  success,
  info,
  warning,
  danger,
}

extension UITypeExtension on UIType {
  Color getColor() {
    switch (this) {
      case UIType.success:
        return Colors.lightGreen;
      case UIType.info:
        return Colors.blueAccent;
      case UIType.warning:
        return Colors.deepOrangeAccent;
      case UIType.danger:
        return Colors.redAccent;
    }
  }
}

class UIHelper {
  static showSnackBar({required BuildContext context, required String text, required UIType type}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: type.getColor(),
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
