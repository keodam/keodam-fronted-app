import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/domain/services/education_status_service.dart';
import 'package:keodam_app/features/auth/presentation/constants/sign_up_profile_constants.dart';
import 'package:keodam_app/features/auth/presentation/providers/education_status_provider.dart';
import 'package:keodam_app/styles/app_colors.dart';

class EducationStatus extends HookConsumerWidget {
  const EducationStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDropdownOpen = useState(false);
    final educationStatusState = ref.watch(educationStatusNotifierProvider);
    final educationStatusNotifier = ref.read(educationStatusNotifierProvider.notifier);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // 드롭다운 외부 클릭 시 닫기
        if (isDropdownOpen.value) {
          isDropdownOpen.value = false;
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              SignUpProfileConstants.educationStatusHeader,
              style: SignUpProfileConstants.header,
            ),
            SignUpProfileConstants.headerBottomHeightBox,
            Text(
              SignUpProfileConstants.educationStatusDesc,
              style: SignUpProfileConstants.headerDesc.copyWith(
                color: AppColors.gray600,
                height: 1.5,
              ),
            ),
            SignUpProfileConstants.progressBottomHeightBox,

            // 드롭다운 선택 영역
            GestureDetector(
              onTap: () {
                isDropdownOpen.value = !isDropdownOpen.value;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(
                    color: isDropdownOpen.value
                        ? AppColors.primary
                        : AppColors.borderLight,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getStatusDisplayText(educationStatusState.selectedStatus),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    AnimatedRotation(
                      turns: isDropdownOpen.value ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.gray600,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 드롭다운 옵션 리스트
            if (isDropdownOpen.value) ...[
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // 드롭다운 옵션 영역 클릭 시 이벤트 전파 차단
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(
                      color: AppColors.borderLight,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildOptionItem(
                        context: context,
                        ref: ref,
                        title: SignUpProfileConstants.educationStatusHighSchool,
                        status: StudentStatus.highSchoolGraduate,
                        isSelected: educationStatusState.selectedStatus == StudentStatus.highSchoolGraduate,
                        onTap: () {
                          educationStatusNotifier.setSelectedStatus(StudentStatus.highSchoolGraduate);
                          isDropdownOpen.value = false;
                        },
                      ),
                      _buildDivider(),
                      _buildOptionItem(
                        context: context,
                        ref: ref,
                        title: SignUpProfileConstants.educationStatusUniversityStudent,
                        status: StudentStatus.universityStudent,
                        isSelected: educationStatusState.selectedStatus == StudentStatus.universityStudent,
                        onTap: () {
                          educationStatusNotifier.setSelectedStatus(StudentStatus.universityStudent);
                          isDropdownOpen.value = false;
                        },
                      ),
                      _buildDivider(),
                      _buildOptionItem(
                        context: context,
                        ref: ref,
                        title: SignUpProfileConstants.educationStatusUniversityGraduate23,
                        status: StudentStatus.universityGraduate23,
                        isSelected: educationStatusState.selectedStatus == StudentStatus.universityGraduate23,
                        onTap: () {
                          educationStatusNotifier.setSelectedStatus(StudentStatus.universityGraduate23);
                          isDropdownOpen.value = false;
                        },
                      ),
                      _buildDivider(),
                      _buildOptionItem(
                        context: context,
                        ref: ref,
                        title: SignUpProfileConstants.educationStatusUniversityGraduate4,
                        status: StudentStatus.universityGraduate4,
                        isSelected: educationStatusState.selectedStatus == StudentStatus.universityGraduate4,
                        onTap: () {
                          educationStatusNotifier.setSelectedStatus(StudentStatus.universityGraduate4);
                          isDropdownOpen.value = false;
                        },
                      ),
                      _buildDivider(),
                      _buildOptionItem(
                        context: context,
                        ref: ref,
                        title: SignUpProfileConstants.educationStatusJobSeeker,
                        status: StudentStatus.jobSeeker,
                        isSelected: educationStatusState.selectedStatus == StudentStatus.jobSeeker,
                        onTap: () {
                          educationStatusNotifier.setSelectedStatus(StudentStatus.jobSeeker);
                          isDropdownOpen.value = false;
                        },
                      ),
                      _buildDivider(),
                      _buildOptionItem(
                        context: context,
                        ref: ref,
                        title: SignUpProfileConstants.educationStatusEmployee,
                        status: StudentStatus.employee,
                        isSelected: educationStatusState.selectedStatus == StudentStatus.employee,
                        onTap: () {
                          educationStatusNotifier.setSelectedStatus(StudentStatus.employee);
                          isDropdownOpen.value = false;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
            
            // 에러 메시지 표시
            if (educationStatusState.errorMessage != null) ...[ 
              const SizedBox(height: 16),
              Text(
                educationStatusState.errorMessage!,
                style: SignUpProfileConstants.error.copyWith(
                  color: AppColors.error,
                ),
              ),
            ],
            
            // 버튼 공간을 위한 여유 공간 추가
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required StudentStatus? status,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                color: AppColors.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColors.borderLight,
    );
  }

  String _getStatusDisplayText(StudentStatus? status) {
    if (status == null) return SignUpProfileConstants.educationStatusPlaceholder;

    switch (status) {
      case StudentStatus.highSchoolGraduate:
        return SignUpProfileConstants.educationStatusHighSchool;
      case StudentStatus.universityStudent:
        return SignUpProfileConstants.educationStatusUniversityStudent;
      case StudentStatus.universityGraduate23:
        return SignUpProfileConstants.educationStatusUniversityGraduate23;
      case StudentStatus.universityGraduate4:
        return SignUpProfileConstants.educationStatusUniversityGraduate4;
      case StudentStatus.jobSeeker:
        return SignUpProfileConstants.educationStatusJobSeeker;
      case StudentStatus.employee:
        return SignUpProfileConstants.educationStatusEmployee;
    }
  }
}