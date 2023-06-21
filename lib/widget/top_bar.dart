import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';
import 'package:mv_adayi_web_site/util/extensions.dart';
import 'package:mv_adayi_web_site/viewmodels/data_view_model.dart';
import 'package:mv_adayi_web_site/viewmodels/home_page_viewmodel.dart';
import 'package:mv_adayi_web_site/widget/logo.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/slider_content_model.dart';
import '../util/constants.dart';
import '../home_page.dart';
import '../util/util.dart';
import '../viewmodels/selected_page_viewmodel.dart';

class TopBar extends StatefulWidget {
  TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  bool hover = false;
  bool isScrolled = false;
  int selectedPage = 0;

  DataViewModel? dataViewModel;
  HomePageViewModel? homePageViewModel;
  SliderContentModel? sliderContentModel;

  @override
  void initState() {
    super.initState();
    HomePage.scrollController.addListener(() {
      double pixels = HomePage.scrollController.position.pixels;
      if (pixels > 20 && !isScrolled) {
        setState(() {
          isScrolled = true;
        });
      } else if (pixels <= 20 && isScrolled) {
        setState(() {
          isScrolled = false;
        });
      }
    });

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _loadSocialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<HomePageViewModel>();
    selectedPage = context.watch<SelectedPageViewModel>().selectedPage;
    dataViewModel ??= context.read<DataViewModel>();
    homePageViewModel ??= context.read<HomePageViewModel>();
    if (sliderContentModel == null) {
      return const SizedBox();
    }
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          hover = true;
        });
      },
      onExit: (event) {
        setState(() {
          hover = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: (hover || isScrolled) ? Colors.black : Colors.transparent,
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              onTap: () => _scrollToPage(0),
              child: const Logo(),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // MenuButton(title: 'Ana Sayfa', onPressed: () => _scrollToPage(0), isSelected: selectedPage <= 0),
                ..._getMenuList(),
                // MenuButton(title: 'Hakkımda', onPressed: () => _scrollToPage(0), isSelected: selectedPage <= 0),
                // MenuButton(title: '150 Günlük Plan', onPressed: () => _scrollToPage(1), isSelected: selectedPage == 1),
                // MenuButton(title: 'Seçim Vaatleri', onPressed: () => _scrollToPage(2), isSelected: selectedPage == 2),
                // MenuButton(title: 'Vizyon & Misyon', onPressed: () => _scrollToPage(3), isSelected: selectedPage == 3),
                // MenuButton(title: 'İletişim', onPressed: () => _scrollToPage(4), isSelected: selectedPage == 4),
                MenuButton(
                    title: 'Parti',
                    onPressed: () => _launchUrl(sliderContentModel!.partiUrl ?? 'https://www.ysk.gov.tr'),
                    isSelected: selectedPage == 5),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SocialBtn(
                    assetPath: 'twitter.svg',
                    onPressed: () => _launchUrl(sliderContentModel!.twitterUrl ?? 'https://www.twitter.com')),
                const SizedBox(
                  width: 8,
                ),
                SocialBtn(
                    assetPath: 'instagram.svg',
                    onPressed: () => _launchUrl(sliderContentModel!.instagramUrl ?? 'https://www.instagram.com')),
                const SizedBox(
                  width: 8,
                ),
                SocialBtn(
                    assetPath: 'facebook.svg',
                    onPressed: () => _launchUrl(sliderContentModel!.facebookUrl ?? 'https://www.facebook.com')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _scrollToPage(int page) {
    GlobalKey key = context.read<SelectedPageViewModel>().pageKeys[page];
    Scrollable.ensureVisible(key.currentContext!);
  }

  _launchUrl(String url) {
    launchUrl(Uri.parse(url));
  }

  _loadSocialData() async {
    try {
      Map<String, dynamic> data = await dataViewModel!.getData(collectionPath: 'homePage', documentName: 'sliderContent');
      setState(() {
        sliderContentModel = SliderContentModel.fromMap(data);
      });
    } catch (e) {
      debugPrint(e.toString());
      Util.showErrorMessage(context);
    }
  }

  List<Widget> _getMenuList() {
    List<PageModel> pages = homePageViewModel!.pages;
    if (pages.isEmpty) return [];
    List<Widget> list = [];
    List<int> indexList = [];
    for (int i = 0; i < pages.length; i++) {
      if (pages[i].menuTitle != null) {
        indexList.add(i);
      }
    }
    for (int i = 0; i < indexList.length; i++) {
      list.add(MenuButton(
          title: pages[indexList[i]].menuTitle!,
          onPressed: () => _scrollToPage(i),
          isSelected: selectedPage >= indexList[i] &&
              (indexList.length == (i + 1) || (indexList.length > (i + 1) && selectedPage < indexList[i + 1]))));
    }
    return list;
  }
}

class SocialBtn extends StatefulWidget {
  const SocialBtn({Key? key, required this.assetPath, required this.onPressed}) : super(key: key);

  final String assetPath;
  final Function() onPressed;

  @override
  State<SocialBtn> createState() => _SocialBtnState();
}

class _SocialBtnState extends State<SocialBtn> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: SvgPicture.asset(
        "assets/icons/social_icons/${widget.assetPath}",
        height: 36,
      ),
    );
  }
}

class MenuButton extends StatefulWidget {
  const MenuButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  final String title;
  final Function() onPressed;
  final bool isSelected;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      onHover: (value) {
        // if (value == hover) return;
        setState(() {
          hover = value;
        });
      },
      child: Text(
        widget.title.toUpperCaseLocalized(),
        style: TextStyle(
          color: hover || widget.isSelected ? kPrimaryColor : Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
