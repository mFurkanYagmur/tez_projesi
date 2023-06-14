import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mv_adayi_web_site/constants.dart';
import 'package:mv_adayi_web_site/widget/grid_page_item.dart';

import '../../model/grid_data_model.dart';

class GridTypePage extends StatefulWidget {
  const GridTypePage({Key? key}) : super(key: key);

  @override
  State<GridTypePage> createState() => _GridTypePageState();
}

class _GridTypePageState extends State<GridTypePage> {
  Map<String, dynamic> data = {};

  List<GridDataModel> gridDataList = [
    GridDataModel(),
  ];

  @override
  Widget build(BuildContext context) {
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
          initialValue: data['column']?.toString(),
          maxLength: 1,
          onChanged: (value) => data['column'] = int.tryParse(value),
        ),
        ListView.separated(
          itemCount: gridDataList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GridPageItem(
              dataModel: gridDataList[index],
              editMode: true,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: kVerticalPadding / 3,
            );
          },
        ),
        TextButton.icon(
            onPressed: () {
              setState(() {
                gridDataList.add(GridDataModel());
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
}
