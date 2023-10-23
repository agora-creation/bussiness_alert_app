import 'package:bussiness_alert_app/common/style.dart';
import 'package:flutter/material.dart';

class CustomRadioListTile extends StatelessWidget {
  final String value;
  final String? groupValue;
  final Function(String?)? onChanged;

  const CustomRadioListTile({
    required this.value,
    this.groupValue,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kGreyColor)),
      ),
      child: RadioListTile(
        title: Text(value),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
