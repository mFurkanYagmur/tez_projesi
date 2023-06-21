import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mv_adayi_web_site/helper/ui_helper.dart';
import 'package:mv_adayi_web_site/model/data_model/text_data_model.dart';
import 'package:mv_adayi_web_site/util/constants.dart';
import 'package:mv_adayi_web_site/util/util.dart';
import 'package:mv_adayi_web_site/viewmodels/data_view_model.dart';
import 'package:mv_adayi_web_site/viewmodels/home_page_viewmodel.dart';
import 'package:mv_adayi_web_site/viewmodels/page_add_viewmodel.dart';
import 'package:mv_adayi_web_site/widget/custom_solid_button.dart';
import 'package:mv_adayi_web_site/widget/loading_widget.dart';
import 'package:provider/provider.dart';

import '../enum/page_type.dart';
import '../model/page_model.dart';

class PageManager extends StatelessWidget {
  const PageManager({super.key, required this.navigateAddPage});

  final Function(PageModel? page) navigateAddPage;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomePageViewModel()),
        ChangeNotifierProvider(create: (context) => PageAddViewModel()),
        ChangeNotifierProvider(create: (context) => DataViewModel()),
      ],
      child: _PageManager(navigateAddPage: navigateAddPage),
    );
  }
}

class _PageManager extends StatefulWidget {
  const _PageManager({required this.navigateAddPage});

  final Function(PageModel? page) navigateAddPage;

  @override
  State<_PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<_PageManager> {
  HomePageViewModel? homePageViewModel;
  DataViewModel? dataViewModel;

  List<PageModel>? changedList;
  final List<String> deletedPages = [];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      homePageViewModel!.loadPages();
    });
  }

  @override
  Widget build(BuildContext context) {
    homePageViewModel ??= context.read<HomePageViewModel>();
    dataViewModel ??= context.read<DataViewModel>();
    context.watch<HomePageViewModel>();
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: homePageViewModel!.listenPages(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          changedList ??= List.of(homePageViewModel!.pages);
          return Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: size.height * 0.75),
                child: ReorderableListView(
                  shrinkWrap: true,
                  buildDefaultDragHandles: false,
                  physics: const BouncingScrollPhysics(),
                  onReorder: (oldIndex, newIndex) {
                    _changeOrder(oldIndex: oldIndex, newIndex: newIndex);
                  },
                  children: List.generate(changedList!.length, (index) {
                    PageModel pageModel = changedList![index];
                    String title = pageModel.titleFront ??
                        (pageModel.type == DataType.text ? pageModel.data.map((e) => (e as TextDataModel).title).join(', ') : '');
                    return ListTile(
                      key: UniqueKey(),
                      onTap: () {
                        Util.showFullSizePage(context: context, pageType: pageModel.type, pageModel: pageModel);
                      },
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: kPrimaryColor,
                            child: Text('${index + 1}',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(pageModel.type.getInfo().title),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                widget.navigateAddPage(pageModel);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  var page = changedList!.removeAt(index);
                                  deletedPages.add(page.docName!);
                                });
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              )),
                          ReorderableDragStartListener(index: index, child: const Icon(Icons.drag_handle)),
                        ],
                      ),
                      title: Text(title),
                      subtitle: Text(pageModel.titleBack ?? ''),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSolidButton(
                    bgFilled: false,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    onPressed: () {
                      setState(() {
                        changedList = List.of(homePageViewModel!.pages);
                      });
                    },
                    text: 'Sıfırla',
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  CustomSolidButton(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    onPressed: () {
                      _save();
                    },
                    text: 'Kaydet',
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          );
        }
        return const LoadingWidget();
      },
    );
  }

  _changeOrder({required int oldIndex, required int newIndex}) {
    if (newIndex >= changedList!.length) {
      newIndex = changedList!.length - 1;
    } else if (oldIndex < newIndex) {
      newIndex--;
    }
    if (newIndex == oldIndex) return;
    setState(() {
      var item = changedList!.removeAt(oldIndex);
      changedList!.insert(newIndex, item);
    });
  }

  _save() async {
    // try {
      await _deleteDocuments();
      await _updateOrderDocuments();
      UIHelper.showSnackBar(context: context, text: 'İşlem Tamamlandı.', type: UIType.success);
    // } catch (e) {
    //   Util.showErrorMessage(context);
    //   log(e.toString(), error: e);
    // }
  }

  Future _deleteDocuments() async {
    if (deletedPages.isEmpty) return;
    for (String doc in deletedPages) {
    await dataViewModel!.deleteData(collectionPath: 'pages', documentName: doc);
    }
    UIHelper.showSnackBar(context: context, text: 'İstenen sayfalar silindi.', type: UIType.info);
  }

  Future _updateOrderDocuments() async {
    for (int i=0; i<changedList!.length; i++) {
      PageModel page = changedList![i];
      page.orderNumber = i+1;
    await dataViewModel!.saveData(data: page.toJson(),collectionPath: 'pages', documentName: page.docName);
    }
    UIHelper.showSnackBar(context: context, text: 'SyafalarGüncellendi.', type: UIType.info);
  }
}
