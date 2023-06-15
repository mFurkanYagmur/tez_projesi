import 'package:mv_adayi_web_site/model/grid_data_model.dart';

import '../enum/page_type.dart';

class PageModel {
  int? orderNumber;
  String? titleFront;
  String? titleBack;
  String? description;
  PageType type = PageType.grid;
  int column = 1;
  List data = [
    GridDataModel(),
  ];
  // Map<String, dynamic>? data;

  PageModel();

  /*PageModel.fillData({
    required this.orderNumber,
    required this.titleFront,
    required this.titleBack,
    this.description,
    required this.type,
    required this.data,
  }) : assert (orderNumber != null && titleFront != null && titleBack != null && type != null && data != null);*/

  // PageModel.fillData({
  //   this.orderNumber,
  //   this.titleFront,
  //   this.titleBack,
  //   this.description,
  //   this.type,
  //   this.data = const [],
  // });

  removeDataFromList(int index){
    if (data.length<=1) return;
    data.removeAt(index);
  }

  Map toJson() => {
    'orderNumber': orderNumber,
    'titleFront': titleFront,
    'titleBack': titleBack,
    'description': description,
    'type': type,
    'column': column,
    'data': data,
  };
}