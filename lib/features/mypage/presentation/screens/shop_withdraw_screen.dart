import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/presentation/widgets/basic_lg_button.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/domain/util/show_single_button_dialog.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:keodam/features/mypage/presentation/widgets/custom_text_field.dart';
import 'package:keodam/features/mypage/provider/account_input_provider.dart';
import 'package:keodam/features/mypage/provider/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:keodam/features/mypage/provider/withdraw_provider.dart';

class WithdrawScreen extends ConsumerWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppBar(
        title: '환급',
        onBack: () {
          ref.invalidate(bankAccountNumberProvider);
          ref.invalidate(bankOwnerProvider);
          ref.invalidate(bankNameProvider);
          ref.invalidate(beanInputProvider);
        },
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BeanBalanceRow(),
                SizedBox(height: 40),
                WithdrawEstimationBox(),
                SizedBox(height: 40),
                BankAccountNumberInput(),
                SizedBox(height: 40),
                BankOwnerInput(),
                SizedBox(height: 40),
                BankNameInput(),
                SizedBox(height: 40),
                NoticeScript(),
                SizedBox(height: 20),
                BasicLgButton(
                  text: '확인',
                  //TODO: 환급 요청 로직 연결
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SingleButtonDialog(
                          title:
                              '정상적으로 환불 요청 되었습니다.\n 환불은 영업일 기준 3일 ~ 7일 \n소요될 수 있습니다.',
                          onPressed: () {
                            context.pop();
                            context.pop();
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BeanBalanceRow extends ConsumerWidget {
  const BeanBalanceRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '환급 가능 원두',
          style: AppTextStyle.semiBold16.copyWith(color: textBlack),
        ),
        Row(
          children: [
            Text(
              '${user.coffeeCoupon}',
              style: AppTextStyle.semiBold16.copyWith(color: textBlue02),
            ),
            Text(
              ' 원두',
              style: AppTextStyle.semiBold16.copyWith(color: textBlack),
            ),
            SizedBox(width: 8),
            Image.asset('assets/images/mypage/bean1000.png', width: 28),
          ],
        ),
      ],
    );
  }
}

class WithdrawEstimationBox extends ConsumerWidget {
  const WithdrawEstimationBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = NumberFormat('#,###');
    final estimated = ref.watch(beanWithdrawAmountProvider);
    final user = ref.watch(userProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '환급할 원두',
          style: AppTextStyle.semiBold16.copyWith(color: textBlack),
        ),
        SizedBox(height: 9),

        Row(
          children: [
            SizedBox(
              width: 186,
              height: 41,
              child: TextField(
                onChanged: (value) {
                  ref.read(beanInputProvider.notifier).state = value;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),
                  hintStyle: AppTextStyle.regular14.copyWith(color: textGray),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: backgroundColor01,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: backgroundColor01,
                      width: 1.5,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(width: 11),
            Text(
              '원두',
              style: AppTextStyle.semiBold16.copyWith(color: textBlack),
            ),
            Image.asset('assets/images/mypage/bean1000.png', width: 28),
          ],
        ),
        SizedBox(height: 9),
        Text(
          estimated == 0
              ? '환급은 1,200원두부터 가능합니다.'
              : estimated > user.coffeeCoupon * 14 * 0.8
              ? '보유한 원두보다 많은 금액을 입력하셨습니다.'
              : '환급 예상 금액 ₩${formatter.format(estimated)}',
          style: AppTextStyle.regular14.copyWith(color: textGray),
        ),
      ],
    );
  }
}

class BankAccountNumberInput extends ConsumerWidget {
  const BankAccountNumberInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isValid = ref.watch(isValidBankAccountNumberProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('계좌번호', style: AppTextStyle.semiBold16.copyWith(color: textBlack)),
        SizedBox(height: 6),
        Text(
          isValid ? '' : '계좌번호를 정확히 입력해주세요.',
          style: AppTextStyle.regular12.copyWith(color: textBlack),
        ),
        SizedBox(height: 6),
        SizedBox(
          height: 41,
          child: CustomTextField(
            hintText: '',
            targetProvider: bankAccountNumberProvider,
          ),
        ),
      ],
    );
  }
}

class BankOwnerInput extends ConsumerWidget {
  const BankOwnerInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isValid = ref.watch(isValidBankOwnerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('예금주명', style: AppTextStyle.semiBold16.copyWith(color: textBlack)),
        SizedBox(height: 6),
        Text(
          isValid ? '' : '예금주명을 정확히 입력해주세요.',
          style: AppTextStyle.regular12.copyWith(color: textBlack),
        ),
        SizedBox(height: 6),
        SizedBox(
          height: 41,
          child: CustomTextField(
            hintText: '',
            targetProvider: bankOwnerProvider,
          ),
        ),
      ],
    );
  }
}

class BankNameInput extends ConsumerWidget {
  const BankNameInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isValid = ref.watch(isValidBankNameProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('은행명', style: AppTextStyle.semiBold16.copyWith(color: textBlack)),
        SizedBox(height: 6),
        Text(
          isValid ? '' : '은행명을 정확히 입력해주세요.',
          style: AppTextStyle.regular12.copyWith(color: textBlack),
        ),
        SizedBox(height: 6),
        SizedBox(
          height: 41,
          child: CustomTextField(
            hintText: '',
            targetProvider: bankNameProvider,
          ),
        ),
      ],
    );
  }
}

class NoticeScript extends ConsumerWidget {
  const NoticeScript({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text.rich(
      TextSpan(
        style: AppTextStyle.regular12.copyWith(color: textGray),
        children: [
          TextSpan(
            text:
                '원두 환급은 커피챗 매칭을 통해 얻은 원두에 한해 가능합니다.\n환급은 영업일 기준 3~7일 소요될 수 있습니다. \n\n룰렛으로 얻은 원두는 환불이 불가합니다. \n\n또한, 환급 시 20%의 수수료가 부가됩니다. \n원두는 1,200 원두부터 환급 가능합니다. \n자세한 내용은 ',
          ),
          //TODO:A4(이용약관 페이지 연결)
          TextSpan(
            text: '이용약관 중 청약철회',
            style: AppTextStyle.regular12.copyWith(
              color: textGray,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(text: '에 관한 방침을 확인해주시기 바랍니다.'),
        ],
      ),
    );
  }
}
