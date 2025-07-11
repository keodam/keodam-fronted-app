import 'package:flutter/material.dart';

import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';

class MypageMenuTile extends StatelessWidget {
  final String title;
  final String iconAssetPath;
  final VoidCallback onTap;
  final bool showTrailing;

  const MypageMenuTile({
    super.key,
    required this.title,
    required this.iconAssetPath,
    required this.onTap,
    this.showTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.regular14.copyWith(color: textGray),
                    ),
                    const SizedBox(width: 8),
                    if (iconAssetPath.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Image.asset(iconAssetPath, width: 24),
                    ],
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 5),
                    if (showTrailing)
                      const Icon(Icons.chevron_right, color: textBlack),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
