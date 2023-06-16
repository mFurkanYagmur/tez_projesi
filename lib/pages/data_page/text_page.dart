import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/model/data_model/text_data_model.dart';
import 'package:mv_adayi_web_site/widget/page_item/text_page_item.dart';

import '../../model/page_model.dart';
import '../../util/constants.dart';

class TextPage extends StatelessWidget {
  const TextPage({super.key, required this.pageModel});

  final PageModel pageModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLigthGreyBGColor,
      padding: const EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i=0; i<pageModel.data.length; i++)
                  Expanded(
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: TextPageItem(dataModel: pageModel.data[i] as TextDataModel, index: i,)),
                        if (i<(pageModel.data.length-1)) const SizedBox(width: kHorizontalPadding),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}