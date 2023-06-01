import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mv_adayi_web_site/constants.dart';
import 'package:mv_adayi_web_site/extensions.dart';
import 'package:mv_adayi_web_site/pages/about_page.dart';
import 'package:mv_adayi_web_site/pages/icraat1_page.dart';
import 'package:mv_adayi_web_site/pages/secim_vaatleri_page.dart';
import 'package:mv_adayi_web_site/pages/vizyon_misyon_page.dart';
import 'package:mv_adayi_web_site/pages/welcome_page.dart';
import 'package:mv_adayi_web_site/viewmodels/selected_page_viewmodel.dart';
import 'package:mv_adayi_web_site/widget/footer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  static final ScrollController scrollController = ScrollController();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> pages = [
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WelcomePage(),
        AboutPage(),
      ],
    ),
    Icraat1Page(),
    const SecimVaatleriPage(),
    const VizyonMisyonPage(),
  ];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SelectedPageViewModel>().pageVisibility = List.generate(pages.length, (index) => false);
    });
    int pageLength = pages.length;
    for (int i = 0; i < pageLength; i++) {
      pages[i] = VisibilityDetector(
        key: UniqueKey(),
        onVisibilityChanged: (info) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            if (!info.visibleBounds.isEmpty){
              context.read<SelectedPageViewModel>().notifyPageChanged(i);
            }
          });
        },
        child: pages[i],
      );
    }
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: HomePage.scrollController,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...pages,
                  const Footer(),
                ],
              ),
            ),
          ),
          //  top bar
          TopBar(),
        ],
      ),
    );
  }
}

class TopBar extends StatefulWidget {
  TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  bool hover = false;
  bool isScrolled = false;
  int selectedPage = 0;

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
  }

  @override
  Widget build(BuildContext context) {
    selectedPage = context.watch<SelectedPageViewModel>().selectedPage;
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
            const Text(
              'MFY',
              style: TextStyle(
                fontFamily: 'BrunoAce',
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MenuButton(title: 'Hakkımda', onPressed: () {}, isSelected: selectedPage <= 0),
                MenuButton(title: '150 Günlük Plan', onPressed: () {}, isSelected: selectedPage == 1),
                MenuButton(title: 'Seçim Vaatleri', onPressed: () {}, isSelected: selectedPage == 2),
                MenuButton(title: 'Vizyon & Misyon', onPressed: () {}, isSelected: selectedPage == 3),
                MenuButton(title: 'Parti', onPressed: () {}, isSelected: selectedPage == 4),
                // MenuButton(title: 'İletişim', onPressed: () {}, isSelected: widget.pageIndex == 5),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SocialBtn(assetPath: 'twitter.svg', onPressed: () => _launchUrl('https://twitter.com/')),
                const SizedBox(
                  width: 8,
                ),
                SocialBtn(assetPath: 'instagram.svg', onPressed: () => _launchUrl('https://www.instagram.com/')),
                const SizedBox(
                  width: 8,
                ),
                SocialBtn(assetPath: 'facebook.svg', onPressed: () => _launchUrl('https://www.facebook.com/')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _launchUrl(String url) {
    launchUrl(Uri.parse(url));
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
  MenuButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  final String title;
  final Function() onPressed;
  bool isSelected;

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
