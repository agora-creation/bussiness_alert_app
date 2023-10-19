import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/widgets/custom_lg_button.dart';
import 'package:flutter/material.dart';

class NoticeDetailScreen extends StatefulWidget {
  const NoticeDetailScreen({super.key});

  @override
  State<NoticeDetailScreen> createState() => _NoticeDetailScreenState();
}

class _NoticeDetailScreenState extends State<NoticeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        title: const Text('島津病院'),
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '2023/10/19 16:22',
                style: TextStyle(
                  color: kGreyColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'お知らせタイトル',
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceHanSansJP-Bold',
                ),
              ),
              Text(
                'お知らせ内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容',
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '回答してください',
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: 14,
                ),
              ),
              Column(
                children: [
                  RadioListTile(
                    title: const Text('参加します'),
                    value: '参加します',
                    groupValue: '参加します',
                    onChanged: (value) {},
                  ),
                  RadioListTile(
                    title: const Text('参加しません'),
                    value: '参加しません',
                    groupValue: '参加します',
                    onChanged: (value) {},
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CustomLgButton(
                label: '回答を送信する',
                labelColor: kWhiteColor,
                backgroundColor: kBlueColor,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
