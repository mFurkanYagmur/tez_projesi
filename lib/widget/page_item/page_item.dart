import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/page_add_viewmodel.dart';

class PageItem extends StatefulWidget {
  const PageItem({
    super.key,
    required this.editMode,
    required this.index,
    required this.child,
  });

  final bool editMode;
  final int index;
  final Widget child;

  @override
  State<PageItem> createState() => _PageItemState();
}

class _PageItemState extends State<PageItem> {
  PageAddViewModel? pageAddViewModel;

  @override
  Widget build(BuildContext context) {
    if (widget.editMode) {
      pageAddViewModel ??= context.read<PageAddViewModel>();
    }
    return Row(
      key: widget.key,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.editMode && context.select<PageAddViewModel?, bool>((value) => (value?.pageModel.data.length ?? -1) > 1))
          IconButton(
            onPressed: () {
              pageAddViewModel!.pageModel.removeDataFromList(widget.index);
              pageAddViewModel!.notifyChanges();

              // if (widget.onDataChanged != null) widget.onDataChanged!(null);
            },
            icon: const Icon(Icons.delete, color: Colors.redAccent),
          ),
        Expanded(
          child: widget.child,
        ),
        if (widget.editMode) const SizedBox(width: 48),
      ],
    );
  }
}
