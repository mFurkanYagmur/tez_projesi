import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mv_adayi_web_site/model/slider_content_model.dart';
import 'package:mv_adayi_web_site/util/constants.dart';
import 'package:mv_adayi_web_site/util/util.dart';
import 'package:mv_adayi_web_site/viewmodels/data_view_model.dart';
import 'package:mv_adayi_web_site/widget/loading_widget.dart';
import 'package:mv_adayi_web_site/widget/text_slider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
  late AnimationController _scrollAnimationControler;
  late Animation<double> _scrollAnimation;

  DataViewModel? dataViewModel;
  SliderContentModel? sliderContentModel;

  @override
  void initState() {
    super.initState();
    _initScrollAnimation();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _loadContentData();
    });
  }

  _initScrollAnimation() {
    _scrollAnimationControler = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat();
    _scrollAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _scrollAnimationControler, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    dataViewModel ??= context.read<DataViewModel>();
    final size = MediaQuery.of(context).size;

    return SizedBox.fromSize(
      size: size,
      child: sliderContentModel == null
          ? Container(color: Theme.of(context).scaffoldBackgroundColor, child: const LoadingWidget())
          : Stack(
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
                _buildAboutText(),
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

  Widget _buildAboutText() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            sliderContentModel?.beforeSliderText ?? '',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  // fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
          ),
          const SizedBox(height: 16),
          TextSlider(dataList: sliderContentModel?.sliderContent ?? []),
          const SizedBox(height: 16),
          Text(
            sliderContentModel?.afterSliderText ?? '',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 24,
                ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              launchUrl(Uri.parse(sliderContentModel?.partiUrl! ?? ''));
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

  _loadContentData() async {
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
}
