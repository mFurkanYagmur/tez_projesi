import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';
import 'package:mv_adayi_web_site/services/firebase_client.dart';

class PageAddViewModel extends ChangeNotifier {
  PageModel pageModel = PageModel();

  notifyChanges() {
    notifyListeners();
  }

  Future save() async {
    return await FirebaseClient.instance.savePage(pageModel: pageModel);
  }
}
