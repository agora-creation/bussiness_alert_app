import 'package:bussiness_alert_app/common/functions.dart';
import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/screens/home.dart';
import 'package:bussiness_alert_app/screens/register.dart';
import 'package:bussiness_alert_app/widgets/custom_lg_button.dart';
import 'package:bussiness_alert_app/widgets/custom_text_form_field.dart';
import 'package:bussiness_alert_app/widgets/link_text.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'B-ALERT',
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  Text(
                    '一斉通知アプリ - 受信者用',
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('登録済みの方はログインしてください'),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: TextEditingController(),
                    textInputType: TextInputType.emailAddress,
                    maxLines: 1,
                    label: 'メールアドレス',
                    color: kBlackColor,
                    prefix: Icons.email,
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: TextEditingController(),
                    obscureText: true,
                    textInputType: TextInputType.visiblePassword,
                    maxLines: 1,
                    label: 'パスワード',
                    color: kBlackColor,
                    prefix: Icons.password,
                  ),
                  const SizedBox(height: 8),
                  CustomLgButton(
                    label: 'ログイン',
                    labelColor: kBlackColor,
                    backgroundColor: kWhiteColor,
                    onPressed: () => pushReplacementScreen(
                      context,
                      const HomeScreen(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  LinkText(
                    label: 'ユーザー登録はコチラから',
                    labelColor: kBlackColor,
                    onTap: () => pushScreen(
                      context,
                      const RegisterScreen(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
