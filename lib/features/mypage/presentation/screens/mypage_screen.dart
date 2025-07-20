import 'package:flutter/material.dart';

import 'package:keodam/features/mypage/presentation/widgets/section_logout.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_events.dart';

import 'package:keodam/features/mypage/presentation/widgets/role_toggle_card.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_notification.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_profile_edit.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_profile_state.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_divider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_user_support.dart';

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
