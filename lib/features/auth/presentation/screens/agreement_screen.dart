import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/features/auth/presentation/widgets/agreement_all_section.dart';
import 'package:keodam/features/auth/presentation/widgets/agreement_bottom_button.dart';
import 'package:keodam/features/auth/presentation/widgets/agreement_list_section.dart';

class AgreementScreen extends ConsumerStatefulWidget {
  const AgreementScreen({super.key});

  @override
  ConsumerState<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends ConsumerState<AgreementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 21, left: 21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [const AgreementAllSection(), const SizedBox(height: 13), const AgreementListSection()],
            ),
          ),
          const AgreementBottomButton(),
        ],
      ),
    );
  }
}
