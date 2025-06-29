import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/keodam_footer_icons.dart';
import 'package:keodam/core/theme/pretendard_weight.dart';
import 'package:keodam/core/theme/text_styles.dart';

class BottomNavigationScaffold extends StatelessWidget {
  final Widget child;

  const BottomNavigationScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      backgroundColor: pureWhite,
      body: SafeArea(child: child),
      bottomNavigationBar: SizedBox(
        height: 95,
        child: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _getIndex(location),
            selectedItemColor: textBlue02,
            unselectedItemColor: textGray01,
            selectedLabelStyle: AppTextStyle.bold12,
            unselectedLabelStyle: AppTextStyle.bold12,
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go('/feed');
                  break;
                case 1:
                  context.go('/explore');
                  break;
                case 2:
                  context.go('/matching');
                  break;
                case 3:
                  context.go('/mypage');
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Keodam_footer.feed_icon_selected),
                label: '피드',
              ),
              BottomNavigationBarItem(
                icon: Icon(Keodam_footer.explore_icon_selected),
                label: '탐색',
              ),
              BottomNavigationBarItem(
                icon: Icon(Keodam_footer.matching_icon_default),
                label: '매칭',
              ),
              BottomNavigationBarItem(
                icon: Icon(Keodam_footer.mypage_icon_default),
                label: '마이페이지',
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getIndex(String location) {
    if (location.startsWith('/explore')) return 1;
    if (location.startsWith('/matching')) return 2;
    if (location.startsWith('/mypage')) return 3;
    return 0;
  }
}
