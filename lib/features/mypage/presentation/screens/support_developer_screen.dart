import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';

class SupportDeveloperScreen extends ConsumerWidget {
  const SupportDeveloperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String backarrowIcon = 'assets/icons/backarrow.svg';
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          '개발자 후원하기',
          style: AppTextStyle.extraBold20.copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(backarrowIcon),
          onPressed: () {
            context.pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(height: 1, thickness: 7, color: backgroundColor01),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(26.0),
              child: Image.asset('assets/images/splash_logo.png', width: 82),
            ),
            Text('계좌번호', style: AppTextStyle.bold16.copyWith(color: textBlack)),
            const SizedBox(height: 5),
            Text(
              '신한은행 110-590-007883',
              style: AppTextStyle.bold14.copyWith(color: textBlack),
            ),
            const SizedBox(height: 28),
            Text(
              textAlign: TextAlign.center,
              '저희 서비스는 대학생들이 모여 대학 선후배, 그리고 \n 졸업생들과의 교류의 필요성을 인지하고 만든\n 대학 맞춤 커피챗서비스입니다. ',
              style: AppTextStyle.regular14.copyWith(color: textGray),
            ),
            const SizedBox(height: 28),
            Text(
              textAlign: TextAlign.center,
              '커담 서비스이 유용했다면, 작은 후원으로 큰 변화를 \n만들어주세요. 여러분의 후원은 더 많은 사람들에게 도움을 \n 줄 수 있는 동력이 됩니다.  ',
              style: AppTextStyle.regular14.copyWith(color: textGray),
            ),
            const SizedBox(height: 40),
            Text(
              textAlign: TextAlign.center,
              '지속적인 서비스 제공을 위해서 도움을 부탁드립니다.',
              style: AppTextStyle.regular14.copyWith(color: textGray),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: color01),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text(
                        '후원자베네핏',
                        style: AppTextStyle.bold16.copyWith(color: textBlack),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '1. 프로필에 [후원자] 배지 적용',
                                style: AppTextStyle.medium16.copyWith(
                                  color: textBlack,
                                ),
                              ),
                              Image.asset(
                                'assets/images/support_badge.png',
                                width: 23,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              '배지 적용을 위해 입금시 메모에 마이페이지 하단에서 확인 \n할 수 있는 계정고유아이디(ex. P1234)를 기입해주시거나 \n고객센터로 문의 주시면 원활한 적용이 가능합니다.',
                              style: AppTextStyle.regular14.copyWith(
                                color: textGray,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '2. 룰렛이용권 제공',
                            style: AppTextStyle.medium16.copyWith(
                              color: textBlack,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '3. 개발자의 감사 인사',
                            style: AppTextStyle.medium16.copyWith(
                              color: textBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
