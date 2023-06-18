import '../enum/page_type.dart';

class Util {
  static DataType? convertStringToPageType(String pageType) {
    for (var type in DataType.values) {
      if (type.name == pageType) return type;
    }
    return null;
  }
}