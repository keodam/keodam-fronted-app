import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:keodam/features/mypage/data/model/faq_table.dart';

import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_divider.dart';

class ContactSupportFaqScreen extends ConsumerWidget {
  const ContactSupportFaqScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppBar(title: '자주 묻는 질문'),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: faqList.length,
              itemBuilder: (context, index) {
                final item = faqList[index];
                final isLast = index == faqList.length - 1;

                return Column(
                  children: [
                    FaqItem(question: item.question, answer: item.answer),
                    if (isLast) const SectionDivider(height: 1.5),
                  ],
                );
              },
              separatorBuilder: (_, __) => const SectionDivider(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class FaqItem extends ConsumerStatefulWidget {
  final String question;
  final String answer;

  const FaqItem({super.key, required this.question, required this.answer});

  @override
  ConsumerState<FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends ConsumerState<FaqItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            'Q  ${widget.question}',
            style: AppTextStyle.medium16.copyWith(color: textBlack),
          ),
          trailing: SvgPicture.asset(
            _isExpanded
                ? 'assets/icons/arrow_up.svg'
                : 'assets/icons/arrow_down.svg',
            width: 30,
            height: 30,
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'A ${widget.answer}',
                style: AppTextStyle.medium16.copyWith(color: textBlue02),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
