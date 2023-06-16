import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/model/data_model/album_data_model.dart';
import 'package:mv_adayi_web_site/widget/page_item/page_item.dart';
import 'package:provider/provider.dart';

import '../../util/validators.dart';
import '../../viewmodels/page_add_viewmodel.dart';
import '../text_field_counter.dart';

class AlbumPageItem extends StatefulWidget {
  const AlbumPageItem({
    super.key,
    required this.dataModel,
    this.editMode = false,
    required this.index,
  });

  final AlbumDataModel dataModel;
  final bool editMode;
  final int index;

  @override
  State<AlbumPageItem> createState() => _AlbumPageItemState();
}

class _AlbumPageItemState extends State<AlbumPageItem> {
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
                    labelText: 'Görsel URL Adresi',
                  ),
                  initialValue: widget.dataModel.imageUrl ?? '',
                  validator: Validators.requiredTextValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    widget.dataModel.imageUrl = value;
                    pageAddViewModel!.notifyChanges();
                    // _notifyChanges();
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Açıklama',
                  ),
                  initialValue: widget.dataModel.description ?? '',
                  maxLength: 40,
                  buildCounter: buildTextFieldCounter,
                  onChanged: (value) {
                    widget.dataModel.description = value;
                    pageAddViewModel!.notifyChanges();
                    // _notifyChanges();
                  },
                ),
              ]
            : [
                if (widget.dataModel.imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.dataModel.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                if (widget.dataModel.imageUrl == null) const Placeholder(),
              ],
      ),
    );
  }
}
