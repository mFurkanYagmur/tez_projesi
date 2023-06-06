import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/admin/edit_home_page.dart';
import 'package:mv_adayi_web_site/constants.dart';
import 'package:mv_adayi_web_site/pages/secim_vaatleri_page.dart';
import 'package:mv_adayi_web_site/routes.dart';

import '../widget/logo.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late Size size;
  int selectedPage = 0;
  PageController pageController = PageController();

  List<MenuModel> menuList = [
    MenuModel(
        title: 'Ana Sayfa',
        description: 'Ana sayfayı düzenleyin.',
        selectedIcon: Icons.home,
        unselectedIcon: Icons.home_outlined,
        page: const EditHomePage()),
    MenuModel(
        title: 'Özgeçmiş',
        description: 'Özgeçmiş bilgilerinizi ve CV\'nizi güncelleyin.',
        selectedIcon: Icons.manage_accounts,
        unselectedIcon: Icons.manage_accounts_outlined,
        page: const SecimVaatleriPage()),
    MenuModel(
        title: 'İcraatlar',
        description: 'Sayfalarda kullanılmak üzere icraat ekleyin veya var olan icraati silin.',
        selectedIcon: Icons.work,
        unselectedIcon: Icons.work_outline,
        page: const SecimVaatleriPage()),
    MenuModel(
        title: 'Sayfa Yönetimi',
        description: 'Mevcut sayfalarınızı düzenleyin veya sayfa ekleyin/çıkartın.',
        selectedIcon: Icons.file_copy,
        unselectedIcon: Icons.file_copy_outlined,
        page: const SecimVaatleriPage()),
    MenuModel(
        title: 'Mesajlar',
        description: 'Site içeririinden size gönderilen mesajları buradan görüntüleyebilirsiniz.',
        selectedIcon: Icons.message,
        unselectedIcon: Icons.message_outlined,
        page: const SecimVaatleriPage()),
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor.withOpacity(0.05),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SideMenu(
          //   width: size.width * 0.2,
          // ),
          buildSideMenu(),
          const SizedBox(
            width: kHorizontalPadding / 3,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const SizedBox(height: kVerticalPadding/3,),
                  buildTopBar(),
                  const SizedBox(
                    height: kVerticalPadding / 3,
                  ),
                  Container(
                    color: Colors.white,
                    child: menuList[selectedPage].page,

                    /*Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          margin: const EdgeInsets.all(8),
                          child: const Placeholder(),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200,
                          margin: const EdgeInsets.all(8),
                          child: const Placeholder(),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200,
                          margin: const EdgeInsets.all(8),
                          child: const Placeholder(),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200,
                          margin: const EdgeInsets.all(8),
                          child: const Placeholder(),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200,
                          margin: const EdgeInsets.all(8),
                          child: const Placeholder(),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200,
                          margin: const EdgeInsets.all(8),
                          child: const Placeholder(),
                        ),
                      ],
                    ),*/
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: kHorizontalPadding / 3,
          ),
        ],
      ),
    );
  }

  Widget buildSideMenu() {
    return Container(
      color: Colors.white,
      width: size.width * 0.2,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.homePage),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
              child: const Logo(color: Colors.black),
            ),
          ),
          const Divider(),
          for (int i = 0; i < menuList.length; i++) buildSideMenuItem(index: i),

          // buildSideMenuItem(title: 'Ana Sayfa', selectedIcon: Icons.home, unselectedIcon: Icons.home_outlined, index: 0),
          // buildSideMenuItem(title: 'Özgeçmiş', selectedIcon: Icons.manage_accounts, unselectedIcon: Icons.manage_accounts_outlined, index: 1),
          // buildSideMenuItem(title: 'İcraatlar', selectedIcon: Icons.work, unselectedIcon: Icons.work_outline, index: 2),
          // buildSideMenuItem(title: 'Sayfa Yönetimi', selectedIcon: Icons.file_copy, unselectedIcon: Icons.file_copy_outlined, index: 3),
          // buildSideMenuItem(title: 'Mesajlar', selectedIcon: Icons.message, unselectedIcon: Icons.message_outlined, index: 4),
        ],
      ),
    );
  }

  Widget buildSideMenuItem({required int index}) {
    bool isSelected = selectedPage == index;
    var page = menuList[index];
    return InkWell(
      onTap: () {
        if (isSelected) return;
        setState(() {
          selectedPage = index;
        });
      },
      child: ListTile(
        leading: Icon(isSelected ? page.selectedIcon : page.unselectedIcon, color: isSelected ? kPrimaryColor : kTextLightColor),
        title: Text(
          page.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: isSelected ? kTextColor : kTextLightColor),
        ),
        contentPadding: EdgeInsets.only(left: 16),
        trailing: !isSelected
            ? null
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: 5,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildTopBar() {
    var page = menuList[selectedPage];
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(kHorizontalPadding),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                page.title,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kTextColor,
                    ),
              ),
              Text(
                page.description,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: kTextLightColor,
                    ),
              ),
            ],
          ),
          const Spacer(),
          Icon(
            page.selectedIcon,
            color: kPrimaryColor,
            size: 48,
          ),
        ],
      ),
    );
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      children: [],
    );
  }
}

class MenuModel {
  String title;
  String description;
  IconData selectedIcon;
  IconData unselectedIcon;
  Widget page;

  MenuModel({
    required this.title,
    required this.description,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.page,
  });
}
