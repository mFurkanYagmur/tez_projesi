import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/util/constants.dart';

import 'firebase_options.dart';
import 'util/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kLigthGreyBGColor, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          labelStyle: const TextStyle(color: kTextColor),
          alignLabelWithHint: true,
        ),
        dividerColor: kTextColor,
      ),
      onGenerateRoute: Routes.onGenerateRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
