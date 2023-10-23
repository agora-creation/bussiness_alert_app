import 'package:bussiness_alert_app/common/functions.dart';
import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/providers/user.dart';
import 'package:bussiness_alert_app/screens/login.dart';
import 'package:bussiness_alert_app/screens/reception.dart';
import 'package:bussiness_alert_app/screens/user_email.dart';
import 'package:bussiness_alert_app/screens/user_name.dart';
import 'package:bussiness_alert_app/screens/user_password.dart';
import 'package:bussiness_alert_app/widgets/link_text.dart';
import 'package:bussiness_alert_app/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        title: const Text('各種設定'),
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
              onTap: () => pushScreen(
                context,
                UserNameScreen(userProvider: userProvider),
              ),
            ),
            SettingsListTile(
              iconData: Icons.email,
              label: 'メールアドレス変更',
              onTap: () => pushScreen(
                context,
                UserEmailScreen(userProvider: userProvider),
              ),
            ),
            SettingsListTile(
              iconData: Icons.password,
              label: 'パスワード変更',
              onTap: () => pushScreen(
                context,
                UserPasswordScreen(userProvider: userProvider),
              ),
            ),
            SettingsListTile(
              iconData: Icons.hearing,
              label: '受信設定',
              onTap: () => pushScreen(
                context,
                ReceptionScreen(userProvider: userProvider),
              ),
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
              onTap: () async {
                await userProvider.signOut();
                userProvider.clearController();
                if (!mounted) return;
                pushReplacementScreen(context, const LoginScreen());
              },
            ),
            const SizedBox(height: 24),
            LinkText(
              label: 'ユーザーアカウントを削除',
              labelColor: kRedColor,
              onTap: () async {
                await userProvider.delete();
                userProvider.clearController();
                if (!mounted) return;
                pushReplacementScreen(context, const LoginScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
