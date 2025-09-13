import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/presentation/providers/sign_up_profile_navigation_provider.dart';

class SignUpProfileAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SignUpProfileAppBar({super.key, this.title, this.initialPage});
  final String? initialPage;
  final String? title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                final currentIndex = ref.read(signUpProfileNavigationProvider(initialPage));
                if(currentIndex > 1){
                  ref.read(signUpProfileNavigationProvider(initialPage).notifier).goToPrevPage();
                }else{
                  // await _showExitConfirmDialog(context);
                }
              },
              customBorder: const CircleBorder(),
              child: SvgPicture.asset(
                'assets/icons/back.svg',
                width: 30,
                height: 30,
              ),
            ),
            if(title != null) Expanded(
              child: Text(
                title!,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget smallIconButton({
  required IconData icon,
  required VoidCallback onPressed,
  double size = 24.0,
  double minSize = 24.0,
}) {
  return IconButton(
    icon: Icon(icon, size: size),
    onPressed: onPressed,
    padding: EdgeInsets.zero,
    constraints: BoxConstraints(
      minWidth: minSize,
      minHeight: minSize,
    ),
    splashRadius: size * 0.6, // 옵션: 터치 효과 범위 조정
  );
}
