import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';
import 'package:mv_adayi_web_site/services/firebase_client.dart';

import '../enum/page_type.dart';

class PageAddViewModel extends ChangeNotifier {
  PageModel pageModel;

  PageAddViewModel({DataType? dataType}) : pageModel = dataType == null ? PageModel() : PageModel.withType(type: dataType);

  notifyChanges() {
    notifyListeners();
  }

  Future save() async {
    return await FirebaseClient.instance.saveData(data: pageModel.toJson(), collectionPath: 'pages', documentName: pageModel.docName);
  }
}
