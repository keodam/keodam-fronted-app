import 'package:flutter/material.dart';

import 'package:keodam/features/mypage/presentation/widgets/logout_section.dart';
import 'package:keodam/features/mypage/presentation/widgets/events_section.dart';

import 'package:keodam/features/mypage/presentation/widgets/role_toggle_card.dart';
import 'package:keodam/features/mypage/presentation/widgets/notificiation_section.dart';
import 'package:keodam/features/mypage/presentation/widgets/profile_edit_section.dart';
import 'package:keodam/features/mypage/presentation/widgets/profile_state_section.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_divider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/features/mypage/presentation/widgets/user_support_section.dart';

class MypageScreen extends ConsumerWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 33),
              RoleToggleCard(),
              SectionDivider(height: 32),
              ProfileStateSection(),
              SectionDivider(height: 12),
              ProfileEditSection(),
              SectionDivider(height: 12),
              NotificiationSection(),
              SectionDivider(height: 12),
              EventsSection(),
              SectionDivider(height: 12),
              UserSupportSection(),
              LogoutSection(),
            ],
          ),
        ),
      ),
    );
  }
}
