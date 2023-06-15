import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/admin/typed_page/grid_typed_page.dart';
import 'package:mv_adayi_web_site/constants.dart';
import 'package:mv_adayi_web_site/pages/grid_page.dart';
import 'package:mv_adayi_web_site/widget/custom_solid_button.dart';
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
    context.watch<PageAddViewModel>();
    PageType? pageType = pageAddViewModel!.pageModel.type;
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
            onChanged: (value) {
              pageAddViewModel!.pageModel.orderNumber = int.tryParse(value);
              pageAddViewModel!.notifyChanges();
            },
          ),
          SizedBox(height: itemVerticalSpace),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Başlık (Ön)'),
            initialValue: pageAddViewModel!.pageModel.titleFront,
            onChanged: (value) {
              pageAddViewModel!.pageModel.titleFront = value;
              pageAddViewModel!.notifyChanges();
            },
          ),
          SizedBox(height: itemVerticalSpace),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Başlık (Arka)'),
            initialValue: pageAddViewModel!.pageModel.titleBack,
            onChanged: (value) {
              pageAddViewModel!.pageModel.titleBack = value;
              pageAddViewModel!.notifyChanges();
            },
          ),
          SizedBox(height: itemVerticalSpace),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Açıklama'),
            initialValue: pageAddViewModel!.pageModel.description,
            onChanged: (value) {
              pageAddViewModel!.pageModel.description = value;
              pageAddViewModel!.notifyChanges();
            },
          ),
          SizedBox(height: itemVerticalSpace),
          DropdownButtonFormField<PageType>(
            value: pageType,
            decoration: const InputDecoration(labelText: 'Sayfa Tipi'),
            items: PageType.values.map<DropdownMenuItem<PageType>>((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e.getTitle()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                pageAddViewModel!.pageModel.type = value ?? PageType.grid;
                pageAddViewModel!.notifyChanges();
              });
            },
          ),
          Divider(height: itemVerticalSpace * 2),
          _buildAddPage(pageType),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
            child: _buildPreview(pageType),
          ),
          CustomSolidButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    insetPadding: EdgeInsets.zero,
                    child: SingleChildScrollView(child: _getPreviewPage(pageType)),
                  );
                },
              );
            },
            text: 'Tam Sayfa Önizle',
          ),
        ],
      ),
    );
  }

  Widget _buildAddPage(PageType pageType) {
    return Builder(
      builder: (context) {
        switch (pageType) {
          case PageType.grid:
            return const GridTypePage();
          case PageType.album:
          case PageType.text:
          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget _buildPreview(PageType pageType) {
    return Column(
      children: [
        Text(
          'Canlı Önizleme',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          height: kVerticalPadding / 2,
        ),
        Builder(
          builder: (context) {
            switch (pageType) {
              case PageType.grid:
                return GridPage(pageModel: pageAddViewModel!.pageModel);
              case PageType.album:
              case PageType.text:
              default:
                return const SizedBox();
            }
          },
        ),
        Align(
            alignment: Alignment.centerRight,
            child: Text(
              '*Gerçek boyutlarda önizleme için "Tam Sayfa Önizle" aracını kullanın.',
              style: Theme.of(context).textTheme.bodySmall,
            )),
      ],
    );
  }

  Widget _getPreviewPage(PageType pageType) {
    switch (pageType) {
      case PageType.grid:
        return GridPage(pageModel: pageAddViewModel!.pageModel);
      case PageType.album:
      case PageType.text:
      default:
        return const SizedBox();
    }
  }
}
