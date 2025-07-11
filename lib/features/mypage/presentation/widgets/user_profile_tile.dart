// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';

class UserInfoCard extends StatelessWidget {
  final String nickname;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;
  const UserInfoCard({
    super.key,
    required this.nickname,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: backgroundColor01, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nickname,
                style: AppTextStyle.bold20.copyWith(color: textBlack),
              ),
              SizedBox(height: 4),
              Text(email, style: AppTextStyle.bold14.copyWith(color: textGray)),
              SizedBox(height: 5),
              Text(
                phoneNumber,
                style: AppTextStyle.bold14.copyWith(color: textGray),
              ),
            ],
          ),
          Row(
            children: [
              CircleAvatar(radius: 30, backgroundColor: backgroundColor01),
              SizedBox(width: 5),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ],
      ),
    );
  }
}
