import 'package:mv_adayi_web_site/model/data_model.dart';
import 'package:mv_adayi_web_site/model/grid_data_model.dart';

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
