import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:keodam/core/presentation/widgets/basic_lg_button.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/data/model/purchase_data.dart';
import 'package:keodam/features/mypage/data/model/refund_item_type.dart';
import 'package:keodam/features/mypage/data/model/refund_status.dart';
import 'package:keodam/features/mypage/domain/util/show_single_button_dialog.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:keodam/features/mypage/presentation/widgets/custom_text_field.dart';
import 'package:keodam/features/mypage/provider/account_input_provider.dart';
import 'package:keodam/features/mypage/provider/purchase_history_provider.dart';

class RefundDetail extends ConsumerWidget {
  final PurchaseList item;

  const RefundDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppBar(
        title: '환불',
        onBack: () {
          ref.invalidate(bankAccountNumberProvider);
          ref.invalidate(bankOwnerProvider);
          ref.invalidate(bankNameProvider);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RefundDetailItem(item: item),
              SizedBox(height: 40),
              BankAccountNumberInput(),
              SizedBox(height: 40),
              BankOwnerInput(),
              SizedBox(height: 40),
              BankNameInput(),
              SizedBox(height: 40),
              NoticeScript(),
              SizedBox(height: 40),
              BasicLgButton(
                text: '확인',
                onPressed: () {
                  final bankAccountNumber = ref.read(
                    isValidBankAccountNumberProvider,
                  );
                  final bankOwner = ref.read(isValidBankOwnerProvider);
                  final bankName = ref.read(isValidBankNameProvider);

                  //TODO: post 환불 요청 로직
                  final purchaseList = ref.read(purchaseHistoryProvider);
                  final index = purchaseList.indexOf(item);

                  if (!bankAccountNumber || !bankOwner || !bankName) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SingleButtonDialog(
                          title: '모든 항목을 정확히 입력해주세요.',
                          onPressed: () {
                            context.pop();
                          },
                        );
                      },
                    );
                    return;
                  } else {
                    if (index != -1) {
                      ref
                          .read(purchaseHistoryProvider.notifier)
                          .updateRefundStatus(index, RefundStatus.pending);
                    }
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
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RefundDetailItem extends ConsumerWidget {
  final PurchaseList item;
  const RefundDetailItem({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = NumberFormat.currency(locale: 'ko_KR', symbol: '₩');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${item.date.year}.${item.date.month}.${item.date.day}',
          style: AppTextStyle.regular12.copyWith(color: textGray),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Image.asset(item.itemType.imageAssetName, width: 63),
            const SizedBox(width: 10),
            Text(
              item.itemName,
              style: AppTextStyle.bold20.copyWith(color: textBlack),
            ),
            const Spacer(),
            Text(
              formatter.format(item.itemPrice),
              style: AppTextStyle.bold24.copyWith(color: textBlack),
            ),
          ],
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
