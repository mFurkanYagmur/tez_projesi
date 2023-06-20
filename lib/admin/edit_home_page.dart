import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mv_adayi_web_site/enum/page_type.dart';
import 'package:mv_adayi_web_site/helper/ui_helper.dart';
import 'package:mv_adayi_web_site/model/data_model/slider_data_model.dart';
import 'package:mv_adayi_web_site/model/slider_content_model.dart';
import 'package:mv_adayi_web_site/util/constants.dart';
import 'package:mv_adayi_web_site/util/util.dart';
import 'package:mv_adayi_web_site/viewmodels/page_add_viewmodel.dart';
import 'package:mv_adayi_web_site/widget/loading_widget.dart';
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
  DataViewModel? dataViewModel;
  SliderContentModel? sliderContentModel;
  SliderContentModel? lastSavedSliderContent;

  final GlobalKey<FormState> _sliderFormKey = GlobalKey();

  @override
  void dispose() {
    pageAddViewModel?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    pageAddViewModel ??= context.read<PageAddViewModel>();
    dataViewModel ??= context.read<DataViewModel>();
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
      child: Stack(
        children: [
          if (sliderContentModel != null)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _sliderFormKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Arkaplan Görsel Adresi',
                              ),
                              initialValue: sliderContentModel?.backgroundImage ?? '',
                              validator: (value) => Validators.requiredTextValidator(value),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.url,
                              onChanged: (value) {
                                sliderContentModel!.backgroundImage = value;
                                setState(() {

                                });
                              },
                            ),
                          ),
                          if (sliderContentModel!.backgroundImage != null && sliderContentModel!.backgroundImage!.isNotEmpty) Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Image.network(
                                sliderContentModel!.backgroundImage!,
                              width: 100,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey,
                                  width: 100,
                                  height: 70,
                                  child: const Center(
                                    child: Text('Hatalı Görsel!'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Twitter Profil Adresi',
                        ),
                        initialValue: sliderContentModel?.twitterUrl ?? '',
                        validator: (value) => Validators.requiredTextValidator(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.url,
                        onChanged: (value) {
                          sliderContentModel!.twitterUrl = value;
                        },
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Instagram Profil Adresi',
                        ),
                        initialValue: sliderContentModel?.instagramUrl ?? '',
                        validator: (value) => Validators.requiredTextValidator(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.url,
                        onChanged: (value) {
                          sliderContentModel!.instagramUrl = value;
                        },
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Facebook Profil Adresi',
                        ),
                        initialValue: sliderContentModel?.facebookUrl ?? '',
                        validator: (value) => Validators.requiredTextValidator(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.url,
                        onChanged: (value) {
                          sliderContentModel!.facebookUrl = value;
                        },
                      ),
                      const Divider(
                        height: 32,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Sabit metin (slider öncesi)',
                        ),
                        initialValue: sliderContentModel?.beforeSliderText ?? '',
                        maxLength: 40,
                        buildCounter: buildTextFieldCounter,
                        validator: (value) => Validators.requiredTextValidator(value, 3),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          sliderContentModel!.beforeSliderText = value;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Sabit metin (slider sonrası)',
                        ),
                        initialValue: sliderContentModel?.afterSliderText ?? '',
                        maxLength: 40,
                        buildCounter: buildTextFieldCounter,
                        onChanged: (value) {
                          sliderContentModel!.afterSliderText = value;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Parti Sayfası',
                        ),
                        initialValue: sliderContentModel?.partiUrl ?? '',
                        validator: (value) => Validators.requiredTextValidator(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.url,
                        onChanged: (value) {
                          sliderContentModel!.partiUrl = value;
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
                          sliderContentModel!.sliderContent =
                              pageAddViewModel!.pageModel.data.map((e) => (e as SliderDataModel).content!).toList();
                        },
                        builder: (field) {
                          return Accordion(
                            children: [
                              AccordionSection(
                                header: const Text('Slider İçeriği', style: TextStyle(color: Colors.white),),
                                content: const ReorderableDataList(dataType: DataType.sliderText),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (lastSavedSliderContent == sliderContentModel) {
                              UIHelper.showSnackBar(context: context, text: 'Veriler Kaydededildi', type: UIType.success);
                              debugPrint('aynı veriler');
                              return;
                            }
                            if (_sliderFormKey.currentState!.validate()) {
                              _sliderFormKey.currentState!.save();
                              _saveSliderContent();
                            } else {
                              UIHelper.showSnackBar(context: context, text: 'Lütfen tüm zorunlu alanları doldurun.', type: UIType.warning);
                            }
                          },
                          child: const Text('Kaydet')),
                    ],
                  ),
                ),
              ],
            ),
          if (sliderContentModel == null) const LoadingWidget(),
        ],
      ),
    );
  }

  _loadData() async {
    try {
      Map<String, dynamic> data = await dataViewModel!.getData(collectionPath: 'homePage', documentName: 'sliderContent');
      setState(() {
        sliderContentModel = SliderContentModel.fromMap(data);
        lastSavedSliderContent = SliderContentModel.fromMap(data);
        pageAddViewModel!.pageModel.data =
            sliderContentModel!.sliderContent!.map((e) => SliderDataModel.withContent(content: e)).toList();
      });
    } catch (e) {
      debugPrint(e.toString());
      Util.showErrorMessage(context);
    }
  }

  _saveSliderContent() async {
    try {
      UIHelper.showSnackBar(context: context, text: 'Veriler Kaydediliyor...', type: UIType.info);
      await dataViewModel!
          .saveData(data: sliderContentModel!.toJson(), collectionPath: 'homePage', documentName: 'sliderContent');
      if (!mounted) return;
      UIHelper.showSnackBar(context: context, text: 'Veriler Kaydededildi', type: UIType.success);
      debugPrint('Slider content is : $sliderContentModel');
    } catch (e) {
      debugPrint(e.toString());
      Util.showErrorMessage(context);
    }
  }
}
