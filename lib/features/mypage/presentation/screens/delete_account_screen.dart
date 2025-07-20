import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/domain/util/show_two_button_dialog.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:keodam/features/mypage/presentation/widgets/button_lg_white.dart';

class DeleteAccountScreen extends ConsumerWidget {
  const DeleteAccountScreen({super.key});

  get backgroundColor02 => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppBar(title: '회원 탈퇴'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '서비스 품질 개선을 위해,  탈퇴 사유를 작성해주세요.',
              style: AppTextStyle.semiBold16.copyWith(color: textBlack),
            ),
            SizedBox(height: 25),
            TextField(
              maxLength: 150,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: EdgeInsets.all(12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: backgroundColor01, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: backgroundColor01, width: 1.5),
                ),
              ),
            ),
            SizedBox(height: 25),
            Text.rich(
              TextSpan(
                style: AppTextStyle.regular12.copyWith(color: textGray),
                children: [
                  TextSpan(
                    text:
                        '서비스 이용약관에 따라 회원이 수신 동의를 철회하거나 회원 탈퇴 시, \n관련 정보는 즉시 삭제됩니다. \n단, 법령에 따라 보관이 필요한 경우는 예외로 합니다. \n또한, ',
                  ),
                  TextSpan(
                    text: '보유하신 원두는 즉시 소멸되며, 환불 및 환급이 불가합니다.',
                    style: AppTextStyle.regular12.copyWith(color: textBlack),
                  ),
                  TextSpan(
                    text: '\n\n탈퇴 후 재가입은 탈퇴시점으로부터 7일 경과 후 가능',
                    style: AppTextStyle.regular12.copyWith(color: textBlack),
                  ),
                  TextSpan(text: '합니다.'),
                ],
              ),
            ),
            Spacer(),
            ButtonLgWhite(
              title: '확인',
              onPressed: () async {
                final result = await showTwoButtonDialog(
                  context,
                  title: '회원 탈퇴를 하시겠습니까?',
                );
                if (result == true) {
                  //TODO: 예 (탈퇴 사유 서버 전송 & 탈퇴처리)
                } else if (result == false) {
                  //TODO: 아니요 (히스토리백)
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
