import 'package:bussiness_alert_app/common/functions.dart';
import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/models/sender.dart';
import 'package:bussiness_alert_app/providers/user.dart';
import 'package:bussiness_alert_app/services/sender.dart';
import 'package:bussiness_alert_app/widgets/custom_lg_button.dart';
import 'package:bussiness_alert_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ReceptionScreen extends StatefulWidget {
  final UserProvider userProvider;

  const ReceptionScreen({
    required this.userProvider,
    super.key,
  });

  @override
  State<ReceptionScreen> createState() => _ReceptionScreenState();
}

class _ReceptionScreenState extends State<ReceptionScreen> {
  SenderService senderService = SenderService();
  SenderModel? sender;
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('受信設定'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
              : Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: kGreyColor)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '発信者名',
                              style: TextStyle(
                                color: kGreyColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '島津病院',
                              style: TextStyle(
                                color: kBlackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              sender = null;
                            });
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                ),
          const SizedBox(height: 16),
          sender == null
              ? CustomLgButton(
                  label: '上記の番号を確認する',
                  labelColor: kWhiteColor,
                  backgroundColor: kBlueColor,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
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
              : CustomLgButton(
                  label: '上記の発信者を登録する',
                  labelColor: kWhiteColor,
                  backgroundColor: kBlueColor,
                  onPressed: () async {
                    String? error =
                        await widget.userProvider.insertSender(sender);
                    if (error != null) {
                      if (!mounted) return;
                      showMessage(context, error, false);
                      return;
                    }
                    widget.userProvider.clearController();
                    widget.userProvider.reloadUser();
                    if (!mounted) return;
                    Navigator.pop(context);
                  },
                ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
