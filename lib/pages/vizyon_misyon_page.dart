import 'package:flutter/material.dart';
import '../constants.dart';

class VizyonMisyonPage extends StatefulWidget {
  const VizyonMisyonPage({Key? key}) : super(key: key);

  @override
  State<VizyonMisyonPage> createState() => _VizyonMisyonPageState();
}

class _VizyonMisyonPageState extends State<VizyonMisyonPage> {
  final String vizyon =
  'Duis at risus augue. Aenean at nisl nec ligula volutpat posuere. Fusce imperdiet vel ex at interdum. Fusce eget pharetra nibh. Pellentesque non posuere quam, eu fringilla ligula. Fusce eget arcu mauris. Quisque sit amet euismod tortor, ullamcorper pellentesque odio. Sed sit amet scelerisque justo. Nullam eget est quam. Vivamus nibh metus, commodo quis ligula vel, ultricies maximus risus. Suspendisse hendrerit nulla nec justo rhoncus, vulputate rutrum augue sagittis. Suspendisse fringilla urna eget mauris fringilla, sit amet faucibus lectus tempor. Aenean gravida varius ipsum eget scelerisque. Sed et nulla eu arcu volutpat pellentesque vel sed felis. Vestibulum condimentum, orci eu accumsan cursus, sapien lacus convallis diam, eu dapibus enim tortor in velit.\n\n'
  'In ex augue, accumsan vel aliquam maximus, ullamcorper quis mi. Etiam scelerisque cursus orci, a rhoncus dolor luctus ac. Sed sodales accumsan quam, vel blandit massa mattis eget. Mauris consequat vulputate odio, ut gravida purus euismod a. Nam ultrices nulla a dolor pretium, ut faucibus odio elementum. Sed sed laoreet velit. Ut id eros eros. Aliquam fermentum in leo nec interdum. Quisque vel arcu in mauris consequat imperdiet. Phasellus dui enim, ultricies eu bibendum id, maximus at arcu. Sed quis metus turpis. Nulla pretium lobortis sapien. Quisque ullamcorper diam in quam finibus cursus. Suspendisse venenatis magna a felis pharetra, viverra pulvinar enim viverra. Duis vel odio id arcu pharetra auctor sit amet at nisl. Fusce maximus ipsum non fringilla blandit. Morbi in dolor ut nulla tempor fermentum. Cras.';

  final String misyon =
      'Vivamus dapibus, mi quis hendrerit fringilla, nisl sem vestibulum mi, eget consequat quam ipsum ac lectus. Etiam rhoncus sed orci non rhoncus. Vivamus pretium, purus at ornare aliquam, velit dui molestie ipsum, vitae tempus mi dui eget neque. Integer ac est quis ligula maximus ornare. Vivamus sed erat at lectus ultricies rutrum ornare vel dolor. Etiam mattis et lacus vitae eleifend. Morbi eu nibh ut est scelerisque aliquet eget in dui. Aliquam dignissim semper erat, in elementum ligula. Curabitur at eros massa. Quisque viverra luctus ex, a molestie elit. Nunc vitae pharetra arcu, vitae varius diam.\n\n'
      'Etiam scelerisque malesuada ligula, et convallis nunc euismod vel. Duis auctor vel odio a pellentesque. Maecenas vitae quam ut dui maximus malesuada. Vestibulum dictum ipsum ut felis consectetur tincidunt ut non tortor. In quis ornare mauris. Phasellus semper tristique ex, id egestas justo venenatis a. Donec sit amet metus luctus, semper nisl eget, vulputate metus. Donec nec dui nec augue vulputate consectetur gravida non enim. Fusce sodales dui nunc, eget scelerisque enim lobortis non. Fusce id massa nibh. Fusce facilisis odio sit amet consectetur sollicitudin. Suspendisse ut dolor at ipsum pellentesque accumsan. Vivamus congue faucibus consectetur. Quisque blandit est vel erat rutrum scelerisque. Donec.';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLigthGreyBGColor,
      padding: const EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kVerticalPadding, horizontal: kHorizontalPadding),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildAboutPharagrapf(title: 'Vizyon', content: vizyon, context: context),
                ),
                const SizedBox(width: kHorizontalPadding),
                Expanded(
                  child: _buildAboutPharagrapf(title: 'Misyon', content: misyon, context: context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildAboutPharagrapf({required String title, required String content, required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
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
          content,
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}