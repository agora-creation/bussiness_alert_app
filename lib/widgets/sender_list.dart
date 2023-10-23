import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/models/sender.dart';
import 'package:bussiness_alert_app/widgets/custom_sm_button.dart';
import 'package:flutter/material.dart';

class SenderList extends StatelessWidget {
  final SenderModel sender;
  final String? removeLabel;
  final Function()? removeOnPressed;

  const SenderList({
    required this.sender,
    this.removeLabel,
    this.removeOnPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kGreyColor)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '発信者番号 : ${sender.number}',
                  style: const TextStyle(
                    color: kGreyColor,
                    fontSize: 14,
                  ),
                ),
                Text(
                  sender.name,
                  style: const TextStyle(
                    color: kBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            removeLabel != null
                ? CustomSmButton(
                    label: removeLabel ?? '',
                    labelColor: kWhiteColor,
                    backgroundColor: kRedColor,
                    onPressed: removeOnPressed,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
