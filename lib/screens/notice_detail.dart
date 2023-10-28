import 'package:bussiness_alert_app/common/functions.dart';
import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/models/user_notice.dart';
import 'package:bussiness_alert_app/services/user_notice.dart';
import 'package:bussiness_alert_app/widgets/custom_lg_button.dart';
import 'package:bussiness_alert_app/widgets/custom_radio_list_tile.dart';
import 'package:flutter/material.dart';

class NoticeDetailScreen extends StatefulWidget {
  final UserNoticeModel notice;

  const NoticeDetailScreen({
    required this.notice,
    super.key,
  });

  @override
  State<NoticeDetailScreen> createState() => _NoticeDetailScreenState();
}

class _NoticeDetailScreenState extends State<NoticeDetailScreen> {
  UserNoticeService userNoticeService = UserNoticeService();
  String? answer;

  void _init() async {
    if (widget.notice.isRead == false) {
      userNoticeService.update({
        'id': widget.notice.id,
        'userId': widget.notice.userId,
        'isRead': true,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        title: Text(widget.notice.senderName),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.notice.title,
                style: const TextStyle(
                  color: kBlackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceHanSansJP-Bold',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.notice.content,
                style: const TextStyle(
                  color: kBlackColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  dateText('yyyy/MM/dd HH:mm', widget.notice.createdAt),
                  style: const TextStyle(
                    color: kGreyColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 4, color: kGreyColor),
          const SizedBox(height: 8),
          widget.notice.isAnswer
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.notice.answer == '' ? '回答してください' : '回答完了',
                      style: const TextStyle(
                        color: kRedColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SourceHanSansJP-Bold',
                      ),
                    ),
                    widget.notice.answer == ''
                        ? Column(
                            children: widget.notice.choices.map((choice) {
                              return CustomRadioListTile(
                                value: choice,
                                groupValue: answer,
                                onChanged: (value) {
                                  setState(() {
                                    answer = value;
                                  });
                                },
                              );
                            }).toList(),
                          )
                        : ListTile(title: Text(widget.notice.answer)),
                    const SizedBox(height: 16),
                    widget.notice.answer == ''
                        ? answer == null
                            ? const CustomLgButton(
                                label: '回答を送信する',
                                labelColor: kWhiteColor,
                                backgroundColor: kGreyColor,
                              )
                            : CustomLgButton(
                                label: '回答を送信する',
                                labelColor: kWhiteColor,
                                backgroundColor: kBlueColor,
                                onPressed: () async {
                                  userNoticeService.update({
                                    'id': widget.notice.id,
                                    'userId': widget.notice.userId,
                                    'answer': answer,
                                  });
                                  if (!mounted) return;
                                  showMessage(context, '回答を送信しました', true);
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                              )
                        : Container(),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
