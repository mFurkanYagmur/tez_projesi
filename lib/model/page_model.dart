import 'package:mv_adayi_web_site/model/data_model/data_model.dart';
import 'package:mv_adayi_web_site/model/data_model/grid_data_model.dart';
import 'package:mv_adayi_web_site/util/util.dart';

import '../enum/page_type.dart';

class PageModel {
  int? orderNumber;
  String? titleFront;
  String? titleBack;
  String? description;
  PageType type = PageType.grid;
  int column = 1;
  List<DataModel> data = [
    GridDataModel(),
  ];

  PageModel();

  PageModel.fromMap(Map<String, dynamic> map) {
    PageType? pageType = Util.convertStringToPageType(map['type'].toString());
    if (pageType == null) {
      throw Exception('Hatalı sayfa türü! ${map['type']}');
    }

    List<DataModel> dataList = (map['data'] as List).map((e) => e as Map).map((e) {
      switch (pageType) {
        case PageType.grid:
          //  TODO: move this code to enum.PageType
          return GridDataModel.fromMap(e as Map<String, dynamic>);
        case PageType.text:
        case PageType.album:
          return GridDataModel.fromMap(e as Map<String, dynamic>);
      }
    }).toList();

    orderNumber = map['orderNumber'];
    titleFront = map['titleFront'];
    titleBack = map['titleBack'];
    description = map['description'];
    type = pageType;
    column = map['column'];
    data = dataList;

    // return PageModel.fillData(
    //   orderNumber: map['orderNumber'],
    //   titleFront: map['titleFront'],
    //   titleBack: map['titleBack'],
    //   description: map['description'],
    //   type: pageType,
    //   column: map['column'],
    //   data: dataList,
    // );
  }

  removeDataFromList(int index) {
    if (data.length <= 1) return;
    data.removeAt(index);
  }

  Map<String, dynamic> toJson() => {
        'orderNumber': orderNumber,
        'titleFront': titleFront,
        'titleBack': titleBack,
        'description': description,
        'type': type.name,
        'column': column,
        'data': data.map((e) => e.toJson()).toList(),
      };
}
