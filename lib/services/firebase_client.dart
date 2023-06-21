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
    'type': DataType.grid.name,
    'column': 2,
    'data': [],
  };

  Future saveData({required Map<String, dynamic> data, required String collectionPath, String? documentName}) async {
    if (documentName != null) {
      await _firestore.collection(collectionPath).doc(documentName).set(data);
    } else {
      await _firestore.collection(collectionPath).add(data);
    }
    // await _firestore.collection('pages').add(pageModel.toJson());
    log('Veri Kaydedildi!');
  }

  Future deleteData({required String collectionPath, required String documentName}) async {
    await _firestore.collection(collectionPath).doc(documentName).delete();
    log('Veri Silindi!');
  }

  Future<Map<String, dynamic>> getData({required String collectionPath, required String documentName}) async {
    var result = await _firestore.collection(collectionPath).doc(documentName).get();
    log(result.toString());
    return result.data() ?? {};
  }

  Future<List<PageModel>> getPages() async {
    var result = await _firestore.collection('pages').orderBy('orderNumber').get();
    log(result.toString());
    List<PageModel> pages = result.docs.map((e) => PageModel.fromMap(e.data(), e.id)).toList();
    return pages;
  }
}
