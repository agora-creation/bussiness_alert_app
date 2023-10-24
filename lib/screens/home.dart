import 'package:bussiness_alert_app/common/functions.dart';
import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/models/user_notice.dart';
import 'package:bussiness_alert_app/providers/user.dart';
import 'package:bussiness_alert_app/screens/notice_detail.dart';
import 'package:bussiness_alert_app/screens/sender.dart';
import 'package:bussiness_alert_app/screens/settings.dart';
import 'package:bussiness_alert_app/services/user_notice.dart';
import 'package:bussiness_alert_app/widgets/notice_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserNoticeService userNoticeService = UserNoticeService();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    userProvider.user?.name ?? '',
                    style: const TextStyle(
                      color: kBlackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => showBottomUpScreen(
                          context,
                          const SenderScreen(),
                        ),
                        child: const Icon(
                          Icons.notification_add,
                          color: kBlackColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => showBottomUpScreen(
                          context,
                          const SettingsScreen(),
                        ),
                        child: const Icon(
                          Icons.more_vert,
                          color: kBlackColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: userNoticeService.streamList(userProvider.user?.id),
                builder: (context, snapshot) {
                  List<UserNoticeModel> notices = [];
                  if (snapshot.hasData) {
                    for (DocumentSnapshot<Map<String, dynamic>> doc
                        in snapshot.data!.docs) {
                      notices.add(UserNoticeModel.fromSnapshot(doc));
                    }
                  }
                  if (notices.isEmpty) {
                    return const Center(
                      child: Text(
                        'お知らせはありません',
                        style: TextStyle(color: kBlackColor),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: notices.length,
                    itemBuilder: (context, index) {
                      return NoticeList(
                        notice: notices[index],
                        onTap: () => showBottomUpScreen(
                          context,
                          NoticeDetailScreen(notice: notices[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
