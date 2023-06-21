import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mv_adayi_web_site/helper/ui_helper.dart';
import 'package:mv_adayi_web_site/util/constants.dart';
import 'package:mv_adayi_web_site/util/util.dart';
import 'package:mv_adayi_web_site/widget/page_title.dart';
import 'package:provider/provider.dart';

import '../util/validators.dart';
import '../viewmodels/data_view_model.dart';
import '../widget/text_field_counter.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String nameSurName = '';
  String email = '';
  String message = '';

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Container(
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
                          initialValue: nameSurName,
                          maxLength: 40,
                          buildCounter: buildTextFieldCounter,
                          validator: Validators.requiredTextValidator,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            nameSurName = value;
                          },
                        ),
                      ),
                      const SizedBox(width: kVerticalPadding / 2),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'E-Posta',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          initialValue: email,
                          maxLength: 50,
                          buildCounter: buildTextFieldCounter,
                          validator: Validators.requiredTextValidator,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kVerticalPadding / 2),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Mesajınız',
                      hintText: 'Öneri ve şikayetlerinizi buraya yazınız.',
                    ),
                    initialValue: message,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    maxLength: 3000,
                    buildCounter: buildTextFieldCounter,
                    validator: Validators.requiredTextValidator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      message = value;
                    },
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _sendMessage();
                      }
                    },
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
      ),
    );
  }

  _sendMessage() async {
    try {
      await context.read<DataViewModel>().saveData(data: {
        'email': email,
        'nameSurName': nameSurName,
        'message': message,
      }, collectionPath: 'message');
      setState(() {
        nameSurName = '';
        email = '';
        message = '';
        _formKey.currentState!.reset();
      });
      UIHelper.showSnackBar(
          context: context, text: 'Mesajınızı aldık. En kısa sürede gereken işlemleri yürüteceğiz.', type: UIType.success);
    } catch (e) {
      log(e.toString(), error: e);
      Util.showErrorMessage(context);
    }
  }
}
