import 'package:bussiness_alert_app/common/functions.dart';
import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/screens/login.dart';
import 'package:bussiness_alert_app/screens/reception.dart';
import 'package:bussiness_alert_app/widgets/link_text.dart';
import 'package:bussiness_alert_app/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SettingsListTile(
              iconData: Icons.person,
              label: 'お名前変更',
              onTap: () {},
            ),
            SettingsListTile(
              iconData: Icons.email,
              label: 'メールアドレス変更',
              onTap: () {},
            ),
            SettingsListTile(
              iconData: Icons.password,
              label: 'パスワード変更',
              onTap: () {},
            ),
            SettingsListTile(
              iconData: Icons.hearing,
              label: '受信設定',
              onTap: () => pushScreen(context, const ReceptionScreen()),
            ),
            SettingsListTile(
              iconData: Icons.notifications,
              label: '通知設定',
              onTap: () {},
            ),
            const SizedBox(height: 24),
            LinkText(
              label: 'ログアウト',
              labelColor: kRedColor,
              onTap: () => pushReplacementScreen(
                context,
                const LoginScreen(),
              ),
            ),
            const SizedBox(height: 24),
            LinkText(
              label: 'ユーザーアカウントを削除',
              labelColor: kRedColor,
              onTap: () => pushReplacementScreen(
                context,
                const LoginScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
