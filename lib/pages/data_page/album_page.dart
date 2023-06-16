import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mv_adayi_web_site/model/data_model/album_data_model.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';
import 'package:mv_adayi_web_site/util/constants.dart';
import 'package:mv_adayi_web_site/widget/page_item/album_page_item.dart';

import '../../widget/page_title.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key, required this.pageModel}) : super(key: key);

  final PageModel pageModel;

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PageTitle(
            titleBack: widget.pageModel.titleBack ?? '',
            titleFront: widget.pageModel.titleFront ?? '',
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
              itemCount: widget.pageModel.data.length,
              crossAxisCount: widget.pageModel.column,
              itemBuilder: (context, index) {
                return AlbumPageItem(
                  dataModel: widget.pageModel.data[index] as AlbumDataModel,
                  index: index,
                );
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
