import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_adayi_web_site/constants.dart';
import 'package:mv_adayi_web_site/extensions.dart';
import 'package:mv_adayi_web_site/pages/page1.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.fromSize(
        size: size,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Page1(),
                  Container(
                    height: size.height,
                    width: double.infinity,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            //  top bar
            TopBar(),
          ],
        ),
      ),
    );
  }
}

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  bool hover = false;
  bool isScrolled = false;

  @override
  void initState() {
    super.initState();
    HomePage.scrollController.addListener(() {
      double pixels = HomePage.scrollController.position.pixels;
      if (pixels > 20 && !isScrolled) {
        setState((){
          isScrolled = true;
        });
      } else if (pixels <= 20 && isScrolled) {
        setState((){
          isScrolled = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
          color: kTextColor.withOpacity((hover || isScrolled) ? 1.0 : 0.0),
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
                MenuButton(title: 'Seçim Vaatleri', onPressed: () {}, isSelected: true),
                MenuButton(title: 'Parti', onPressed: () {}),
                MenuButton(title: 'Hakkımda', onPressed: () {}),
                MenuButton(title: 'Vizyon & Misyon', onPressed: () {}),
                MenuButton(title: 'İletişim', onPressed: () {}),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SocialBtn(assetPath: 'twitter.svg', onPressed: () {}),
                SizedBox(width: 8,),
                SocialBtn(assetPath: 'instagram.svg', onPressed: () {}),
                SizedBox(width: 8,),
                SocialBtn(assetPath: 'facebook.svg', onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
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
          color: hover ? kPrimaryColor : Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
