import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/provider/notification_provider.dart';
import 'package:keodam/features/mypage/presentation/widgets/notification_toggle_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificiationSection extends ConsumerWidget {
  const NotificiationSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chattingEnabled = ref.watch(chattingNotificationProvider);
    final eventEnabled = ref.watch(eventNotificationProvider);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('알림', style: AppTextStyle.bold18),
          const SizedBox(height: 16),
          NotificationToggleTile(
            title: '채팅 알림 전체 수신 설정',
            value: chattingEnabled,
            onChanged: (val) {
              ref.read(chattingNotificationProvider.notifier).state = val;
            },
          ),
          Divider(height: 1, color: backgroundColor01),
          NotificationToggleTile(
            title: '이벤트 및 혜택 알림 수신 설정',
            value: eventEnabled,
            onChanged: (val) {
              ref.read(eventNotificationProvider.notifier).state = val;
            },
          ),
        ],
      ),
    );
  }
}
