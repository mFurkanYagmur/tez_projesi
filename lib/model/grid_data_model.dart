import 'package:mv_adayi_web_site/model/data_model.dart';

class GridDataModel extends DataModel {
  int? iconCodePoint;
  String? title;
  String? content;

  @override
  toJson() {
    return {
      'iconCodePoint': iconCodePoint,
      'title': title,
      'content': content,
    };
  }

  // GridDataModel({required this.iconCodePoint, required this.title, required this.content});
}