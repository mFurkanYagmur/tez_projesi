import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/model/data_model/grid_data_model.dart';
import 'package:mv_adayi_web_site/model/data_model/text_data_model.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';
import 'package:mv_adayi_web_site/pages/data_page/grid_page.dart';
import 'package:mv_adayi_web_site/pages/data_page/text_page.dart';
import 'package:mv_adayi_web_site/widget/page_item/grid_page_item.dart';
import 'package:mv_adayi_web_site/widget/page_item/text_page_item.dart';

import '../model/data_model/data_model.dart';

enum PageType {
  grid,
  album,
  text,
}

class PageTypeClass {
  String title;
  Widget Function(DataModel dataModel, int index, [bool? editMode]) pageItem;
  Widget Function(PageModel pageModel) page;
  DataModel Function() createDataModel;

  PageTypeClass({required this.title, required this.pageItem, required this.page, required this.createDataModel,});
}

extension PageTypeExtension on PageType {
  PageTypeClass getInfo() {
    switch (this) {
      case PageType.grid:
        return PageTypeClass(
          title: 'Grid',
          pageItem: (dataModel, index, [editMode]) {
            return GridPageItem(dataModel: dataModel as GridDataModel, editMode: editMode ?? false, index: index);
          },
          page: (pageModel) {
            return GridPage(pageModel: pageModel);
          },
          createDataModel: () => GridDataModel(),
        );
      case PageType.album:
        return PageTypeClass(
          title: 'Albüm',
          pageItem: (dataModel, index, [editMode]) {
            return GridPageItem(dataModel: dataModel as GridDataModel, editMode: editMode ?? false, index: index);
          },
          page: (pageModel) {
            return GridPage(pageModel: pageModel);
          },
          createDataModel: () => GridDataModel(),
        );
      case PageType.text:
        return PageTypeClass(
          title: 'Yazı',
          pageItem: (dataModel, index, [editMode]) {
            return TextPageItem(dataModel: dataModel as TextDataModel, editMode: editMode ?? false, index: index);
          },
          page: (pageModel) {
            return TextPage(pageModel: pageModel);
          },
          createDataModel: () => TextDataModel(),
        );
    }
  }
}
