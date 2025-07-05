import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/core/theme/colors.dart';

class ShopHeader extends StatelessWidget {
  final int beanAmount;
  final int ticketAmount;

  const ShopHeader({
    super.key,
    required this.beanAmount,
    required this.ticketAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: backgroundColor01, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/shop.svg'),
              const SizedBox(width: 4),
              Text('상점', style: AppTextStyle.bold16),
            ],
          ),
          Row(
            children: [
              Text('보유재화', style: AppTextStyle.bold16),
              const SizedBox(width: 11),
              Row(
                children: [
                  Image.asset(
                    'assets/images/mypage/logo_coffee_beans.png',
                    width: 24,
                  ),
                  const SizedBox(width: 5),
                  Text('$beanAmount', style: AppTextStyle.regular14),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Image.asset(
                    'assets/images/mypage/logo_rulet_ticket.png',
                    width: 24,
                  ),
                  const SizedBox(width: 5),
                  Text('$ticketAmount', style: AppTextStyle.regular14),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
