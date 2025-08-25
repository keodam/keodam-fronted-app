import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/data/model/blocked_user.dart';
import 'package:keodam/features/mypage/data/model/blocked_user_table.dart';
import 'package:keodam/features/mypage/domain/util/show_two_button_dialog.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_divider.dart';

class ManageBlockUsersScreen extends ConsumerWidget {
  const ManageBlockUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppBar(title: '차단내역 관리'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: SingleChildScrollView(
          child: Center(child: Column(children: [BlockHistoryList()])),
        ),
      ),
    );
  }
}

class BlockHistoryList extends ConsumerWidget {
  const BlockHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      itemCount: blockedUserTable.length,
      itemBuilder: (context, index) {
        final blockedUser = blockedUserTable[index];
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            final result = await showTwoButtonDialog(
              context,
              title:
                  '${blockedUser.nickname}${blockedUser.role == Role.mentor ? ' 멘토' : ' 멘티'}님을 \n차단 해제하시겠습니까?',
              confirmText: '해제',
              cancelText: '취소',
            );
            if (result == true) {
              //TODO: 해제 (차단리스트 해당 프로필 삭제&히스토리백)
            } else if (result == false) {
              //TODO: 취소 (히스토리백)
            }
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(blockedUser.image),
                        ),
                        const SizedBox(width: 7),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  blockedUser.nickname,
                                  style: AppTextStyle.bold14.copyWith(
                                    color: textBlack,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  blockedUser.role == Role.mentor ? '멘토' : '멘티',
                                  style: AppTextStyle.bold14.copyWith(
                                    color: textBlack,
                                  ),
                                ),
                                if (blockedUser.isCertified) ...[
                                  const SizedBox(width: 5),
                                  Image.asset(
                                    'assets/images/mypage/icon_certified_badge.png',
                                    width: 18,
                                    height: 18,
                                  ),
                                ],
                                if (blockedUser.role == Role.mentor &&
                                    blockedUser.manner != null) ...[
                                  const SizedBox(width: 5),
                                  Text(
                                    '${blockedUser.manner!}℃',
                                    style: AppTextStyle.regular12.copyWith(
                                      color: textGray,
                                    ),
                                  ),
                                ] else if (blockedUser.role == Role.mentee &&
                                    blockedUser.level != null) ...[
                                  const SizedBox(width: 5),
                                  Text(
                                    blockedUser.level!,
                                    style: AppTextStyle.regular12.copyWith(
                                      color: textGray,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              blockedUser.role == Role.mentor
                                  ? (blockedUser.jobTitle ?? '')
                                  : (blockedUser.desiredCareer ?? ''),
                              style: AppTextStyle.regular12.copyWith(
                                color: textGray,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 77,
                      height: 24,
                      decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          '차단해제',
                          style: AppTextStyle.medium12.copyWith(
                            color: pureWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SectionDivider(height: 1.5),
            ],
          ),
        );
      },
    );
  }
}
