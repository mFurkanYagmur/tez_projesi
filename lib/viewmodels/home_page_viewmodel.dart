import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';
import 'package:mv_adayi_web_site/services/firebase_client.dart';

class HomePageViewModel extends ChangeNotifier{
  List<PageModel>? _pages;

  Future loadPages() async {
    _pages = await FirebaseClient.instance.getPages();
    notifyListeners();
  }

  Future<List<PageModel>> getPages() async {
    _pages ??= await FirebaseClient.instance.getPages();
    return _pages!;
  }
}