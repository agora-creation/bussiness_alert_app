import 'package:bussiness_alert_app/common/functions.dart';
import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/models/sender.dart';
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
        stream: senderService.streamList(),
        builder: (context, snapshot) {
          List<SenderModel> senders = [];
          List<String> senderNumbers = userProvider.user?.senderNumbers ?? [];
          if (snapshot.hasData) {
            for (DocumentSnapshot<Map<String, dynamic>> doc
                in snapshot.data!.docs) {
              SenderModel sender = SenderModel.fromSnapshot(doc);
              if (senderNumbers.contains(sender.number)) {
                senders.add(sender);
              }
            }
          }
          if (senders.isEmpty) {
            return const Center(
              child: Text(
                '発信者を追加してください',
                style: TextStyle(color: kBlackColor),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: senders.length,
            itemBuilder: (context, index) {
              SenderModel sender = senders[index];
              return SenderList(
                sender: sender,
                removeLabel: '受信解除',
                removeOnPressed: () => showDialog(
                  context: context,
                  builder: (context) => RemoveDialog(
                    userProvider: userProvider,
                    sender: sender,
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
          builder: (context) => AddDialog(userProvider: userProvider),
        ),
        label: const Text('発信者を追加'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class AddDialog extends StatefulWidget {
  final UserProvider userProvider;

  const AddDialog({
    required this.userProvider,
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
                      label: '確認する',
                      labelColor: kWhiteColor,
                      backgroundColor: kBlueColor,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        List<String> senderNumbers =
                            widget.userProvider.user?.senderNumbers ?? [];
                        if (senderNumbers.contains(numberController.text)) {
                          if (!mounted) return;
                          showMessage(context, '既に追加済みの番号です', false);
                          return;
                        }
                        SenderModel? tmpSender = await senderService.select(
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
                        String? error =
                            await widget.userProvider.addSender(sender!);
                        if (error != null) {
                          if (!mounted) return;
                          showMessage(context, error, false);
                          return;
                        }
                        widget.userProvider.reloadUser();
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
  final UserProvider userProvider;
  final SenderModel sender;

  const RemoveDialog({
    required this.userProvider,
    required this.sender,
    super.key,
  });

  @override
  State<RemoveDialog> createState() => _RemoveDialogState();
}

class _RemoveDialogState extends State<RemoveDialog> {
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
                  String? error =
                      await widget.userProvider.removeSender(widget.sender);
                  if (error != null) {
                    if (!mounted) return;
                    showMessage(context, error, false);
                    return;
                  }
                  widget.userProvider.reloadUser();
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
