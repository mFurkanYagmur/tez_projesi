import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key, this.fontSize = 24, this.color = Colors.white}) : super(key: key);

  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      'MFY',
      style: TextStyle(
        fontFamily: 'BrunoAce',
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
