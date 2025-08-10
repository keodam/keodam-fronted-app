import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/presentation/widgets/basic_lg_button.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/domain/util/show_single_button_dialog.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:keodam/features/mypage/presentation/widgets/custom_text_field.dart';
import 'package:keodam/features/mypage/provider/phone_number_input_provider.dart';
import 'package:keodam/features/mypage/provider/roulette_provider.dart';
import 'package:keodam/features/mypage/provider/selected_coffee_coupon_provider.dart';

class CoffeeExchangeRequestScreen extends ConsumerWidget {
  const CoffeeExchangeRequestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppBar(
        title: '교환 신청',
        onBack: () {
          ref.invalidate(phoneNumberProvider);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExchangeSection(),
              SizedBox(height: 66),
              PhoneNumberInputSection(),
              SizedBox(height: 66),
              NoticeSection(),
              SizedBox(height: 66),
              BasicLgButton(
                text: '교환 신청하기',
                onPressed: () => _handleExchangeRequest(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _handleExchangeRequest(BuildContext context, WidgetRef ref) {
  final isValidPhoneNumber = ref.watch(isValidPhoneNumberProvider);
  final exchangeCoupon = ref.watch(rouletteProvider);

  if (!isValidPhoneNumber) {
    _showInvalidPhoneNumberDialog(context);
  } else if (exchangeCoupon.coffeeCoupon == 0) {
    _showNoCouponDialog(context);
  } else {
    _showSuccessDialog(context, ref);
  }
}

void _showInvalidPhoneNumberDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (_) => SingleButtonDialog(
          title: '휴대폰 번호 형식을 \n다시 확인해주세요.',
          buttonText: '확인',
          onPressed: () => context.pop(),
        ),
  );
}

void _showNoCouponDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (_) => SingleButtonDialog(
          title: '보유한 커피 교환권이 없거나, \n교환하실 수량을 다시 확인해주세요.',
          buttonText: '확인',
          onPressed: () => context.pop(),
        ),
  );
}

void _showSuccessDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder:
        (_) => SingleButtonDialog(
          title: '교환 신청이 \n정상적으로 처리되었습니다.',
          buttonText: '확인',
          onPressed: () {
            ref
                .read(rouletteProvider.notifier)
                .update(
                  (state) => state.copyWith(
                    coffeeCoupon:
                        state.coffeeCoupon -
                        ref.read(selectedCoffeeCouponProvider),
                  ),
                );
            context.pop();
            context.pop();
          },
        ),
  );
}

class ExchangeSection extends ConsumerStatefulWidget {
  const ExchangeSection({super.key});

  @override
  ConsumerState<ExchangeSection> createState() => _ExchangeSectionState();
}

class _ExchangeSectionState extends ConsumerState<ExchangeSection> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final couponState = ref.watch(rouletteProvider);
    final availableCouponCount = couponState.coffeeCoupon;

    final List<String> items =
        availableCouponCount == 0
            ? const <String>[]
            : List.generate(availableCouponCount, (i) => '${i + 1}');

    if (availableCouponCount == 0) {
      selectedValue = 0.toString();
    } else {
      selectedValue ??= items.first;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                '신청 가능한 교환권',
                style: AppTextStyle.semiBold16.copyWith(color: textBlack),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/mypage/logo_roulette_coffee_ticket.png',
                width: 65,
              ),
              const SizedBox(height: 7),
              Text(
                '$availableCouponCount장',
                style: AppTextStyle.regular10.copyWith(color: textBlack),
              ),
            ],
          ),

          Image.asset('assets/images/mypage/blue_arrow.png', width: 31),

          Column(
            children: [
              Text(
                '신청할 교환권 수',
                style: AppTextStyle.semiBold16.copyWith(color: textBlack),
              ),
              const SizedBox(height: 20),
              DropdownButton2<String>(
                underline: const SizedBox.shrink(),
                isExpanded: true,
                value: selectedValue,
                hint: const Text('0'),
                onChanged:
                    items.isEmpty
                        ? null
                        : (v) {
                          setState(() => selectedValue = v);
                          ref
                              .read(selectedCoffeeCouponProvider.notifier)
                              .state = int.parse(v!);
                        },
                items:
                    items
                        .map(
                          (it) => DropdownMenuItem(value: it, child: Text(it)),
                        )
                        .toList(),
                buttonStyleData: ButtonStyleData(
                  width: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: backgroundColor01, width: 1.5),
                    color: pureWhite,
                  ),
                ),
                iconStyleData: IconStyleData(
                  icon: SvgPicture.asset('assets/icons/dropdown_arrow.svg'),
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: pureWhite,
                  ),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: WidgetStateProperty.all(6),
                    thumbVisibility: WidgetStateProperty.all(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 14),
                ),
              ),
              const SizedBox(height: 7),
            ],
          ),
        ],
      ),
    );
  }
}

class PhoneNumberInputSection extends ConsumerWidget {
  const PhoneNumberInputSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '기프티콘을 제공받을 휴대폰 번호',
          style: AppTextStyle.semiBold16.copyWith(color: textBlack),
        ),
        SizedBox(height: 6),
        Text('휴대폰 번호를 정확히 입력해주세요.'),
        SizedBox(height: 10),
        CustomTextField(
          height: 50,
          hintText: '010-XXXX-XXXX',
          keyboardType: TextInputType.phone,
          targetProvider: phoneNumberProvider,
        ),
      ],
    );
  }
}

class NoticeSection extends ConsumerWidget {
  const NoticeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '교환 신청이 정상적으로 처리되면,\n관리자 검토 후 가입한 연락처로 모바일 기프티콘이 제공됩니다.',
          style: AppTextStyle.regular12.copyWith(color: textGray),
        ),
        SizedBox(height: 10),
        Text(
          '커피 기프티콘의 브랜드와 상품 종류는 상이할 수 있습니다.',
          style: AppTextStyle.regular12.copyWith(color: textGray),
        ),
        SizedBox(height: 10),
        Text(
          '휴대폰 번호 오기재 시, 오기재된 번호로 발송된 기프티콘에 대해서는\n다시 보상이 불가한 점 양해 부탁드립니다.',
          style: AppTextStyle.regular12.copyWith(color: textGray),
        ),
        SizedBox(height: 10),
        Text(
          '기재하신 휴대폰 번호는 기프티콘 제공 이후,\n개인정보처리방침에 의거하여 파기됩니다.',
          style: AppTextStyle.regular12.copyWith(color: textGray),
        ),
        SizedBox(height: 10),
        Text.rich(
          TextSpan(
            text: '자세한 내용은 ',
            style: AppTextStyle.regular12.copyWith(color: textGray),
            children: [
              TextSpan(
                text: '이용약관 및 개인정보처리방침',
                style: AppTextStyle.regular12.copyWith(
                  color: textGray,
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(
                text: '을 확인해주시기 바랍니다.',
                style: AppTextStyle.regular12.copyWith(color: textGray),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
