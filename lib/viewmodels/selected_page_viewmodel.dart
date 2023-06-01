import 'dart:math';

import 'package:flutter/material.dart';

class SelectedPageViewModel extends ChangeNotifier {
  List<bool> _pageVisibility = [];
  set pageVisibility(List<bool> list) => _pageVisibility = list;
  int get selectedPage => max(0,_pageVisibility.indexOf(true));

  void notifyPageChanged(int newPageIndex) {
    if (newPageIndex == selectedPage) return;
    _pageVisibility[selectedPage] = false;
    _pageVisibility[newPageIndex] = true;
    notifyListeners();
  }
}