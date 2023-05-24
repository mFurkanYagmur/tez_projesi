import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/extensions.dart';

import '../constants.dart';

class CustomSolidButton extends StatelessWidget {
  const CustomSolidButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          shape: const StadiumBorder(),
          backgroundColor: kPrimaryColor,
          padding: const EdgeInsets.all(24)),
      onPressed: onPressed,
      child: Text(text.toUpperCaseLocalized()),
    );
  }
}
