import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/constants.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furkan Yağmur',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        brightness: Brightness.light,
        fontFamily: 'Comfortaa',
        scaffoldBackgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        dividerTheme: const DividerThemeData(
          color: kTextColor,
          thickness: 0.1,
          endIndent: 0,
          indent: 0,
          space: 16,
        ),
        dividerColor: kTextColor,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
