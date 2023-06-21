import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/admin/page_add_page.dart';
import 'package:mv_adayi_web_site/admin/page_manager.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';

enum ManagementPage {
  add,
  pageManager,
}

class PageManagementPage extends StatefulWidget {
  PageManagementPage({Key? key, required this.page, this.pageModel}) : super(key: key);

  ManagementPage? page;
  PageModel? pageModel;

  @override
  State<PageManagementPage> createState() => _PageManagementPageState();
}

class _PageManagementPageState extends State<PageManagementPage> {
  @override
  Widget build(BuildContext context) {
    switch (widget.page) {
      case ManagementPage.add:
        return PageAddPage(pageModel: widget.pageModel,);
      case null:
      case ManagementPage.pageManager:
        return PageManager(navigateAddPage: (pageModel) {
          setState(() {
            widget.pageModel = pageModel;
            widget.page = ManagementPage.add;
          });
        },);
    }
  }
}
