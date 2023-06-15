import 'package:mv_adayi_web_site/model/data_model.dart';

class GridDataModel extends DataModel {
  int? iconCodePoint;
  String? title;
  String? content;

  GridDataModel();

  GridDataModel.fromMap(Map<String, dynamic> map) {
    iconCodePoint = map['iconCodePoint'];
    title = map['title'];
    content = map['content'];
  }

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