import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/routes/app_router.dart';
import 'package:keodam_app/styles/app_colors.dart';

class TermsPage extends HookConsumerWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPrivacyChecked = useState(false);
    final isServiceChecked = useState(false);
    final isEventChecked = useState(false);
    final isAllChecked = useState(false);

    // 전체 동의 상태 업데이트 함수
    void updateAllChecked() {
      isAllChecked.value = isPrivacyChecked.value && 
                          isServiceChecked.value && 
                          isEventChecked.value;
    }

    // 전체 동의 토글 함수
    void toggleAll(bool value) {
      isAllChecked.value = value;
      isPrivacyChecked.value = value;
      isServiceChecked.value = value;
      isEventChecked.value = value;
    }

    // 개별 약관 변경 함수들
    void onPrivacyChanged(bool value) {
      isPrivacyChecked.value = value;
      updateAllChecked();
    }

    void onServiceChanged(bool value) {
      isServiceChecked.value = value;
      updateAllChecked();
    }

    void onEventChanged(bool value) {
      isEventChecked.value = value;
      updateAllChecked();
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        bottom: true,
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      const Text(
                        '커피와 담소 서비스의 원활한 이용을 위해,\n약관 동의가 필요해요.',
                      ),
                      const SizedBox(height: 48),
                      _AllTermsSection(
                        isChecked: isAllChecked.value,
                        onToggle: toggleAll,
                      ),
                      const SizedBox(height: 24),
                      _TermsList(
                        isPrivacyChecked: isPrivacyChecked.value,
                        isServiceChecked: isServiceChecked.value,
                        isEventChecked: isEventChecked.value,
                        onPrivacyChanged: onPrivacyChanged,
                        onServiceChanged: onServiceChanged,
                        onEventChanged: onEventChanged,
                        onTermsDetail: _showTermsDetail,
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (isPrivacyChecked.value && isServiceChecked.value)
                    ? () => _handleProceed(context)
                    : null,
                child: const Text('시작하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTermsDetail(String type) {
    // TODO: 약관 상세 페이지로 이동
  }

  void _handleProceed(BuildContext context) {
    context.pushNamed(AppRoutes.phoneVerification.name);
  }
}

class _AllTermsSection extends StatelessWidget {
  final bool isChecked;
  final Function(bool) onToggle;

  const _AllTermsSection({
    required this.isChecked,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onToggle(!isChecked),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: isChecked,
                onChanged: (value) => onToggle(value ?? false),
                activeColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text('전체 약관 동의하기 (선택 항목 포함)'),
          ],
        ),
      ),
    );
  }
}

class _TermsList extends StatelessWidget {
  final bool isPrivacyChecked;
  final bool isServiceChecked;
  final bool isEventChecked;
  final Function(bool) onPrivacyChanged;
  final Function(bool) onServiceChanged;
  final Function(bool) onEventChanged;
  final Function(String) onTermsDetail;

  const _TermsList({
    required this.isPrivacyChecked,
    required this.isServiceChecked,
    required this.isEventChecked,
    required this.onPrivacyChanged,
    required this.onServiceChanged,
    required this.onEventChanged,
    required this.onTermsDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TermItemWidget(
          title: '개인정보 수집 및 이용 동의',
          suffix: '(필수)',
          isChecked: isPrivacyChecked,
          onChanged: (value) => onPrivacyChanged(value ?? false),
          onTap: () => onTermsDetail('privacy'),
        ),
        const SizedBox(height: 16),
        TermItemWidget(
          title: '서비스이용약관 동의',
          suffix: '(필수)',
          isChecked: isServiceChecked,
          onChanged: (value) => onServiceChanged(value ?? false),
          onTap: () => onTermsDetail('service'),
        ),
        const SizedBox(height: 16),
        TermItemWidget(
          title: '이벤트 및 혜택 알림 수신 동의',
          suffix: '(선택)',
          isChecked: isEventChecked,
          onChanged: (value) => onEventChanged(value ?? false),
          onTap: () => onTermsDetail('event'),
        ),
      ],
    );
  }
}

class TermItemWidget extends StatelessWidget {
  final String title;
  final String suffix;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final VoidCallback? onTap;

  const TermItemWidget({
    super.key,
    required this.title,
    required this.suffix,
    required this.isChecked,
    required this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: isChecked,
                onChanged: onChanged,
                activeColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                children: [
                  Text(
                    title,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    suffix,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}