import 'dart:math';

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
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
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
              itemCount: widget.pageModel.data.length + _getResizedColumnCount(),
              crossAxisCount: widget.pageModel.column,
              itemBuilder: (context, index) {
                if (index < widget.pageModel.column && index % 2 == 1) {
                  return SizedBox(height: max(0, 100.0 - (15*widget.pageModel.column)),/*50 + (Random().nextDouble()*50),*/);
                }
                return AlbumPageItem(
                  dataModel: widget.pageModel.data[_getDataIndex(index)] as AlbumDataModel,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // int _getItemCount() => widget.pageModel.data.length + (widget.pageModel.column.toDouble() / 2.0).floor();

  int _getResizedColumnCount() => (widget.pageModel.column.toDouble() / 2.0).floor();

  int _getDataIndex(int index) {
    int dataIndex;
    int column = widget.pageModel.column;
    if (index < column) {
      dataIndex = index - (index.toDouble()/2.0).floor();
    } else {
      dataIndex = index - _getResizedColumnCount();
    }
    return dataIndex;
  }
}
