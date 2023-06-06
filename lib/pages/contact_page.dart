import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/constants.dart';
import 'package:mv_adayi_web_site/widget/page_title.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: kLigthGreyBGColor,
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
      child: Column(
        children: [
          const PageTitle(titleBack: 'Öneri & Şikayet', titleFront: 'İletişim'),
          SizedBox(
            width: size.width * 0.75,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Ad Soyad',
                        ),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(width: kVerticalPadding / 2),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'E-Posta',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kVerticalPadding / 2),
                TextFormField(
                  maxLines: 5,
                  decoration:
                      const InputDecoration(labelText: 'Mesajınız', hintText: 'Öneri ve şikayetlerinizi buraya yazınız.'),
                ),
                const SizedBox(
                  height: kVerticalPadding / 2,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: kVerticalPadding / 3, horizontal: kHorizontalPadding / 2),
                    textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                  ),
                  onPressed: () {},
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text('Mesajı Gönder'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
