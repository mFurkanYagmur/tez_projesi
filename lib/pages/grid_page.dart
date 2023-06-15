import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mv_adayi_web_site/model/grid_data_model.dart';
import 'package:mv_adayi_web_site/widget/grid_page_item.dart';

import '../util/constants.dart';
import '../model/page_model.dart';
import '../widget/page_title.dart';

class GridPage extends StatelessWidget {
  const GridPage({super.key, required this.pageModel});

  final PageModel pageModel;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: kLigthGreyBGColor,
      padding: const EdgeInsets.symmetric(
        vertical: kVerticalPadding,
        horizontal: kHorizontalPadding,
      ),
      child: Column(
        children: [
          PageTitle(
            titleBack: pageModel.titleBack ?? '',
            titleFront: pageModel.titleFront ?? '',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: AlignedGridView.count(
              crossAxisCount: pageModel.column,
              // maxCrossAxisExtent: size.width/pageModel.column,
              shrinkWrap: true,
              itemCount: pageModel.data.length,
              mainAxisSpacing: kVerticalPadding,
              crossAxisSpacing: kHorizontalPadding,
              itemBuilder: (context, index) {
                return GridPageItem(dataModel: pageModel.data[index] as GridDataModel, index: index);
                // return _buildItem(icraat: icraatList[index], context: context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
