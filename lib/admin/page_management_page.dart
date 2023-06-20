import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/admin/page_add_page.dart';

enum ManagementPage {
  add,
  pageManager,
}

class PageManagementPage extends StatelessWidget {
  const PageManagementPage({Key? key, required this.page}) : super(key: key);

  final ManagementPage? page;

  @override
  Widget build(BuildContext context) {
    switch (page) {
      case null:
      case ManagementPage.add:
        return PageAddPage();
      case ManagementPage.pageManager:
        return SizedBox();
    }
  }
}
