import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mv_adayi_web_site/util/constants.dart';

import '../widget/page_title.dart';

/// 150 günlük icraatlar
class IcraatPage extends StatelessWidget {
  IcraatPage({Key? key}) : super(key: key);

  final List<Icraat> icraatList = [
    Icraat(
        icon: Icons.directions_railway,
        title: 'Öğrencilere Ücretsiz Ulaşım',
        description: 'Tüm düzeylerde okuyan öğrencilere şehir içi ulaşım ücretsiz olacak.'),
    Icraat(
        icon: Icons.work,
        title: '100.000 Yeni İstihdam',
        description:
            'Kamu kurumları başta olmak üzere birçok alanda devlet ve özel sektör firmalasında 100.000\'den fazla yeni istihdam sağlanacak.'),
    Icraat(
        icon: Icons.design_services,
        title: 'Öğrencilere Materyal Desteği',
        description:
            'Lisans ve Lisansüstü eğitim öğrencilerine okudukları bölümle ilgili ilk materyal satın alımında devlet desteği sağlanacak.'),
    Icraat(
        icon: Icons.price_check,
        title: 'Tarım Ürünleri Fiyat Dengelemesi',
        description:
            'Direkt çiftçiden alınan ürünler Tarım Kredi Kooperatifleri mağazalarında süre sınırı olmaksızın uygun fiyatla satılacak.'),
    Icraat(
        icon: Icons.airplane_ticket,
        title: 'Gençlere Yurtdışı Gezi Desteği',
        description: '25 yaşın altındaki gençlere gezi amaçlı yurt dışı seyehatlerinde devlet desteği sağlanacak.'),
    Icraat(
        icon: Icons.developer_board,
        title: 'Bakanlıklara Ar-Ge Birimi',
        description:
            'Tüm bakanlıklar altında Ar-Ge (Araştırma-Geliştirme) birimi kurulacak. Ve faaliyetleri titizlikle denetlenecek'),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      constraints: BoxConstraints(minHeight: size.height),
      color: kLigthGreyBGColor,
      padding: const EdgeInsets.symmetric(
        vertical: kVerticalPadding,
        horizontal: kHorizontalPadding,
      ),
      child: Column(
        children: [
          const PageTitle(
            titleBack: '150 Günlük Plan',
            titleFront: 'Ne Yapacağız?',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: AlignedGridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              itemCount: icraatList.length,
              mainAxisSpacing: kVerticalPadding,
              crossAxisSpacing: kHorizontalPadding,
              itemBuilder: (context, index) {
                return _buildItem(icraat: icraatList[index], context: context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({required Icraat icraat, required BuildContext context}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(kVerticalPadding / 3),
            child: Icon(
              icraat.icon,
              color: kPrimaryColor,
              size: 30,
            ),
          ),
        ),
        const SizedBox(width: kHorizontalPadding / 3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                icraat.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                icraat.description,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextLightColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Icraat {
  IconData icon;
  String title;
  String description;

  Icraat({required this.icon, required this.title, required this.description});
}
