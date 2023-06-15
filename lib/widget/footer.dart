import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/util/constants.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: kLigthGreyBGColor,
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(style: Theme.of(context).textTheme.titleSmall, children: const [
          TextSpan(text: 'Copyright © 2023 '),
          TextSpan(
            text: 'Furkan Yağmur',
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
          TextSpan(text: '. Tüm Hakları Saklıdır.'),
        ]),
      ),
    );
  }
}
