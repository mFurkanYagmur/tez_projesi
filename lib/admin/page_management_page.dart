import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/admin/typed_page/grid_typed_page.dart';
import 'package:mv_adayi_web_site/constants.dart';
import 'package:provider/provider.dart';

import '../enum/page_type.dart';
import '../viewmodels/page_add_viewmodel.dart';

class PageManagementPage extends StatefulWidget {
  const PageManagementPage({Key? key}) : super(key: key);

  @override
  State<PageManagementPage> createState() => _PageManagementPageState();
}

class _PageManagementPageState extends State<PageManagementPage> {
  double itemVerticalSpace = kVerticalPadding / 3;
  PageAddViewModel? pageAddViewModel;

  @override
  Widget build(BuildContext context) {
    pageAddViewModel ??= context.read<PageAddViewModel>();
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
            initialValue: pageAddViewModel!.pageModel.orderNumber?.toString(),
            onChanged: (value) => pageAddViewModel!.pageModel.orderNumber = int.tryParse(value),
          ),
          SizedBox(height: itemVerticalSpace),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Başlık (Ön)'),
            initialValue: pageAddViewModel!.pageModel.titleFront,
            onChanged: (value) => pageAddViewModel!.pageModel.titleFront = value,
          ),
          SizedBox(height: itemVerticalSpace),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Başlık (Arka)'),
            initialValue: pageAddViewModel!.pageModel.titleBack,
            onChanged: (value) => pageAddViewModel!.pageModel.titleBack = value,
          ),
          SizedBox(height: itemVerticalSpace),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Açıklama'),
            initialValue: pageAddViewModel!.pageModel.description,
            onChanged: (value) => pageAddViewModel!.pageModel.description = value,
          ),
          SizedBox(height: itemVerticalSpace),
          DropdownButtonFormField<PageType>(
            value: pageAddViewModel!.pageModel.type,
            decoration: const InputDecoration(labelText: 'Sayfa Tipi'),
            items: PageType.values.map<DropdownMenuItem<PageType>>((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e.getTitle()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                pageAddViewModel!.pageModel.type = value;
              });
            },
          ),
          // SizedBox(height: itemVerticalSpace),
          if (pageAddViewModel!.pageModel.type != null) Divider(height: itemVerticalSpace * 2),
          // SizedBox(height: itemVerticalSpace),
          if (pageAddViewModel!.pageModel.type != null)
            Builder(
              builder: (context) {
                switch (pageAddViewModel!.pageModel.type) {
                  case PageType.grid:
                    return const GridTypePage();
                  case PageType.album:
                  case PageType.text:
                  default:
                    return const SizedBox();
                }
              },
            ),
        ],
      ),
    );
  }
}
