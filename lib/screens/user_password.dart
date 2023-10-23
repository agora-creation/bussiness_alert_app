import 'package:bussiness_alert_app/common/functions.dart';
import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/providers/user.dart';
import 'package:bussiness_alert_app/widgets/custom_lg_button.dart';
import 'package:bussiness_alert_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class UserPasswordScreen extends StatefulWidget {
  final UserProvider userProvider;

  const UserPasswordScreen({
    required this.userProvider,
    super.key,
  });

  @override
  State<UserPasswordScreen> createState() => _UserPasswordScreenState();
}

class _UserPasswordScreenState extends State<UserPasswordScreen> {
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
        title: const Text('パスワード変更'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          CustomTextFormField(
            controller: widget.userProvider.passwordController,
            obscureText: true,
            textInputType: TextInputType.visiblePassword,
            maxLines: 1,
            label: '新しいパスワード',
            color: kBlackColor,
            prefix: Icons.password,
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: widget.userProvider.rePasswordController,
            obscureText: true,
            textInputType: TextInputType.visiblePassword,
            maxLines: 1,
            label: '新しいパスワードの確認',
            color: kBlackColor,
            prefix: Icons.password,
          ),
          const SizedBox(height: 16),
          CustomLgButton(
            label: '変更内容を保存',
            labelColor: kWhiteColor,
            backgroundColor: kBlueColor,
            onPressed: () async {
              String? error = await widget.userProvider.updateUserPassword();
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
        ],
      ),
    );
  }
}
