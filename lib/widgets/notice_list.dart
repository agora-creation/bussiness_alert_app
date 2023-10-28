import 'package:bussiness_alert_app/common/functions.dart';
import 'package:bussiness_alert_app/common/style.dart';
import 'package:bussiness_alert_app/models/user_notice.dart';
import 'package:flutter/material.dart';

class NoticeList extends StatelessWidget {
  final UserNoticeModel notice;
  final Function()? onTap;

  const NoticeList({
    required this.notice,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notice.senderName,
                      style: const TextStyle(
                        color: kBlackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SourceHanSansJP-Bold',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    notice.isRead == false
                        ? const Icon(
                            Icons.circle,
                            color: kRedColor,
                            size: 10,
                          )
                        : Container(),
                  ],
                ),
              ),
              const Divider(height: 1, color: kBlackColor),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notice.title,
                      style: const TextStyle(
                        color: kBlackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SourceHanSansJP-Bold',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notice.content,
                      style: const TextStyle(
                        color: kBlackColor,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        notice.isAnswer
                            ? Text(
                                notice.answer == '' ? '回答が必要です' : '回答完了',
                                style: const TextStyle(
                                  color: kRedColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Container(),
                        Text(
                          dateText('yyyy/MM/dd HH:mm', notice.createdAt),
                          style: const TextStyle(
                            color: kGreyColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
