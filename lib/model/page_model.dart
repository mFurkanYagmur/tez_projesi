import 'package:mv_adayi_web_site/model/data_model/data_model.dart';
import 'package:mv_adayi_web_site/model/data_model/grid_data_model.dart';
import 'package:mv_adayi_web_site/model/data_model/slider_data_model.dart';
import 'package:mv_adayi_web_site/model/data_model/text_data_model.dart';
import 'package:mv_adayi_web_site/util/util.dart';

import '../enum/page_type.dart';
import 'data_model/album_data_model.dart';

class PageModel {
  String? docName;
  int? orderNumber;
  String? menuTitle;
  String? titleFront;
  String? titleBack;
  String? description;
  DataType type = DataType.grid;
  int column = 1;
  List<DataModel> data = [
    GridDataModel(),
  ];

  PageModel();
  // PageModel({DataType dataType = DataType.sliderText, List<DataModel>? dataList}) : data = dataList ?? [dataType.getInfo().createDataModel()], type = dataType;

  PageModel.withType({required this.type}){
    data = [
      type.getInfo().createDataModel(),
    ];
  }

  PageModel.fromMap(Map<String, dynamic> map, this.docName) {
    DataType? pageType = Util.convertStringToPageType(map['type'].toString());
    if (pageType == null) {
      throw Exception('Hatalı sayfa türü! ${map['type']}');
    }

    List<DataModel> dataList = (map['data'] as List).map((e) => e as Map).map((e) {
      switch (pageType) {
        case DataType.grid:
          return GridDataModel.fromMap(e as Map<String, dynamic>);
        case DataType.text:
          return TextDataModel.fromMap(e as Map<String, dynamic>);
        case DataType.album:
          return AlbumDataModel.fromMap(e as Map<String, dynamic>);
        case DataType.sliderText:
          return SliderDataModel.fromMap(e as Map<String, dynamic>);
      }
    }).toList();

    orderNumber = map['orderNumber'];
    menuTitle = map['menuTitle'];
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
        'menuTitle': menuTitle,
        'titleFront': titleFront,
        'titleBack': titleBack,
        'description': description,
        'type': type.name,
        'column': column,
        'data': data.map((e) => e.toJson()).toList(),
      };
}
