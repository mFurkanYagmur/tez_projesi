import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:mv_adayi_web_site/model/data_model/grid_data_model.dart';
import 'package:mv_adayi_web_site/util/validators.dart';
import 'package:provider/provider.dart';

import '../../util/constants.dart';
import '../../viewmodels/page_add_viewmodel.dart';
import '../text_field_counter.dart';

class GridPageItem extends StatefulWidget {
  const GridPageItem({
    super.key,
    required this.dataModel,
    this.editMode = false,
    required this.index,
  });

  final GridDataModel dataModel;
  final bool editMode;
  final int index;

  /// Deleted if dataModel is null
  // final Function(GridDataModel? gridDataModel)? onDataChanged;

  @override
  State<GridPageItem> createState() => _GridPageItemState();
}

class _GridPageItemState extends State<GridPageItem> {
  PageAddViewModel? pageAddViewModel;

  @override
  Widget build(BuildContext context) {
    if (widget.editMode) {
      pageAddViewModel ??= context.read<PageAddViewModel>();
    }
    var iconBorderRadius = BorderRadius.circular(16);
    return Row(
      key: widget.key,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (widget.editMode) const Center(child: Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: Icon(Icons.drag_handle,),
        // ),),
        if (widget.editMode && context.select<PageAddViewModel?, bool>((value) => (value?.pageModel.data.length ?? -1) > 1))
          IconButton(
            onPressed: () {
              pageAddViewModel!.pageModel.removeDataFromList(widget.index);
              pageAddViewModel!.notifyChanges();

              // if (widget.onDataChanged != null) widget.onDataChanged!(null);
            },
            icon: const Icon(Icons.delete, color: Colors.redAccent),
          ),
        FormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (widget.dataModel.iconCodePoint == null) return 'Lütfen bir ikon seçiniz.';
            return null;
          },
          builder: (field) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: iconBorderRadius, side: !field.hasError ? BorderSide.none : BorderSide(
                        color: Colors.red,
                        width: 1,
                      )),
                      child: InkWell(
                        onTap: !widget.editMode
                            ? null
                            : () {
                          _pickIcon();
                        },
                        borderRadius: iconBorderRadius,
                        child: Padding(
                          padding: const EdgeInsets.all(kVerticalPadding / 3),
                          child: Icon(
                            IconData(widget.dataModel.iconCodePoint ?? (widget.editMode ? Icons.edit.codePoint : Icons.warning_amber_rounded.codePoint), fontFamily: 'MaterialIcons'),
                            color: (widget.editMode && widget.dataModel.iconCodePoint == null) ||
                                (!widget.editMode && widget.dataModel.iconCodePoint != null)
                                ? kPrimaryColor
                                : kTextLightColor,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    if (widget.editMode)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Icon(
                          widget.dataModel.iconCodePoint == null ? null : Icons.edit,
                          color: kPrimaryColor,
                          // size: 16,
                        ),
                      ),
                  ],
                ),
                if (field.hasError) Text(field.errorText ?? '', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.red),)
              ],
            );
          },
        ),
        const SizedBox(width: kHorizontalPadding / 3),
        Expanded(
          child: (widget.editMode)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'İçerik',
                      ),
                      initialValue: widget.dataModel.content ?? '',
                      maxLength: 200,
                      buildCounter: buildTextFieldCounter,
                      validator: Validators.requiredTextValidator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        widget.dataModel.content = value;
                        pageAddViewModel!.notifyChanges();
                        // _notifyChanges();
                      },
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.dataModel.title ?? '',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.dataModel.content ?? '',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextLightColor),
                    ),
                  ],
                ),
        ),
        if (widget.editMode) const SizedBox(width: 48),
      ],
    );
  }

  _pickIcon() async {
    IconData? iconData = await FlutterIconPicker.showIconPicker(context, title: const Text('Bir ikon seçin'));
    if (iconData == null) return;
    setState(() {
      widget.dataModel.iconCodePoint = iconData.codePoint;
      pageAddViewModel!.notifyChanges();
      // pageAddViewModel!.pageModel.data[]
    });
    // _notifyChanges();
  }

// _notifyChanges() {
//   if (widget.onDataChanged != null) widget.onDataChanged!(widget.dataModel);
// }
}
