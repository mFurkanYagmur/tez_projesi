import 'package:flutter/material.dart';

import '../enum/page_type.dart';
import '../helper/ui_helper.dart';
import '../model/page_model.dart';

class Util {
  static DataType? convertStringToPageType(String pageType) {
    for (var type in DataType.values) {
      if (type.name == pageType) return type;
    }
    return null;
  }

  static showErrorMessage(BuildContext context) {
    UIHelper.showSnackBar(context: context, text: 'Bir hata oluştu! Lütfen tekrar deneyin.', type: UIType.danger);
  }

  static bool getPageSameAsFooter(int index) {
    return index %2 == 1;
  }

  static showFullSizePage({required BuildContext context, required DataType pageType, required PageModel pageModel,}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: SingleChildScrollView(
            child: pageType.getInfo().page(pageModel),
          ),
        );
      },
    );
  }
}