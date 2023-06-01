import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/constants.dart';
import 'package:mv_adayi_web_site/widget/custom_solid_button.dart';
import 'package:mv_adayi_web_site/widget/page_title.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final String aboutContent =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam tempor nunc eget interdum luctus. Nullam eu massa ipsum. Ut vehicula odio nec gravida iaculis. Phasellus ut scelerisque lectus, in ultrices magna. Nam laoreet venenatis mattis. Aenean eu ornare magna. Aenean dapibus, sem sed pellentesque tristique, ex lacus tincidunt massa, sit amet pulvinar massa enim sed tortor. In facilisis ante ligula, eleifend lacinia augue convallis id. Vivamus non dapibus justo. Duis vulputate arcu velit, a aliquet eros luctus et.\n\n'
      'Quisque pulvinar nibh mi, id semper orci semper in. Donec feugiat malesuada sem, ac facilisis ipsum eleifend in. Phasellus mattis mollis mauris, sit amet tempor est mollis vitae. Ut rutrum fringilla suscipit. Donec accumsan, lacus ac varius ornare, purus nunc maximus libero, vel consequat ligula turpis vitae lorem. Integer vitae tincidunt nisl. Donec ut massa ultricies, feugiat velit at, lacinia orci. Etiam fermentum vulputate nulla, a laoreet risus vulputate sed.';

  late List<SummaryData> summaryDataList;

  //  {sayi: aciklama}
  Map<String, String> vaatler = {
    '100.000+': 'Yeni İstihdam',
    '20+': 'Yeni Kütüphane',
    '5.000.000+': 'Öğrenciye Ulaşım Ücretsiz',
    '23': 'Avrupa Ülkesine Vizesiz Giriş',
  };

  @override
  void initState() {
    super.initState();
    summaryDataList = [
      SummaryData(title: 'Ad', content: 'Muhammed Furkan Yağmur'),
      SummaryData(title: 'E-Posta', content: 'yagmurfurkan425@gmail.com', onPressed: _onEmailPressed),
      SummaryData(title: 'Yaş', content: '21'),
      SummaryData(title: 'Memleket', content: 'Adıyaman/Kahta'),
    ];
  }

  void _onEmailPressed() {
    //  TODO: send email
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
      child: Column(
        children: [
          const PageTitle(titleBack: 'Hakkımda', titleFront: 'Beni Tanıyın'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPharagraphAndSummary(context),
                const SizedBox(
                  height: kVerticalPadding,
                ),
                _buildVaatler(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVaatler() {
    var list = List.generate(vaatler.length, (index) => _buildVaatlerItem(index: index), growable: true);
    // for (int i=0; i<list.length-1; i++) list.insert(i, Container(width: 0.1, height: 100, color: Colors.red,));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: list,
      ),
    );
  }

  Widget _buildVaatlerItem({required int index}) {
    var vaat = vaatler.entries.toList()[index];
    return Row(
      children: [
        Column(
          children: [
            Text(
              vaat.key,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    // fontWeight: FontWeight.bold,
                    color: kTextLightColor,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              vaat.value,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        // if (index != vaatler.length-1) Container(width: 0.1, height: 100, color: Colors.red,),
      ],
    );
  }

  Flex _buildPharagraphAndSummary(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 2,
          child: _buildAboutPharagrapf(context),
        ),
        const SizedBox(width: kHorizontalPadding),
        Flexible(
          flex: 1,
          child: _buildSummaryData(context),
        ),
      ],
    );
  }

  Widget _buildSummaryData(BuildContext context) {
    /*return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(summaryData.length, (index) => _buildSummaryItem(context: context, index: index)),
    );*/
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              SummaryData data = summaryDataList[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text.rich(TextSpan(
                  children: [
                    TextSpan(
                      text: '${data.title}:  ',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: data.content,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: data.onPressed != null ? kPrimaryColor : kTextLightColor,
                          ),
                    ),
                  ],
                )),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: summaryDataList.length),
        const SizedBox(height: kVerticalPadding / 2),
        CustomSolidButton(text: 'Özgeçmiş Görüntüle', onPressed: () {}),
      ],
    );
  }

  Column _buildAboutPharagrapf(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: 'Muhammed Furkan Yağmur'),
              TextSpan(
                text: '\nKimdir?',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
        ),
        const SizedBox(
          height: kVerticalPadding,
        ),
        Text(
          aboutContent,
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

class SummaryData {
  String title;
  String content;
  Function()? onPressed;

  SummaryData({required this.title, required this.content, this.onPressed});
}
