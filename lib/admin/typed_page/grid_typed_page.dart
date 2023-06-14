import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mv_adayi_web_site/constants.dart';
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
    context.watch<PageAddViewModel>();
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'Kolon Sayısı'),
          keyboardType: const TextInputType.numberWithOptions(),
          inputFormatters: [
            TextInputFormatter.withFunction((oldValue, newValue) {
              if ((int.tryParse(newValue.text) ?? -1) > 3) {
                return newValue.copyWith(text: '3', selection: const TextSelection.collapsed(offset: 1));
              }
              return newValue;
            }),
          ],
          initialValue: pageAddViewModel!.pageModel.column.toString(),
          maxLength: 1,
          buildCounter: (context, {int? currentLength, bool? isFocused, maxLength}) => null,
          onChanged: (value) => pageAddViewModel!.pageModel.column = int.tryParse(value) ?? 1,
        ),
        const SizedBox(height: 24),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onReorder: (oldIndex, newIndex) {
            _changeOrder(oldIndex: oldIndex, newIndex: newIndex);
          },
          // buildDefaultDragHandles: false,
          children: List.generate(pageAddViewModel!.pageModel.data.length, (index) {
            return Padding(
              key: UniqueKey(),
              padding: EdgeInsets.symmetric(vertical: 8),
              child: GridPageItem(
                key: UniqueKey(),
                dataModel: pageAddViewModel!.pageModel.data[index],
                editMode: true,
                index: index,
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
          }),
        ),
        TextButton.icon(
            onPressed: () {
              setState(() {
                pageAddViewModel!.pageModel.data.add(GridDataModel());
              });
            },
            icon: const Icon(
              Icons.add,
              color: kPrimaryColor,
            ),
            label: const Text('Ekle'))
      ],
    );
  }

  _changeOrder({required int oldIndex, required int newIndex}) {
    if (newIndex >= pageAddViewModel!.pageModel.data.length) newIndex = pageAddViewModel!.pageModel.data.length-1;
    if (newIndex == oldIndex) return;
    setState(() {
      var item = pageAddViewModel!.pageModel.data.removeAt(oldIndex);
      pageAddViewModel!.pageModel.data.insert(newIndex, item);
    });
  }
}
