import 'package:flutter/material.dart';

import '../constants.dart';
import '../routes.dart';
import '../widget/logo.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key, required this.width}) : super(key: key);

  final double width;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int selectedMenu = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
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
          buildSideMenuItem(title: 'Ana Sayfa', selectedIcon: Icons.home, unselectedIcon: Icons.home_outlined, isSelected: true, index: 0),
          buildSideMenuItem(title: 'Özgeçmiş', selectedIcon: Icons.manage_accounts, unselectedIcon: Icons.manage_accounts_outlined, isSelected: false, index: 1),
          buildSideMenuItem(title: 'İcraatlar', selectedIcon: Icons.work, unselectedIcon: Icons.work_outline, isSelected: false, index: 2),
          buildSideMenuItem(title: 'Sayfa Yönetimi', selectedIcon: Icons.file_copy, unselectedIcon: Icons.file_copy_outlined, isSelected: false, index: 3),
          buildSideMenuItem(title: 'Mesajlar', selectedIcon: Icons.message, unselectedIcon: Icons.message_outlined, isSelected: false, index: 4),

        ],
      ),
    );
  }

  Widget buildSideMenuItem({required String title, required IconData selectedIcon, required IconData unselectedIcon, required bool isSelected, required int index}) {
    isSelected = selectedMenu == index;
    return InkWell(
      onTap: () {
        if (isSelected) return;
        setState(() {
          selectedMenu = index;
        });
      },
      child: ListTile(
        leading: Icon(isSelected ? selectedIcon : unselectedIcon, color: isSelected ? kPrimaryColor : kTextLightColor),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: isSelected ? kTextColor : kTextLightColor),),
      ),
    );
  }
}
