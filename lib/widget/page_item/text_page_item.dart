import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/model/data_model/text_data_model.dart';
import 'package:mv_adayi_web_site/widget/page_item/page_item.dart';
import 'package:provider/provider.dart';

import '../../util/constants.dart';
import '../../util/validators.dart';
import '../../viewmodels/page_add_viewmodel.dart';
import '../text_field_counter.dart';

class TextPageItem extends StatefulWidget {
  const TextPageItem({
    super.key,
    required this.dataModel,
    this.editMode = false,
    required this.index,
  });

  final TextDataModel dataModel;
  final bool editMode;
  final int index;

  @override
  State<TextPageItem> createState() => _TextPageItemState();
}

class _TextPageItemState extends State<TextPageItem> {
  PageAddViewModel? pageAddViewModel;

  @override
  Widget build(BuildContext context) {
    if (widget.editMode) {
      pageAddViewModel ??= context.read<PageAddViewModel>();
    }
    return PageItem(
      index: widget.index,
      editMode: widget.editMode,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.editMode
            ? [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Başlık',
                  ),
                  initialValue: widget.dataModel.title ?? '',
                  maxLength: 40,
                  buildCounter: buildTextFieldCounter,
                  validator: Validators.requiredTextValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    widget.dataModel.title = value;
                    pageAddViewModel!.notifyChanges();
                    // _notifyChanges();
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'İçerik',
                  ),
                  initialValue: widget.dataModel.content ?? '',
                  maxLength: 3000,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  buildCounter: buildTextFieldCounter,
                  validator: (value) => Validators.requiredTextValidator(value, 50),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    widget.dataModel.content = value;
                    pageAddViewModel!.notifyChanges();
                    // _notifyChanges();
                  },
                ),
              ]
            : [
                Text(
                  widget.dataModel.title ?? '',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                ),
                const SizedBox(height: kVerticalPadding),
                Text(
                  widget.dataModel.content ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.justify,
                ),
              ],
      ),
    );
  }
}
