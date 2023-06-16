import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mv_adayi_web_site/enum/page_type.dart';
import 'package:mv_adayi_web_site/helper/ui_helper.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';
import 'package:mv_adayi_web_site/pages/about_page.dart';
import 'package:mv_adayi_web_site/pages/contact_page.dart';
import 'package:mv_adayi_web_site/pages/icraat_page.dart';
import 'package:mv_adayi_web_site/pages/secim_vaatleri_page.dart';
import 'package:mv_adayi_web_site/pages/vizyon_misyon_page.dart';
import 'package:mv_adayi_web_site/pages/welcome_page.dart';
import 'package:mv_adayi_web_site/viewmodels/selected_page_viewmodel.dart';
import 'package:mv_adayi_web_site/widget/footer.dart';
import 'package:mv_adayi_web_site/widget/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'viewmodels/home_page_viewmodel.dart';
import 'widget/top_bar.dart';

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
    IcraatPage(),
    const SecimVaatleriPage(),
    const VizyonMisyonPage(),
    const ContactPage(),
  ];

  HomePageViewModel? homePageViewModel;

  @override
  void initState() {
    super.initState();
    int pageLength = pages.length;
    List<GlobalKey> pageKeys = List.generate(pageLength, (index) => GlobalKey());
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<SelectedPageViewModel>().pageVisibility = List.generate(pages.length, (index) => false);
      context.read<SelectedPageViewModel>().pageKeys = pageKeys;

      try {
        await homePageViewModel!.loadPages();
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    for (int i = 0; i < pageLength; i++) {
      pages[i] = VisibilityDetector(
        key: pageKeys[i],
        onVisibilityChanged: (info) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            context.read<SelectedPageViewModel>().notifyPageChanged(newPageIndex: i, pageVisible: info.visibleFraction > 0);
          });
        },
        child: pages[i],
      );
    }
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  }

  @override
  Widget build(BuildContext context) {
    homePageViewModel ??= context.read<HomePageViewModel>();
    context.watch<HomePageViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: homePageViewModel!.listenPages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildPages();
            } else if (snapshot.hasError) {
              UIHelper.showSnackBar(
                  context: context, text: 'Sayfa verileri alınırken bir hata meydana geldi!', type: UIType.danger);
            }
            return const LoadingWidget();
          }),
    );
  }

  Widget _buildPages() {
    List<PageModel> pages = homePageViewModel!.pages;
    return Stack(
      children: [
        SingleChildScrollView(
          controller: HomePage.scrollController,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WelcomePage(),
                ...pages.map((e) => e.type.getInfo().page(e)).toList(),
                const Footer(),
              ],
            ),
          ),
        ),
        TopBar(),
      ],
    );
  }
}
