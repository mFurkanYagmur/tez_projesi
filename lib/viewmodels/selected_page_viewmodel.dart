import 'dart:math';

import 'package:flutter/material.dart';

class SelectedPageViewModel extends ChangeNotifier {
  List<bool> _pageVisibility = [];
  List<GlobalKey> pageKeys = [];
  set pageVisibility(List<bool> list) => _pageVisibility = list;
  int get selectedPage => max(0,_pageVisibility.indexOf(true));

  int lastSelectedPage = 0;

  void notifyPageChanged({required int newPageIndex, required bool pageVisible}) {
    _pageVisibility[newPageIndex] = pageVisible;
    if (lastSelectedPage != selectedPage) {
      lastSelectedPage = selectedPage;
      notifyListeners();
    }
  }
}