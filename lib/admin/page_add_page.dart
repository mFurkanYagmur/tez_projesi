import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';
import 'package:mv_adayi_web_site/util/util.dart';
import 'package:provider/provider.dart';

import '../enum/page_type.dart';
import '../helper/ui_helper.dart';
import '../util/constants.dart';
import '../util/validators.dart';
import '../viewmodels/page_add_viewmodel.dart';
import '../widget/custom_solid_button.dart';
import '../widget/loading_widget.dart';
import '../widget/reorderable_data_list.dart';
import '../widget/text_field_counter.dart';

class PageAddPage extends StatelessWidget {
  const PageAddPage({super.key, this.pageModel});

  final PageModel? pageModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PageAddViewModel(),
      child: _PageAddPage(pageModel: pageModel),
    );
  }
}

class _PageAddPage extends StatefulWidget {
  const _PageAddPage({this.pageModel});

  final PageModel? pageModel;

  @override
  State<_PageAddPage> createState() => _PageAddPageState();
}

class _PageAddPageState extends State<_PageAddPage> {
  double itemVerticalSpace = kVerticalPadding / 3;
  PageAddViewModel? pageAddViewModel;

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isUpdated = false;

  @override
  void initState() {
    super.initState();
    if (widget.pageModel != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
        pageAddViewModel!.pageModel = widget.pageModel!;
        isUpdated = true;
        });
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    pageAddViewModel ??= context.read<PageAddViewModel>();
    DataType? pageType = pageAddViewModel!.pageModel.type;
    if (widget.pageModel != null && !isUpdated) return const LoadingWidget();
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
              decoration: const InputDecoration(labelText: 'Menü Başlığı'),
              initialValue: pageAddViewModel!.pageModel.menuTitle,
              maxLength: 20,
              buildCounter: buildTextFieldCounter,
              validator: (value) => Validators.requiredTextValidator(value, 3),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                pageAddViewModel!.pageModel.menuTitle = value;
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
                    Util.showFullSizePage(context: context, pageType: pageType, pageModel: pageAddViewModel!.pageModel);
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
