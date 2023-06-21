import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mv_adayi_web_site/helper/ui_helper.dart';
import 'package:mv_adayi_web_site/util/constants.dart';
import 'package:mv_adayi_web_site/util/util.dart';
import 'package:mv_adayi_web_site/viewmodels/data_view_model.dart';
import 'package:mv_adayi_web_site/widget/loading_widget.dart';
import 'package:provider/provider.dart';

class MessageManager extends StatelessWidget {
  const MessageManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataViewModel(),
        ),
      ],
      child: const _MessageManager(),
    );
  }
}

class _MessageManager extends StatefulWidget {
  const _MessageManager();

  @override
  State<_MessageManager> createState() => _MessageManagerState();
}

class _MessageManagerState extends State<_MessageManager> {
  DataViewModel? dataViewModel;

  List<Map<String, dynamic>>? messageList;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _loadMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    dataViewModel ??= context.read<DataViewModel>();
    if (messageList == null) {
      return const LoadingWidget();
    } else if (messageList!.isEmpty) {
      return Text('Henüz bir mesajınız yok.');
    } else {
      return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
        child: ListView.builder(
          // shrinkWrap: true,
          itemCount: messageList!.length,
          itemBuilder: (context, index) {
            return _buildItem(messageList![index], index);
          },
        ),
      );
    }
  }

  Widget _buildItem(Map<String, dynamic> data, int index) {
    bool read = bool.tryParse(data['read'].toString()) ?? false;
    return ListTile(
      onTap: () {
        showMessageDetail(data, index);
      },
      title: Text(data['nameSurName'] ?? ''),
      subtitle: Text(data['email'] ?? ''),
      leading: CircleAvatar(
        child: Text((index + 1).toString()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => _markAsRead(data: data, read: !read, index: index),
            icon: Icon(
              Icons.mark_email_read,
              color: read ? kPrimaryColor : Colors.grey,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          IconButton(
            onPressed: () => _delete(data: data),
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  showMessageDetail(Map<String, dynamic> data, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(data['nameSurName'] ?? ''),
          content: Text(data['message'] ?? ''),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  await _markAsRead(data: data, read: true, index: index);
                  Navigator.pop(context);
                },
                child: const Text('Okundu İşaretle')),
            TextButton(
                onPressed: () async {
                  await _delete(data: data);
                  Navigator.pop(context);
                },
                child: const Text('Sil')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kapat')),
          ],
        );
      },
    );
  }

  Future _markAsRead({required Map<String, dynamic> data, required bool read, required int index}) async {
    try {
      Map<String, dynamic> tempData = Map.of(data);
      tempData.remove('id');
      tempData['read'] = read;
      await dataViewModel!.saveData(data: tempData, collectionPath: 'message', documentName: data['id']);
      messageList![index] = {...data, 'read': read};
      // UIHelper.showSnackBar(context: context, text: 'Mesaj okundu olarak işaretlendi.', type: UIType.success);
      setState(() {});
    } catch (e) {
      log(e.toString(), error: e);
      Util.showErrorMessage(context);
    }
  }

  Future _delete({required Map<String, dynamic> data}) async {
    try {
      await dataViewModel!.deleteData(collectionPath: 'message', documentName: data['id']);
      messageList!.remove(data);
      UIHelper.showSnackBar(context: context, text: 'Mesaj silindi', type: UIType.success);
      setState(() {});
    } catch (e) {
      log(e.toString(), error: e);
      Util.showErrorMessage(context);
    }
  }

  Future _loadMessages() async {
    try {
      if (messageList != null) return messageList;
      messageList = await dataViewModel!.getDataList(collectionPath: 'message');
      setState(() {});
    } catch (e) {
      log(e.toString(), error: e);
      Util.showErrorMessage(context);
    }
    return messageList;
  }
}
