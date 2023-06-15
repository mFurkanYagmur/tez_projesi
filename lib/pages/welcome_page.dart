import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/util/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
  late AnimationController _scrollAnimationControler;
  late Animation<double> _scrollAnimation;

  @override
  void initState() {
    super.initState();
    _initScrollAnimation();
  }

  _initScrollAnimation() {
    _scrollAnimationControler = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat();
    _scrollAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _scrollAnimationControler, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox.fromSize(
      size: size,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: size.height,
            foregroundDecoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/first_bg.jpg'), fit: BoxFit.cover),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildScrollAnimationWidget(),
          ),
          const AboutText(),
        ],
      ),
    );
  }

  Widget _buildScrollAnimationWidget() {
    return AnimatedBuilder(
      animation: _scrollAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _scrollAnimation.value,
          child: Padding(
            padding: EdgeInsets.only(bottom: 50.0 * (1 - _scrollAnimation.value)),
            child: const Icon(Icons.keyboard_arrow_down, size: 50, color: Colors.white),
          ),
        );
      },
    );
  }
}

class AboutText extends StatefulWidget {
  const AboutText({Key? key}) : super(key: key);

  @override
  State<AboutText> createState() => _AboutTextState();
}

class _AboutTextState extends State<AboutText> with TickerProviderStateMixin {
  final List<String> textList = [
    'Bilgisayar Mühendisiyim',
    'Adıyamanlıyım',
    '27. Dönem Milletvekiliyim',
    'Siyasetçiyim',
  ];

  TextStyle aboutTextStyle(BuildContext context) => Theme.of(context).textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 48,
      );

  late AnimationController _cursorAnimationController;
  late Animation<Color?> _cursorAnimation;
  late AnimationController _textAnimationController;
  late Animation<int> _textAnimation;

  int _textIndex = 0;
  String _displayText = '';

  @override
  void initState() {
    super.initState();
    _initCursorAnimation();
    _initTextAnimation();
  }

  _initCursorAnimation() {
    _cursorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _cursorAnimation = ColorTween(begin: Colors.white, end: Colors.white.withOpacity(0.0)).animate(_cursorAnimationController);
    _cursorAnimationController.repeat(reverse: true);
  }

  _initTextAnimation() {
    _textAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _textAnimation = IntTween(begin: 0, end: textList[_textIndex].length).animate(_textAnimationController)
      ..addListener(() {
        setState(() {
          _displayText = textList[_textIndex].substring(0, _textAnimation.value);
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            _textAnimationController.reverse();
          });
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            _textIndex = (_textIndex + 1) % textList.length;
            _textAnimation = IntTween(
              begin: 0,
              end: textList[_textIndex].length,
            ).animate(_textAnimationController);
          });
          _textAnimationController.forward();
        }
      });
    _textAnimationController.forward();
  }

  @override
  void dispose() {
    _cursorAnimationController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Merhaba! ',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                ),
                TextSpan(
                  text: 'Ben M. Furkan Yağmur,',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildAboutText(),
          const SizedBox(height: 16),
          Text(
            'A Partisi',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 24,
                ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              launchUrl(Uri.parse('https://www.ysk.gov.tr'));
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(side: BorderSide(color: kPrimaryColor, width: 1)),
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              'Parti Sayfası',
              style: TextStyle(color: kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildAboutText() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedBuilder(
            animation: _cursorAnimation,
            builder: (context, child) {
              return Text(
                _displayText, //'Ben M. Furkan Yağmur',
                //  Ben M. Furkan Yağmur || Ben Bilgisayar Mühendisiyim || Ben Siyasetçiyim || Ben 26. Dönem Milletvekiliyim
                style: aboutTextStyle(context),
              );
            }),
        AnimatedBuilder(
          animation: _cursorAnimation,
          builder: (context, child) {
            return Text(
              '|',
              style: aboutTextStyle(context).copyWith(color: _cursorAnimation.value),
            );
          },
        ),
      ],
    );
  }
}
