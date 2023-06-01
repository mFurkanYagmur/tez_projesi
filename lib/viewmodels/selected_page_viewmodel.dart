import 'dart:math';

import 'package:flutter/material.dart';

class SelectedPageViewModel extends ChangeNotifier {
  List<bool> _pageVisibility = [];
  List<GlobalKey> pageKeys = [];
  set pageVisibility(List<bool> list) => _pageVisibility = list;
  int get selectedPage => max(0,_pageVisibility.indexOf(true));

  // int? lastForceChanged;

  void notifyPageChanged(int newPageIndex) {
    if (newPageIndex == selectedPage) return;
    _pageVisibility[selectedPage] = false;
    _pageVisibility[newPageIndex] = true;
    notifyListeners();
  }

  // void pageChange(int newPageIndex) {
  //   if (newPageIndex == selectedPage) return;
  //   lastForceChanged = newPageIndex;
  //   notifyListeners();
  // }
}