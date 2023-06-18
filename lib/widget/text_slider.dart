import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/model/data_model/slider_data_model.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';

class TextSlider extends StatefulWidget {
  const TextSlider({super.key, required this.pageModel});

  final PageModel pageModel;

  @override
  State<TextSlider> createState() => _TextSliderState();
}

class _TextSliderState extends State<TextSlider> with TickerProviderStateMixin {
  late final List<String> textList;

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
    textList = widget.pageModel.data.map((e) => (e as SliderDataModel).content ?? '').toList();
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _cursorAnimation,
          builder: (context, child) {
            return Text(
              _displayText,
              style: aboutTextStyle(context),
            );
          },
        ),
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
