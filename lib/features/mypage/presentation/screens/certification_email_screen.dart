import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/data/model/certification_type.dart';
import 'package:keodam/features/mypage/domain/util/show_single_button_dialog.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_divider.dart';
import 'package:keodam/features/mypage/provider/certification_type_provider.dart';

class CertificationEmailScreen extends ConsumerWidget {
  const CertificationEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final certificationType = ref.watch(certificationTypeProvider);
    return Scaffold(
      appBar: BasicAppBar(title: '이메일 인증'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (certificationType == CertificationType.enrollment)
              const NoticeSectionForEnrollment()
            else if (certificationType == CertificationType.employment)
              const NoticeSectionForEmployment(),
            const TextFieldSection(),
          ],
        ),
      ),
    );
  }
}

class NoticeSectionForEnrollment extends ConsumerWidget {
  const NoticeSectionForEnrollment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 17.0),
        Text(
          '재학상태에 대한 이메일 인증을 진행해요!',
          style: AppTextStyle.semiBold16.copyWith(color: textBlack),
        ),
        const SizedBox(height: 13.0),
        Text(
          '대학에서 공식적으로 제공하는 이메일 계정으로, \n주로 학교 도메인(@학교명.ac.kr, @학교명.edu 등)으로 되어있어요.',
          style: AppTextStyle.regular12.copyWith(color: textGray),
        ),
        SizedBox(height: 42),
        SectionDivider(height: 1.5),
        SizedBox(height: 35),
      ],
    );
  }
}

class NoticeSectionForEmployment extends ConsumerWidget {
  const NoticeSectionForEmployment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 17.0),
        Text(
          '재직상태에 대한 이메일 인증을 진행해요!',
          style: AppTextStyle.semiBold16.copyWith(color: textBlack),
        ),
        const SizedBox(height: 13.0),
        Text(
          '기업이 공식적으로 발급한 업무용 이메일(@회사도메인.com 등)을 통해 \n인증할 수 있어요.',
          style: AppTextStyle.regular12.copyWith(color: textGray),
        ),
        Text(
          '\n계약직이나 프리랜서의 경우, 파일 인증을 통해 인증 해주세요.',
          style: AppTextStyle.regular12.copyWith(color: textGray),
        ),
        SizedBox(height: 18),
        SectionDivider(height: 1.5),
        SizedBox(height: 35),
      ],
    );
  }
}

class TextFieldSection extends ConsumerWidget {
  const TextFieldSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 42.32,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'example@office.skhu.ac.kr',
                    hintStyle: AppTextStyle.regular12.copyWith(
                      color: textGray,
                      decoration: TextDecoration.underline,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: backgroundColor01,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: backgroundColor01,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleButtonDialog(
                      title: '입력하신 이메일로 \n인증번호를 발송하였습니다.',
                      message: '메일이 보이지 않을 경우, \n스팸 메일함을 확인해주세요.',
                      onPressed: () {
                        context.pop();
                      },
                    );
                  },
                );
              },
              style: TextButton.styleFrom(backgroundColor: color01),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 21.0,
                  vertical: 3,
                ),
                child: Text(
                  '인증하기',
                  style: AppTextStyle.semiBold16.copyWith(color: textBlue02),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 42.32,
          child: TextField(
            decoration: InputDecoration(
              hintText: '인증번호 6자리를 입력해주세요.',
              hintStyle: AppTextStyle.regular12.copyWith(color: textGray),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: backgroundColor01,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: backgroundColor01,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return SingleButtonDialog(
                  title: '인증이 완료되었습니다.',
                  onPressed: () {
                    context.pop();
                  },
                );
              },
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: pointColor529DFF,
            minimumSize: const Size(128, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            '확인',
            style: AppTextStyle.semiBold16.copyWith(color: pureWhite),
          ),
        ),
      ],
    );
  }
}
