import 'package:mv_adayi_web_site/model/data_model/data_model.dart';

class SliderDataModel extends DataModel {
  String? content;

  SliderDataModel();
  SliderDataModel.withContent({required this.content});

  SliderDataModel.fromMap(Map<String, dynamic> map) {
    content = map['content'];
  }

  @override
  toJson() {
    return {
      'content': content,
    };
  }
}