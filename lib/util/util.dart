import '../enum/page_type.dart';

class Util {
  static PageType? convertStringToPageType(String pageType) {
    for (var type in PageType.values) {
      if (type.name == pageType) return type;
    }
    return null;
  }
}