import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/home/presentation/providers/home_navigation_notifier.dart';
import 'package:keodam_app/features/home/presentation/widgets/home_bottom_navigation_bar.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  static const List<Widget> _views = [
    Text('1'),
    Text('2'),
    Text('3'),
    Text('4'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeNavigationNotifierProvider);

    // 페이지 유지를 위한 PageController
    final pageController = usePageController(initialPage: currentIndex);

    // currentIndex 변경 시 페이지 전환
    useEffect(() {
      if (pageController.hasClients && pageController.page?.round() != currentIndex) {
        pageController.jumpToPage(currentIndex);
      }
      return null;
    }, [currentIndex]);

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(), // 스와이프 비활성화
          children: _views,
        ),
      ),
      bottomNavigationBar: const HomeBottomNavigationBar(),
    );
  }
}