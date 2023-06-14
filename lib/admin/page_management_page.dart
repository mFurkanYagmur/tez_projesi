import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/admin/typed_page/grid_typed_page.dart';
import 'package:mv_adayi_web_site/constants.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';

import '../enum/page_type.dart';

class PageManagementPage extends StatefulWidget {
  const PageManagementPage({Key? key}) : super(key: key);

  @override
  State<PageManagementPage> createState() => _PageManagementPageState();
}

class _PageManagementPageState extends State<PageManagementPage> {
  PageModel pageData = PageModel.fillData(
    type: PageType.grid,
  );
  double itemVerticalSpace = kVerticalPadding/3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kVerticalPadding,
        horizontal: kHorizontalPadding,
      ),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Sıra Numarası'),
            keyboardType: const TextInputType.numberWithOptions(),
            initialValue: pageData.orderNumber?.toString(),
            onChanged: (value) => pageData.orderNumber = int.tryParse(value),
          ),
          SizedBox(height: itemVerticalSpace),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Başlık (Ön)'),
            initialValue: pageData.titleFront,
            onChanged: (value) => pageData.titleFront = value,
          ),
          SizedBox(height: itemVerticalSpace),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Başlık (Arka)'),
            initialValue: pageData.titleBack,
            onChanged: (value) => pageData.titleBack = value,
          ),
          SizedBox(height: itemVerticalSpace),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Açıklama'),
            initialValue: pageData.description,
            onChanged: (value) => pageData.description = value,
          ),
          SizedBox(height: itemVerticalSpace),
          DropdownButtonFormField<PageType>(
            value: pageData.type,
            decoration: const InputDecoration(labelText: 'Sayfa Tipi'),
            items: PageType.values.map<DropdownMenuItem<PageType>>((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e.getTitle()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                pageData.type = value;
              });
            },
          ),
          // SizedBox(height: itemVerticalSpace),
          if (pageData.type != null) Divider( height: itemVerticalSpace*2),
          // SizedBox(height: itemVerticalSpace),
          if (pageData.type != null) Builder(builder: (context) {
            switch (pageData.type) {
              case PageType.grid: return const GridTypePage();
              case PageType.album:
              case PageType.text:
              default:
                return const SizedBox();
            }
          },),
        ],
      ),
    );
  }
}
