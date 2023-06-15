import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/util/constants.dart';
import 'package:mv_adayi_web_site/util/extensions.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({Key? key, required this.titleBack, required this.titleFront}) : super(key: key);

  final String titleBack;
  final String titleFront;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              titleBack.toUpperCaseLocalized(),
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: kTextColor.withOpacity(0.07),
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titleFront,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                ),
                //  Divider
                Container(
                  width: 100,
                  height: 3,
                  color: kPrimaryColor,
                  margin: EdgeInsets.only(top: 4),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
