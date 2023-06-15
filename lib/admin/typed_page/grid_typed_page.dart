import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/util/constants.dart';
import 'package:mv_adayi_web_site/viewmodels/page_add_viewmodel.dart';
import 'package:mv_adayi_web_site/widget/grid_page_item.dart';
import 'package:provider/provider.dart';

import '../../model/grid_data_model.dart';

class GridTypePage extends StatefulWidget {
  const GridTypePage({Key? key}) : super(key: key);

  @override
  State<GridTypePage> createState() => _GridTypePageState();
}

class _GridTypePageState extends State<GridTypePage> {
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
          children: context.select<PageAddViewModel, List>((value) => value.pageModel.data).map((e) {
            return Padding(
              key: UniqueKey(),
              padding: EdgeInsets.symmetric(vertical: 8),
              child: GridPageItem(
                key: UniqueKey(),
                dataModel: e,
                editMode: true,
                index: pageAddViewModel!.pageModel.data.indexOf(e),
                // onDataChanged: (dataModel) {
                //   //  deleted if dataModel is null
                //   if (dataModel == null) {
                //     setState(() {
                //     pageAddViewModel!.pageModel.data.removeAt(index);
                //   });
                //   } else {
                //     pageAddViewModel!.pageModel.data[index] = dataModel;
                //   }
                // },
              ),
            );
          }).toList(),
        ),
        TextButton.icon(
            onPressed: () {
              // setState(() {
              pageAddViewModel!.pageModel.data.add(GridDataModel());
              pageAddViewModel!.notifyChanges();
              // });
            },
            icon: const Icon(
              Icons.add,
              color: kPrimaryColor,
            ),
            label: const Text(
              'Öğe Ekle',
              style: TextStyle(color: kTextColor),
            ))
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
}
