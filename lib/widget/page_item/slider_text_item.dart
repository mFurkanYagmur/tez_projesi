import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/model/data_model/slider_data_model.dart';
import 'package:mv_adayi_web_site/util/validators.dart';
import 'package:mv_adayi_web_site/viewmodels/page_add_viewmodel.dart';
import 'package:mv_adayi_web_site/widget/page_item/page_item.dart';
import 'package:mv_adayi_web_site/widget/text_field_counter.dart';
import 'package:provider/provider.dart';

class SliderTextItem extends StatelessWidget {
  SliderTextItem({
    super.key,
    required this.dataModel,
    required this.editMode,
    required this.index,
  });

  final SliderDataModel dataModel;
  final bool editMode;
  final int index;

  PageAddViewModel? pageAddViewModel;

  @override
  Widget build(BuildContext context) {
    if (editMode) {
      pageAddViewModel ??= context.read<PageAddViewModel>();
    }
    return PageItem(
      editMode: editMode,
      index: index,
      child: editMode
          ? TextFormField(
              initialValue: dataModel.content ?? '',
              maxLength: 25,
              buildCounter: buildTextFieldCounter,
              validator: (value) => Validators.requiredTextValidator(value, 3),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                dataModel.content = value;
                pageAddViewModel!.notifyChanges();
              },
            )
          : Text(dataModel.content ?? ''),
    );
  }
}
