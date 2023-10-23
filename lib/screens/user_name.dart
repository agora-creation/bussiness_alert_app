import 'package:bussiness_alert_app/common/functions.dart';
import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/providers/user.dart';
import 'package:bussiness_alert_app/widgets/custom_lg_button.dart';
import 'package:bussiness_alert_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class UserNameScreen extends StatefulWidget {
  final UserProvider userProvider;

  const UserNameScreen({
    required this.userProvider,
    super.key,
  });

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  @override
  void initState() {
    super.initState();
    widget.userProvider.nameController.text =
        widget.userProvider.user?.name ?? '';
  }

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
        title: const Text('お名前変更'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          CustomTextFormField(
            controller: widget.userProvider.nameController,
            textInputType: TextInputType.name,
            maxLines: 1,
            label: 'お名前',
            color: kBlackColor,
            prefix: Icons.person,
          ),
          const SizedBox(height: 16),
          CustomLgButton(
            label: '変更内容を保存',
            labelColor: kWhiteColor,
            backgroundColor: kBlueColor,
            onPressed: () async {
              String? error = await widget.userProvider.updateUserName();
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
