import 'package:bussiness_alert_app/common/functions.dart';
import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/screens/login.dart';
import 'package:bussiness_alert_app/widgets/custom_lg_button.dart';
import 'package:bussiness_alert_app/widgets/custom_text_form_field.dart';
import 'package:bussiness_alert_app/widgets/link_text.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  const Text('初めてご利用の方はユーザー登録してください'),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: TextEditingController(),
                    textInputType: TextInputType.name,
                    maxLines: 1,
                    label: 'お名前',
                    color: kBlackColor,
                    prefix: Icons.person,
                  ),
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
                  CustomTextFormField(
                    controller: TextEditingController(),
                    obscureText: true,
                    textInputType: TextInputType.visiblePassword,
                    maxLines: 1,
                    label: 'パスワードの確認',
                    color: kBlackColor,
                    prefix: Icons.password,
                  ),
                  const SizedBox(height: 8),
                  CustomLgButton(
                    label: 'ユーザー登録する',
                    labelColor: kBlackColor,
                    backgroundColor: kWhiteColor,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 24),
                  LinkText(
                    label: 'ログインはコチラから',
                    labelColor: kBlackColor,
                    onTap: () => pushScreen(
                      context,
                      const LoginScreen(),
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
