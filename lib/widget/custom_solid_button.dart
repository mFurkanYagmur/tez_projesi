import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/util/extensions.dart';

import '../util/constants.dart';

class CustomSolidButton extends StatelessWidget {
  const CustomSolidButton({Key? key, required this.text, required this.onPressed, this.bgFilled = true, this.padding = const EdgeInsets.all(24)}) : super(key: key);

  final String text;
  final Function()? onPressed;
  final bool bgFilled;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: bgFilled ? null : 0,
        shadowColor: bgFilled ? null : Colors.transparent,
        surfaceTintColor: kPrimaryColor,
        shape: const StadiumBorder(),
        backgroundColor: bgFilled ? kPrimaryColor : Colors.transparent,
        padding: padding,
      ),
      onPressed: onPressed,
      child: Text(
        text.toUpperCaseLocalized(),
        style: TextStyle(
          color: bgFilled ? Colors.white : kPrimaryColor,
        ),
      ),
    );
  }
}
