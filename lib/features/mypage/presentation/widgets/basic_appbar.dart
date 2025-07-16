import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double toolbarHeight;

  const BasicAppBar({super.key, required this.title, this.toolbarHeight = 70});

  @override
  Widget build(BuildContext context) {
    const String backarrowIcon = 'assets/icons/arrow_back.svg';
    return AppBar(
      toolbarHeight: toolbarHeight,
      title: Text(
        title,
        style: AppTextStyle.extraBold20.copyWith(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(backarrowIcon),
        onPressed: () {
          context.pop();
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Divider(height: 1, thickness: 7, color: backgroundColor01),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight + 7);
}
