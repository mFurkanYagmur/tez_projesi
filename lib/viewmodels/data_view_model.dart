import 'package:flutter/material.dart';

import '../services/firebase_client.dart';

class DataViewModel extends ChangeNotifier {
  Future saveData({required Map<String, dynamic> data, required String collectionPath, String? documentName}) async {
    return await FirebaseClient.instance.saveData(data: data, collectionPath: collectionPath, documentName: documentName);
  }
}