import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/constants.dart';

class EditHomePage extends StatefulWidget {
  const EditHomePage({Key? key}) : super(key: key);

  @override
  State<EditHomePage> createState() => _EditHomePageState();
}

class _EditHomePageState extends State<EditHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Başlık',
            ),
          ),
          SizedBox(height: kVerticalPadding/3,),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'İçerik 1',
            ),
          ),
          SizedBox(height: kVerticalPadding/3,),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'İçerik 2',
            ),
          ),
          SizedBox(height: kVerticalPadding/3,),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'İçerik 3',
            ),
          ),
          SizedBox(height: kVerticalPadding/3,),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'İçerik 4',
            ),
          ),
        ],
      ),
    );
  }
}
