import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/model/grid_data_model.dart';

import '../constants.dart';

class GridPageItem extends StatelessWidget {
  const GridPageItem({
    Key? key,
    required this.dataModel,
    this.editMode = false,
  }) : super(key: key);

  final GridDataModel dataModel;
  final bool editMode;

  @override
  Widget build(BuildContext context) {
    var iconBorderRadius = BorderRadius.circular(16);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: iconBorderRadius),
              child: InkWell(
                onTap: !editMode ? null : () {
                  _pickIcon();
                },
                borderRadius: iconBorderRadius,
                child: Padding(
                  padding: const EdgeInsets.all(kVerticalPadding / 3),
                  child: Icon(
                    dataModel.iconCodePoint != null ? IconData(dataModel.iconCodePoint!) : Icons.error_outline,
                    color: dataModel.iconCodePoint != null ? kPrimaryColor : kTextLightColor,
                    size: 30,
                  ),
                ),
              ),
            ),
            if (editMode)
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.edit,
                  color: kPrimaryColor,
                  // size: 16,
                ),
              ),
          ],
        ),
        const SizedBox(width: kHorizontalPadding / 3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dataModel.title ?? '',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                dataModel.content ?? '',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextLightColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _pickIcon() async {
    // FlutterIconPicker()
  }
}
