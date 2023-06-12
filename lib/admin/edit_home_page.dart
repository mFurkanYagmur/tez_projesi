import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/constants.dart';
import 'package:mv_adayi_web_site/services/firebase_client.dart';

class EditHomePage extends StatefulWidget {
  const EditHomePage({Key? key}) : super(key: key);

  @override
  State<EditHomePage> createState() => _EditHomePageState();
}

class _EditHomePageState extends State<EditHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Başlık',
            ),
          ),
          const SizedBox(height: kVerticalPadding/3,),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'İçerik 1',
            ),
          ),
          const SizedBox(height: kVerticalPadding/3,),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'İçerik 2',
            ),
          ),
          const SizedBox(height: kVerticalPadding/3,),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'İçerik 3',
            ),
          ),
          const SizedBox(height: kVerticalPadding/3,),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'İçerik 4',
            ),
          ),
          ElevatedButton(onPressed: () {
            FirebaseClient.savePage();
          }, child: const Text('Sayfa ekle'),),
        ],
      ),
    );
  }
}
