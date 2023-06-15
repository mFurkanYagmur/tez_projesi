import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mv_adayi_web_site/model/page_model.dart';

import '../enum/page_type.dart';

class FirebaseClient {
  FirebaseClient._();

  static FirebaseClient? _instance;

  static FirebaseClient get instance {
    _instance ??= FirebaseClient._();
    return _instance!;
  }

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map standartPageData = {
    'order_number': 1,
    'title_front': 'Ne Yapacağız?',
    'title_back': '150 Günlük Plan',
    'description':
        'Seçildiğimiz takdirde görevi devraldığımız günden itibaren ilk 150 gün içerisinde yürürlüğe koyacağımız değişiklikler.',
    'type': PageType.grid.name,
    'column': 2,
    'data': [],
  };

  Future savePage({required PageModel pageModel}) async {
    await _firestore.collection('pages').add(pageModel.toJson());
    log('Sayfa Kaydedildi!');
  }
}
