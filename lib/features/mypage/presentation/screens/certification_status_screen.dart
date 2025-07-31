import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/router/routes.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/data/model/certification_type.dart';
import 'package:keodam/features/mypage/presentation/screens/certification_email_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/certification_upload_file_screen.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_divider.dart';
import 'package:keodam/features/mypage/provider/certification_type_provider.dart';

class CertificationStatusScreen extends ConsumerWidget {
  const CertificationStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const BasicAppBar(title: '졸업, 재학, 현직자 인증'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(child: Text('재학', style: AppTextStyle.medium16)),
                  Tab(child: Text('졸업', style: AppTextStyle.medium16)),
                  Tab(child: Text('재직', style: AppTextStyle.medium16)),
                ],
                labelColor: textBlue02,
                unselectedLabelColor: textBlack,
                indicator: BoxDecoration(),
              ),
              SectionDivider(height: 1.5),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: EnrollmentCertification()),
                    Center(child: GraduationCertification()),
                    Center(child: EmploymentCertification()),
                  ],
                ),
              ),
              SectionDivider(height: 1.5),
            ],
          ),
        ),
      ),
    );
  }
}

class EnrollmentCertification extends ConsumerWidget {
  const EnrollmentCertification({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        CertificationOptionTile(
          title: '이메일로 인증하기',
          description: '재학중인 경우, 재학증명서 파일을 첨부합니다.',
          onTap: () {
            ref.read(certificationTypeProvider.notifier).state =
                CertificationType.enrollment;
            context.go(
              '${Routes.mypage}/${Routes.mypageCertificationStatus}/${Routes.mypageCertificationEmail}',
            );
          },
        ),
        CertificationOptionTile(
          title: '파일 첨부로 인증하기',
          description: '재학중인 경우, 재학증명서 파일을 첨부합니다.',
          onTap: () {
            ref.read(certificationTypeProvider.notifier).state =
                CertificationType.enrollment;
            context.go(
              '${Routes.mypage}/${Routes.mypageCertificationStatus}/${Routes.mypageCertificationFile}',
            );
          },
        ),
        const Description(),
      ],
    );
  }
}

class GraduationCertification extends ConsumerWidget {
  const GraduationCertification({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        CertificationOptionTile(
          title: '파일 첨부로 인증하기',
          description: '졸업의 경우, 졸업증명서 파일을 첨부합니다.',
          onTap: () {
            ref.read(certificationTypeProvider.notifier).state =
                CertificationType.graduation;
            context.go(
              '${Routes.mypage}/${Routes.mypageCertificationStatus}/${Routes.mypageCertificationFile}',
            );
          },
        ),
        const Description(),
      ],
    );
  }
}

class EmploymentCertification extends ConsumerWidget {
  const EmploymentCertification({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        CertificationOptionTile(
          title: '이메일로 인증하기',
          description: '현직자의 경우, 재직증명서, 명함, 건강보험 자격득실확인서 \n파일을 첨부합니다.',
          onTap: () {
            ref.read(certificationTypeProvider.notifier).state =
                CertificationType.employment;
            context.go(
              '${Routes.mypage}/${Routes.mypageCertificationStatus}/${Routes.mypageCertificationEmail}',
            );
          },
        ),
        CertificationOptionTile(
          title: '파일 첨부로 인증하기',
          description: '현직자의 경우, 재직증명서 파일을 첨부합니다.',
          onTap: () {
            ref.read(certificationTypeProvider.notifier).state =
                CertificationType.employment;
            context.go(
              '${Routes.mypage}/${Routes.mypageCertificationStatus}/${Routes.mypageCertificationFile}',
            );
          },
        ),
        const Description(),
      ],
    );
  }
}

class CertificationOptionTile extends ConsumerWidget {
  final String title;
  final String description;
  final VoidCallback? onTap;

  const CertificationOptionTile({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 26.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyle.semiBold16),
                    SizedBox(height: 6),
                    Text(
                      description,
                      style: AppTextStyle.regular12.copyWith(color: textGray),
                    ),
                  ],
                ),
                SvgPicture.asset('assets/icons/arrow_forward.svg', width: 12),
              ],
            ),
          ),
          SectionDivider(height: 1.5),
        ],
      ),
    );
  }
}

class Description extends ConsumerWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 26.0),
      child: Row(
        children: [
          Text(
            '프로필을 인증하게 되면 뱃지와 설명이 제공돼요!',
            style: AppTextStyle.regular12.copyWith(color: textBlack),
          ),
          SizedBox(width: 8),
          Image.asset(
            'assets/images/mypage/icon_certified_badge.png',
            width: 20,
          ),
        ],
      ),
    );
  }
}
