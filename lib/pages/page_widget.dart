import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';
import 'package:mv_adayi_web_site/pages/grid_page.dart';

import '../enum/page_type.dart';

class PageWidget extends StatelessWidget {
  const PageWidget({
    super.key,
    required this.pageModel,
  });

  final PageModel pageModel;

  @override
  Widget build(BuildContext context) {
    switch(pageModel.type) {
      case PageType.grid:
        return GridPage(pageModel: pageModel);
      case PageType.text:
      case PageType.album:
        return GridPage(pageModel: pageModel);
    }
  }
}
