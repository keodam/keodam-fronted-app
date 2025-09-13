import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/presentation/constants/sign_up_profile_constants.dart';
import 'package:keodam_app/features/auth/presentation/providers/role_provider.dart';
import 'package:keodam_app/styles/app_colors.dart';

class Role extends HookConsumerWidget {
  const Role({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleState = ref.watch(roleNotifierProvider);
    final roleNotifier = ref.read(roleNotifierProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SignUpProfileConstants.progressBottomHeightBox,
          Text(
            SignUpProfileConstants.roleHeader,
            style: SignUpProfileConstants.header.copyWith(
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            SignUpProfileConstants.roleDesc1,
            style: SignUpProfileConstants.info.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            SignUpProfileConstants.roleDesc2,
            style: SignUpProfileConstants.info.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),
          Row(
            children: [
              Expanded(
                child: _RoleCard(
                  title: SignUpProfileConstants.roleMentor,
                  imagePath: 'assets/icons/mento.png',
                  isSelected: roleState.selectedRole == 'MENTOR',
                  onTap: () => roleNotifier.selectRole('MENTOR'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _RoleCard(
                  title: SignUpProfileConstants.roleMentee,
                  imagePath: 'assets/icons/mentee.png',
                  isSelected: roleState.selectedRole == 'MENTEE',
                  onTap: () => roleNotifier.selectRole('MENTEE'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Center(
            child: Image.asset(
              'assets/page_role.png',
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          // 에러 메시지 표시
          if (roleState.errorMessage != null) ...[
            const SizedBox(height: 16),
            Center(
              child: Text(
                roleState.errorMessage!,
                style: SignUpProfileConstants.error.copyWith(
                  color: AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderLight,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 48,
              height: 48,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
