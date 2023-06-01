import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mv_adayi_web_site/constants.dart';

import '../widget/page_title.dart';

class SecimVaatleriPage extends StatefulWidget {
  const SecimVaatleriPage({Key? key}) : super(key: key);

  @override
  State<SecimVaatleriPage> createState() => _SecimVaatleriPageState();
}

class _SecimVaatleriPageState extends State<SecimVaatleriPage> {
  late List<String> imageUrls;

  @override
  void initState() {
    super.initState();
    double width = 900, height = 600;
    imageUrls = [
      'https://picsum.photos/$height/$width',
      'https://picsum.photos/$width/$height',
      'https://picsum.photos/$width/$height',
      'https://picsum.photos/$width/$height',
      'https://picsum.photos/$height/$width',
      'https://picsum.photos/$width/$height',
      'https://picsum.photos/$width/$height',
    ];
  }

  // String _getUrl(){
  //   bool vertical = Random().nextBool();
  //   double size = Random(450).nextInt(600).toDouble();
  //
  //   return 'https://picsum.photos/${vertical ?  : size}/$height';
  // }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const PageTitle(
            titleBack: 'Seçim Vaatleri',
            titleFront: 'Ne Yapacağız?',
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding * 3)
                .copyWith(top: kVerticalPadding, bottom: kVerticalPadding * 2),
            child: MasonryGridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              mainAxisSpacing: kVerticalPadding,
              crossAxisSpacing: kHorizontalPadding,
              itemCount: imageUrls.length,
              crossAxisCount: 3,
              itemBuilder: (context, index) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imageUrls[index],
                      fit: BoxFit.cover,
                    ));
              },
            ), /*GridView.custom(
              gridDelegate: SliverWovenGridDelegate.count(
                crossAxisCount: 2,
                pattern: [
                  WovenGridTile(4/1),
                ],
                mainAxisSpacing: kVerticalPadding,
                crossAxisSpacing: kHorizontalPadding,
              ),
              semanticChildCount: imageUrls.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              childrenDelegate: SliverChildBuilderDelegate((context, index) {
                return Image.network(imageUrls[index]);
              }),
            ),*/
          ),
        ],
      ),
    );
  }
}
