import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/enum/page_type.dart';
import 'package:mv_adayi_web_site/helper/ui_helper.dart';
import 'package:mv_adayi_web_site/model/data_model/slider_data_model.dart';
import 'package:mv_adayi_web_site/model/slider_content_model.dart';
import 'package:mv_adayi_web_site/util/constants.dart';
import 'package:mv_adayi_web_site/viewmodels/page_add_viewmodel.dart';
import 'package:mv_adayi_web_site/widget/reorderable_data_list.dart';
import 'package:provider/provider.dart';

import '../util/validators.dart';
import '../viewmodels/data_view_model.dart';
import '../widget/text_field_counter.dart';

class EditHomePage extends StatelessWidget {
  const EditHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageAddViewModel(dataType: DataType.sliderText)),
        ChangeNotifierProvider(create: (context) => DataViewModel()),
      ],
      child: const _EditHomePage(),
    );
  }
}

class _EditHomePage extends StatefulWidget {
  const _EditHomePage({Key? key}) : super(key: key);

  @override
  State<_EditHomePage> createState() => _EditHomePageState();
}

class _EditHomePageState extends State<_EditHomePage> {
  PageAddViewModel? pageAddViewModel;
  final SliderContentModel sliderContentModel = SliderContentModel();

  final GlobalKey<FormState> _sliderFormKey = GlobalKey();

  @override
  void dispose() {
    pageAddViewModel?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pageAddViewModel ??= context.read<PageAddViewModel>();
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Accordion(
            children: [
              AccordionSection(
                header: const Text('Slider İçerikleri'),
                content: Column(
                  children: [
                    Form(
                      key: _sliderFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Sabit metin (slider öncesi)',
                            ),
                            initialValue: sliderContentModel.beforeSliderText ?? '',
                            maxLength: 40,
                            buildCounter: buildTextFieldCounter,
                            validator: (value) => Validators.requiredTextValidator(value, 3),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              sliderContentModel.beforeSliderText = value;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Sabit metin (slider sonrası)',
                            ),
                            initialValue: sliderContentModel.afterSliderText ?? '',
                            maxLength: 40,
                            buildCounter: buildTextFieldCounter,
                            onChanged: (value) {
                              sliderContentModel.afterSliderText = value;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Parti Sayfası',
                            ),
                            initialValue: sliderContentModel.partiUrl ?? '',
                            validator: (value) => Validators.requiredTextValidator(value),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.url,
                            onChanged: (value) {
                              sliderContentModel.partiUrl = value;
                            },
                          ),
                          const Divider(
                            height: 32,
                          ),
                          FormField(
                            validator: (value) {
                              bool containsEmpty = pageAddViewModel!.pageModel.data
                                  .any((element) => (element as SliderDataModel).content?.isEmpty ?? true);
                              if (containsEmpty) {
                                return 'Lütfen açık olan tüm alanları doldurun';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              sliderContentModel.sliderContent =
                                  pageAddViewModel!.pageModel.data.map((e) => (e as SliderDataModel).content!).toList();
                            },
                            builder: (field) {
                              return const ReorderableDataList(dataType: DataType.sliderText);
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (_sliderFormKey.currentState!.validate()) {
                                  _sliderFormKey.currentState!.save();
                                  _saveSliderContent();
                                }
                              },
                              child: const Text('Kaydet')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _saveSliderContent() async {
    UIHelper.showSnackBar(context: context, text: 'Veriler Kaydediliyor...', type: UIType.info);
    await context
        .read<DataViewModel>()
        .saveData(data: sliderContentModel.toJson(), collectionPath: 'homePage', documentName: 'sliderContent');
    if (!mounted) return;
    UIHelper.showSnackBar(context: context, text: 'Veriler Kaydededildi', type: UIType.success);
    debugPrint('Slider content is : $sliderContentModel');
  }
}
