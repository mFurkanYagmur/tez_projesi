import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/model/data_model/data_model.dart';
import 'package:mv_adayi_web_site/viewmodels/page_add_viewmodel.dart';
import 'package:provider/provider.dart';

import '../enum/page_type.dart';
import '../util/constants.dart';

class ReorderableDataList extends StatefulWidget {
  const ReorderableDataList({super.key, required this.dataType});

  final DataType dataType;

  @override
  State<ReorderableDataList> createState() => _ReorderableDataListState();
}

class _ReorderableDataListState extends State<ReorderableDataList> {
  PageAddViewModel? pageAddViewModel;

  @override
  Widget build(BuildContext context) {
    pageAddViewModel ??= context.read<PageAddViewModel>();
    context.select<PageAddViewModel, dynamic>((value) => value.pageModel.data.length);
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Sayfa Öğeleri',
              style: Theme.of(context).textTheme.titleMedium,
            )),
        const SizedBox(height: 16),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onReorder: (oldIndex, newIndex) {
            _changeOrder(oldIndex: oldIndex, newIndex: newIndex);
            pageAddViewModel!.notifyChanges();
          },
          // buildDefaultDragHandles: false,
          children: pageAddViewModel!.pageModel.data.map((e) {
            return Padding(
              key: UniqueKey(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: widget.dataType.getInfo().pageItem(e, pageAddViewModel!.pageModel.data.indexOf(e), true),
            );
          }).toList(),
        ),
        TextButton.icon(
          onPressed: _addItem,
          icon: const Icon(
            Icons.add,
            color: kPrimaryColor,
          ),
          label: const Text(
            'Öğe Ekle',
            style: TextStyle(color: kTextColor),
          ),
        ),
      ],
    );
  }

  _changeOrder({required int oldIndex, required int newIndex}) {
    if (newIndex >= pageAddViewModel!.pageModel.data.length) newIndex = pageAddViewModel!.pageModel.data.length - 1;
    if (newIndex == oldIndex) return;
    setState(() {
      var item = pageAddViewModel!.pageModel.data.removeAt(oldIndex);
      pageAddViewModel!.pageModel.data.insert(newIndex, item);
    });
  }

  _addItem() {
    DataModel dataModel = widget.dataType.getInfo().createDataModel();
    pageAddViewModel!.pageModel.data.add(dataModel);
    pageAddViewModel!.notifyChanges();
  }
}
