import 'package:mv_adayi_web_site/model/data_model/data_model.dart';

class TextDataModel extends DataModel {
  String? title;
  String? content;

  TextDataModel();

  TextDataModel.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    content = map['content'];
  }

  @override
  toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}