import 'package:go_router/go_router.dart';
import 'package:keodam_app/sample.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Sample(),
      routes: [
      ]
    ),
  ],
);