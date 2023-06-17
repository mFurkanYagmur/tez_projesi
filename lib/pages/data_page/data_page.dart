import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/enum/page_type.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';

import '../../util/constants.dart';

class DataPage extends StatelessWidget {
  const DataPage({
    super.key,
    required this.pageModel,
    required this.sameAsFooter,
  });

  final PageModel pageModel;
  final bool sameAsFooter;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: sameAsFooter ? kLigthGreyBGColor : Theme.of(context).scaffoldBackgroundColor,
        child: pageModel.type.getInfo().page(pageModel));
  }
}
