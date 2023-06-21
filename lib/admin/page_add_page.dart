import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../enum/page_type.dart';
import '../helper/ui_helper.dart';
import '../util/constants.dart';
import '../util/validators.dart';
import '../viewmodels/page_add_viewmodel.dart';
import '../widget/custom_solid_button.dart';
import '../widget/reorderable_data_list.dart';

class PageAddPage extends StatelessWidget {
  const PageAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PageAddViewModel(),
      child: const _PageAddPage(),
    );
  }
}

class _PageAddPage extends StatefulWidget {
  const _PageAddPage();

  @override
  State<_PageAddPage> createState() => _PageAddPageState();
}

class _PageAddPageState extends State<_PageAddPage> {
  double itemVerticalSpace = kVerticalPadding / 3;
  PageAddViewModel? pageAddViewModel;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    pageAddViewModel ??= context.read<PageAddViewModel>();
    DataType? pageType = pageAddViewModel!.pageModel.type;
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
              validator: context.select<PageAddViewModel, DataType>((value) => value.pageModel.type) == DataType.text
                  ? (value) => null
                  : Validators.requiredTextValidator,
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
              validator: context.select<PageAddViewModel, DataType>((value) => value.pageModel.type) == DataType.text
                  ? (value) => null
                  : Validators.requiredTextValidator,
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
            DropdownButtonFormField<DataType>(
              value: pageType,
              decoration: const InputDecoration(labelText: 'Sayfa Tipi'),
              items: _manageableDataTypes().map<DropdownMenuItem<DataType>>((e) {
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
              var pageType = context.select<PageAddViewModel, DataType>((value) => value.pageModel.type);
              return TextFormField(
                enabled: pageType != DataType.text,
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
            ReorderableDataList(dataType: pageType),
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
                const SizedBox(
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

  Widget _buildPreview(DataType pageType) {
    return Builder(builder: (context) {
      context.watch<PageAddViewModel>();
      return Column(
        children: [
          Text(
            'Canlı Önizleme',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
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

  List<DataType> _manageableDataTypes() {
    List<DataType> tempList = List.of(DataType.values);
    tempList.removeWhere((element) => !element.usePageManagement());
    return tempList;
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
