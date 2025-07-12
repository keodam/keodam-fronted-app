import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/domain/mypage_menu_title.dart';
import 'package:keodam/features/mypage/provider/role_provider.dart';

class MypageMenuTile extends ConsumerWidget {
  final MypageMenuTitle title;
  final String iconAssetPath;
  final VoidCallback? onTap;
  final bool showTrailing;

  const MypageMenuTile({
    super.key,
    required this.title,
    required this.iconAssetPath,
    this.onTap,
    this.showTrailing = true,
  });

  get backgroundColor02 => null;

  void _handleTap(BuildContext context, WidgetRef ref) {
    final isMentee = ref.read(userRoleProvider);

    if (title == MypageMenuTitle.roulette) {
      if (ref.read(userRoleProvider) == Role.mentee) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 52.0),
                        child: Column(
                          children: [
                            Text(
                              '현재 설정값이 멘토인 경우\n룰렛을 돌릴 수 없어요!',
                              style: AppTextStyle.semiBold16.copyWith(
                                color: textBlack,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '멘토로 전환 후 사용해보아요.',
                              style: AppTextStyle.regular14.copyWith(
                                color: textGray,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1, color: backgroundColor02),
                      SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(
                            foregroundColor: textBlue02,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text('확인', style: AppTextStyle.bold18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } else {
        onTap?.call(); // 멘토일 때만 실제 동작 실행
      }
    } else {
      onTap?.call(); // 나머지 메뉴는 그냥 실행
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        InkWell(
          onTap: () => _handleTap(context, ref),
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
                      title.label,
                      style: AppTextStyle.regular14.copyWith(color: textGray),
                    ),
                    if (iconAssetPath.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Image.asset(iconAssetPath, width: 24),
                    ],
                  ],
                ),
                if (showTrailing)
                  const Icon(Icons.chevron_right, color: textBlack),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
