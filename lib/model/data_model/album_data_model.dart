import 'package:mv_adayi_web_site/model/data_model/data_model.dart';

class AlbumDataModel extends DataModel {
  String? imageUrl;
  String? description;

  AlbumDataModel();

  AlbumDataModel.fromMap(Map<String, dynamic> map) {
    imageUrl = map['imageUrl'];
    description = map['alt'];
  }

  @override
  toJson() {
    return {
      'imageUrl': imageUrl,
      'alt': description,
    };
  }
}