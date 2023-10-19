import 'package:bussiness_alert_app/common/functions.dart';
import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/providers/user.dart';
import 'package:bussiness_alert_app/screens/notice_detail.dart';
import 'package:bussiness_alert_app/screens/settings.dart';
import 'package:bussiness_alert_app/widgets/notice_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: 100,
                itemBuilder: (context, index) {
                  return NoticeList(
                    onTap: () => showBottomUpScreen(
                      context,
                      const NoticeDetailScreen(),
                    ),
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
