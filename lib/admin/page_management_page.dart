import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mv_adayi_web_site/helper/ui_helper.dart';
import 'package:mv_adayi_web_site/util/constants.dart';
import 'package:mv_adayi_web_site/util/validators.dart';
import 'package:mv_adayi_web_site/widget/custom_solid_button.dart';
import 'package:mv_adayi_web_site/widget/reorderable_data_list.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    pageAddViewModel ??= context.read<PageAddViewModel>();
    PageType? pageType = pageAddViewModel!.pageModel.type;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kVerticalPadding,
        horizontal: kHorizontalPadding,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Sıra Numarası'),
              keyboardType: const TextInputType.numberWithOptions(),
              initialValue: pageAddViewModel!.pageModel.orderNumber?.toString(),
              validator: Validators.requiredTextValidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                pageAddViewModel!.pageModel.orderNumber = int.tryParse(value);
                pageAddViewModel!.notifyChanges();
              },
            ),
            SizedBox(height: itemVerticalSpace),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Başlık (Ön)'),
              initialValue: pageAddViewModel!.pageModel.titleFront,
              validator: Validators.requiredTextValidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                pageAddViewModel!.pageModel.titleFront = value;
                pageAddViewModel!.notifyChanges();
              },
            ),
            SizedBox(height: itemVerticalSpace),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Başlık (Arka)'),
              initialValue: pageAddViewModel!.pageModel.titleBack,
              validator: Validators.requiredTextValidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  child: Text(e.getInfo().title),
                );
              }).toList(),
              validator: (value) {
                if (value == null) return 'Lütfen sayfa tipi seçiniz.';
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                if (pageAddViewModel!.pageModel.type == value || value == null) return;
                setState(() {
                  pageAddViewModel!.pageModel.type = value;
                  pageAddViewModel!.pageModel.data = [value.getInfo().createDataModel()];
                  pageAddViewModel!.notifyChanges();
                });
              },
            ),
            Divider(height: itemVerticalSpace * 2),
            Builder(builder: (context) {
              var pageType = context.select<PageAddViewModel, PageType>((value) => value.pageModel.type);
              return TextFormField(
                enabled: pageType != PageType.text,
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
                validator: Validators.numberValidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  pageAddViewModel!.pageModel.column = int.tryParse(value) ?? 1;
                  pageAddViewModel!.notifyChanges();
                },
              );
            }),
            const SizedBox(height: 24),
            ReorderableDataList(pageType: pageType),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
              child: _buildPreview(pageType),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomSolidButton(
                  bgFilled: false,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          insetPadding: EdgeInsets.zero,
                          child: SingleChildScrollView(
                            child: pageType.getInfo().page(pageAddViewModel!.pageModel),
                          ),
                        );
                      },
                    );
                  },
                  text: 'Tam Sayfa Önizle',
                ),
                SizedBox(
                  width: kHorizontalPadding,
                ),
                CustomSolidButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      UIHelper.showSnackBar(context: context, type: UIType.info, text: 'Kaydediliyor...');
                      _save();
                    }
                  },
                  text: 'Kaydet',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview(PageType pageType) {
    return Builder(builder: (context) {
      context.watch<PageAddViewModel>();
      return Column(
        children: [
          Text(
            'Canlı Önizleme',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: kVerticalPadding / 2,
          ),
          pageType.getInfo().page(pageAddViewModel!.pageModel),
          // Builder(
          //   builder: (context) {
          //     switch (pageType) {
          //       case PageType.grid:
          //         return GridPage(pageModel: pageAddViewModel!.pageModel);
          //       case PageType.album:
          //       case PageType.text:
          //       default:
          //         return const SizedBox();
          //     }
          //   },
          // ),
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                '*Gerçek boyutlarda önizleme için "Tam Sayfa Önizle" aracını kullanın.',
                style: Theme.of(context).textTheme.bodySmall,
              )),
        ],
      );
    });
  }

  _save() async {
    try {
      await pageAddViewModel!.save();
      UIHelper.showSnackBar(context: context, type: UIType.success, text: 'Sayfa kaydedildi!');
    } catch (e) {
      UIHelper.showSnackBar(context: context, type: UIType.danger, text: 'Bir hata meydana geldi. Sayfa kaydedilemedi!');
      log('ERROR!: $e', error: e);
    }
  }
}
