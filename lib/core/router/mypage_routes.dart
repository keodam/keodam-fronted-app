import 'package:go_router/go_router.dart';
import 'package:keodam/features/mypage/data/model/purchase_data.dart';
import 'package:keodam/features/mypage/data/model/shop_product_data.dart';
import 'package:keodam/features/mypage/presentation/screens/certification_email_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/certification_status_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/certification_upload_file_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/coffee_exchange_request_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/community_profile_edit.dart';
import 'package:keodam/features/mypage/presentation/screens/contact_support_faq_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/contact_support_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/delete_account_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/manage_block_users_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/mentee_level_guide.dart';
import 'package:keodam/features/mypage/presentation/screens/mypage_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/mento_level_guide.dart';
import 'package:keodam/features/mypage/presentation/screens/roulette_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/shop_purchase_history.dart';
import 'package:keodam/features/mypage/presentation/screens/shop_purchase_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/shop_refund_detail.dart';
import 'package:keodam/features/mypage/presentation/screens/shop_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/shop_withdraw_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/support_developer_screen.dart';
import 'package:keodam/core/router/routes.dart';

final mypageRoutes = GoRoute(
  path: Routes.mypage,
  pageBuilder:
      (context, state) => CustomTransitionPage(
        child: MypageScreen(),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) => child,
        transitionDuration: Duration.zero,
      ),
  routes: [
    GoRoute(
      path: Routes.mypageMentorLevelGuide,
      builder: (context, state) => const MentoLevelGuide(),
    ),
    GoRoute(
      path: Routes.mypageMenteeLevelGuide,
      builder: (context, state) => const MenteeLevelGuide(),
    ),
    GoRoute(
      path: Routes.mypageSupportDeveloper,
      builder: (context, state) => const SupportDeveloperScreen(),
    ),
    GoRoute(
      path: Routes.mypageProfileEdit,
      builder: (context, state) => const CommunityProfileEdit(),
    ),
    GoRoute(
      path: Routes.mypageRoulette,
      builder: (context, state) => const RouletteScreen(),
      routes: [
        GoRoute(
          path: Routes.mypageCoffeeExchangeRequest,
          builder: (context, state) => const CoffeeExchangeRequestScreen(),
        ),
      ],
    ),
    GoRoute(
      path: Routes.mypageDeleteAccount,
      builder: (context, state) => const DeleteAccountScreen(),
    ),
    GoRoute(
      path: Routes.mypageShopScreen,
      builder: (context, state) => const ShopScreen(),
      routes: [
        GoRoute(
          path: Routes.mypagePurchase,
          builder: (context, state) {
            final shopProductItem = state.extra as ShopProduct;
            return ShopPurchaseScreen(shopProductItem: shopProductItem);
          },
        ),
        GoRoute(
          path: Routes.mypagePurchaseHistory,
          builder: (context, state) => const PurchaseHistoryScreen(),
          routes: [
            GoRoute(
              path: Routes.mypageRefundDetail,
              builder: (context, state) {
                final item = state.extra as PurchaseList;
                return RefundDetail(item: item);
              },
            ),
          ],
        ),
        GoRoute(
          path: Routes.mypageWithdraw,
          builder: (context, state) => const WithdrawScreen(),
        ),
        GoRoute(
          path: Routes.mypageRoulette,
          builder: (context, state) => const RouletteScreen(),
          routes: [
            GoRoute(
              path: Routes.mypageCoffeeExchangeRequest,
              builder: (context, state) => const CoffeeExchangeRequestScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: Routes.mypageCertificationStatus,
      builder: (context, state) => const CertificationStatusScreen(),
      routes: [
        GoRoute(
          path: Routes.mypageCertificationEmail,
          builder: (context, state) => const CertificationEmailScreen(),
        ),
        GoRoute(
          path: Routes.mypageCertificationFile,
          builder: (context, state) => const CertificationUploadFileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: Routes.mypageBlockUsers,
      builder: (context, state) => const ManageBlockUsersScreen(),
    ),
    GoRoute(
      path: Routes.mypageContactSupport,
      builder: (context, state) => const ContactSupportScreen(),
      routes: [
        GoRoute(
          path: Routes.mypageContactSupportFaq,
          builder: (context, state) => const ContactSupportFaqScreen(),
        ),
      ],
    ),
  ],
);
