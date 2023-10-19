import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/providers/user.dart';
import 'package:bussiness_alert_app/widgets/custom_lg_button.dart';
import 'package:bussiness_alert_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ReceptionScreen extends StatefulWidget {
  final UserProvider userProvider;

  const ReceptionScreen({
    required this.userProvider,
    super.key,
  });

  @override
  State<ReceptionScreen> createState() => _ReceptionScreenState();
}

class _ReceptionScreenState extends State<ReceptionScreen> {
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
        title: const Text('受信設定'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          CustomTextFormField(
            controller: widget.userProvider.nameController,
            textInputType: TextInputType.name,
            maxLines: 1,
            label: 'お名前',
            color: kBaseColor,
            prefix: Icons.person,
          ),
          const SizedBox(height: 16),
          CustomLgButton(
            label: '変更内容を保存',
            labelColor: kWhiteColor,
            backgroundColor: kBaseColor,
            onPressed: () async {},
          ),
        ],
      ),
    );
  }
}
