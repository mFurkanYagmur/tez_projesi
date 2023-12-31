import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/admin/admin_page.dart';
import 'package:mv_adayi_web_site/home_page.dart';
import 'package:mv_adayi_web_site/viewmodels/data_view_model.dart';
import 'package:mv_adayi_web_site/viewmodels/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

import '../viewmodels/selected_page_viewmodel.dart';

class Routes {
  static const String homePage = '/home';
  static const String adminPage = '/admin';

  static Route onGenerateRoutes(RouteSettings? settings) {
    Widget page;
    switch (settings?.name) {
      case '/':
      case adminPage:
        page = const AdminPage();
        break;
      case homePage:
      default:
        page = MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => SelectedPageViewModel()),
            ChangeNotifierProvider(create: (context) => HomePageViewModel()),
            ChangeNotifierProvider(create: (context) => DataViewModel()),
          ],
          child: HomePage(),
        );
        break;
    }

    return MaterialPageRoute(
      builder: (context) => page,
    );
  }
}
