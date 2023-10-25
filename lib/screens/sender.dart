import 'package:bussiness_alert_app/common/functions.dart';
import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/models/sender.dart';
import 'package:bussiness_alert_app/models/user.dart';
import 'package:bussiness_alert_app/providers/user.dart';
import 'package:bussiness_alert_app/services/sender.dart';
import 'package:bussiness_alert_app/widgets/custom_sm_button.dart';
import 'package:bussiness_alert_app/widgets/custom_text_form_field.dart';
import 'package:bussiness_alert_app/widgets/sender_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SenderScreen extends StatefulWidget {
  const SenderScreen({super.key});

  @override
  State<SenderScreen> createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> {
  SenderService senderService = SenderService();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        title: const Text('受信設定'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: senderService.streamList(userProvider.user?.id),
        builder: (context, snapshot) {
          List<SenderModel> senders = [];
          if (snapshot.hasData) {
            for (DocumentSnapshot<Map<String, dynamic>> doc
                in snapshot.data!.docs) {
              senders.add(SenderModel.fromSnapshot(doc));
            }
          }
          print(senders);
          if (senders.isEmpty) {
            return const Center(
              child: Text(
                '受信先を追加してください',
                style: TextStyle(color: kBlackColor),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: senders.length,
            itemBuilder: (context, index) {
              return SenderList(
                sender: senders[index],
                removeLabel: '受信解除',
                removeOnPressed: () => showDialog(
                  context: context,
                  builder: (context) => RemoveDialog(
                    user: userProvider.user!,
                    sender: senders[index],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddDialog(user: userProvider.user!),
        ),
        label: const Text('受信先を追加'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class AddDialog extends StatefulWidget {
  final UserModel user;

  const AddDialog({
    required this.user,
    super.key,
  });

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  SenderService senderService = SenderService();
  SenderModel? sender;
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sender == null
              ? CustomTextFormField(
                  controller: numberController,
                  textInputType: TextInputType.number,
                  maxLines: 1,
                  label: '発信者番号',
                  color: kBlackColor,
                  prefix: Icons.numbers,
                )
              : SenderList(sender: sender!),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomSmButton(
                label: 'やめる',
                labelColor: kWhiteColor,
                backgroundColor: kGreyColor,
                onPressed: () => Navigator.pop(context),
              ),
              sender == null
                  ? CustomSmButton(
                      label: '検索する',
                      labelColor: kWhiteColor,
                      backgroundColor: kBlueColor,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        SenderModel? tmpSender =
                            await senderService.selectNumber(
                          numberController.text,
                        );
                        if (tmpSender == null) {
                          if (!mounted) return;
                          showMessage(context, '発信者が見つかりません', false);
                          return;
                        }
                        setState(() {
                          sender = tmpSender;
                        });
                      },
                    )
                  : CustomSmButton(
                      label: '追加する',
                      labelColor: kWhiteColor,
                      backgroundColor: kBlueColor,
                      onPressed: () async {
                        List<String> userIds = sender?.userIds ?? [];
                        if (!userIds.contains(widget.user.id)) {
                          userIds.add(widget.user.id);
                        }
                        senderService.update({
                          'id': sender?.id,
                          'userIds': userIds,
                        });
                        if (!mounted) return;
                        Navigator.pop(context);
                      },
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class RemoveDialog extends StatefulWidget {
  final UserModel user;
  final SenderModel sender;

  const RemoveDialog({
    required this.user,
    required this.sender,
    super.key,
  });

  @override
  State<RemoveDialog> createState() => _RemoveDialogState();
}

class _RemoveDialogState extends State<RemoveDialog> {
  SenderService senderService = SenderService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SenderList(sender: widget.sender),
          const SizedBox(height: 8),
          const Text(
            'この発信者からの受信を解除しますか？',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomSmButton(
                label: 'やめる',
                labelColor: kWhiteColor,
                backgroundColor: kGreyColor,
                onPressed: () => Navigator.pop(context),
              ),
              CustomSmButton(
                label: '解除する',
                labelColor: kWhiteColor,
                backgroundColor: kRedColor,
                onPressed: () async {
                  List<String> userIds = widget.sender.userIds;
                  if (userIds.contains(widget.user.id)) {
                    userIds.remove(widget.user.id);
                  }
                  senderService.update({
                    'id': widget.sender.id,
                    'userIds': userIds,
                  });
                  if (!mounted) return;
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
