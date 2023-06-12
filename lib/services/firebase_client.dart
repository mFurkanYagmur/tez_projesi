import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum PageType {
    grid,
    album,
    text,
}

class FirebaseClient {
    static FirebaseFirestore firestore = FirebaseFirestore.instance;

    Map standartPageData = {
        'order_number': 1,
        'title_front':'Ne Yapacağız?',
        'title_back': '150 Günlük Plan',
        'description': 'Seçildiğimiz takdirde görevi devraldığımız günden itibaren ilk 150 gün içerisinde yürürlüğe koyacağımız değişiklikler.',
        'type': PageType.grid.name,
        'data': {
            'column': 2,
            'data': [],
        },
    };

    static Future savePage() async {
        await firestore.collection('pages').add({
            'order_number': 1,
            'title_front':'Ne Yapacağız?',
            'title_back': '150 Günlük Plan',
            'description': 'Seçildiğimiz takdirde görevi devraldığımız günden itibaren ilk 150 gün içerisinde yürürlüğe koyacağımız değişiklikler.',
            'type': PageType.grid.name,
            'data': {
                'column': 2,
                'data': [
                    {
                        'icon_name': 'directions_railway',
                        'title': 'Öğrencilere Ücretsiz Ulaşım',
                        'content': 'Tüm düzeylerde okuyan öğrencilere şehir içi ulaşım ücretsiz olacak.',
                    },
                    {
                        'icon_name': 'work',
                        'title': '100.000 Yeni İstihdam',
                        'content': 'Kamu kurumları başta olmak üzere birçok alanda devlet ve özel sektör firmalasında 100.000\'den fazla yeni istihdam sağlanacak.',
                    },
                    {
                        'icon_name': 'design_services',
                        'title': 'Öğrencilere Materyal Desteği',
                        'content': 'Lisans ve Lisansüstü eğitim öğrencilerine okudukları bölümle ilgili ilk materyal satın alımında devlet desteği sağlanacak.',
                    },
                    {
                        'icon_name': 'price_check',
                        'title': 'Tarım Ürünleri Fiyat Dengelemesi',
                        'content': 'Direkt çiftçiden alınan ürünler Tarım Kredi Kooperatifleri mağazalarında süre sınırı olmaksızın uygun fiyatla satılacak.',
                    },
                    {
                        'icon_name': 'airplane_ticket',
                        'title': 'Gençlere Yurtdışı Gezi Desteği',
                        'content': '25 yaşın altındaki gençlere gezi amaçlı yurt dışı seyehatlerinde devlet desteği sağlanacak.',
                    },
                    {
                        'icon_name': 'developer_board',
                        'title': 'Bakanlıklara Ar-Ge Birimi',
                        'content': 'Tüm bakanlıklar altında Ar-Ge (Araştırma-Geliştirme) birimi kurulacak. Ve faaliyetleri titizlikle denetlenecek',
                    },
                ],
            },
        }).catchError((e) {
            debugPrint(e);
        });
        log('Sayfa Kaydedildi!');
    }
}