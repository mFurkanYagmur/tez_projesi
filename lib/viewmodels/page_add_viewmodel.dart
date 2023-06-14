import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';

class PageAddViewModel extends ChangeNotifier {
  PageModel pageModel = PageModel();

  notifyChanges() {
    notifyListeners();
  }
}
