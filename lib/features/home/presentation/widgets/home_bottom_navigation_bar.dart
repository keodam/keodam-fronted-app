import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/home/navigation_tab.dart';
import 'package:keodam_app/features/home/presentation/providers/home_navigation_notifier.dart';
import 'package:keodam_app/styles/app_colors.dart';

class HomeBottomNavigationBar extends ConsumerWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeNavigationNotifierProvider);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.borderLight,
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              ref.read(homeNavigationNotifierProvider.notifier).selectTab(index);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.gray400,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation: 0,
            items: [
              NavigationTab(
                label: '피드',
                iconPath: 'assets/icons/home_nav_feed.svg',
                index: 0,
              ),
              NavigationTab(
                label: '탐색',
                iconPath: 'assets/icons/home_nav_search.svg',
                index: 1,
              ),
              NavigationTab(
                label: '매칭',
                iconPath: 'assets/icons/home_nav_matching.svg',
                index: 2,
              ),
              NavigationTab(
                label: '마이페이지',
                iconPath: 'assets/icons/home_nav_mypage.svg',
                index: 3,
              ),
            ].map((tab) {
              final isSelected = currentIndex == tab.index;
              return BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  tab.iconPath,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppColors.primary : AppColors.gray400,
                    BlendMode.srcIn,
                  ),
                ),
                label: tab.label,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}