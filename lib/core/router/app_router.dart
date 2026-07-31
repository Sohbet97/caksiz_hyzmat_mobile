import 'package:go_router/go_router.dart';
import 'package:mobile/features/home/presentation/home_screen.dart';
import 'package:mobile/features/splasch/presentation/splash_screen.dart';
import 'package:mobile/features/settings/presentation/settings_page.dart';
import 'package:mobile/features/auth/presentation/auth_page.dart';

import '../widgets/placeholder_page_widget.dart';
import '../../generated/l10n.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const settings = '/settings';
  static const auth = '/auth';
  static const orders = '/orders';
  static const messages = '/messages';
  static const favorites = '/favorites';
  static const coupons = '/coupons';
  static const support = '/support';
  static const okuwlar = '/okuwlar';
  static const viewed = '/viewed';
  static const addresses = '/addresses';
  static const following = '/following';
  static const cargo = '/cargo';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: AppRoutes.auth,
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: AppRoutes.orders,
      builder: (context, state) =>
          PlaceholderPageWidget(title: S.of(context).personOrders),
    ),
    GoRoute(
      path: AppRoutes.messages,
      builder: (context, state) =>
          PlaceholderPageWidget(title: S.of(context).personMessages),
    ),
    GoRoute(
      path: AppRoutes.favorites,
      builder: (context, state) =>
          PlaceholderPageWidget(title: S.of(context).personCoupons),
    ),
    GoRoute(
      path: AppRoutes.coupons,
      builder: (context, state) =>
          PlaceholderPageWidget(title: S.of(context).personBalance),
    ),
    GoRoute(
      path: AppRoutes.support,
      builder: (context, state) =>
          PlaceholderPageWidget(title: S.of(context).personSupport),
    ),
    GoRoute(
      path: AppRoutes.okuwlar,
      builder: (context, state) =>
          PlaceholderPageWidget(title: S.of(context).personReviews),
    ),
    GoRoute(
      path: AppRoutes.viewed,
      builder: (context, state) =>
          PlaceholderPageWidget(title: S.of(context).personHistory),
    ),
    GoRoute(
      path: AppRoutes.addresses,
      builder: (context, state) =>
          PlaceholderPageWidget(title: S.of(context).personAddresses),
    ),
    GoRoute(
      path: AppRoutes.following,
      builder: (context, state) =>
          PlaceholderPageWidget(title: S.of(context).personFollowing),
    ),
    GoRoute(
      path: AppRoutes.cargo,
      builder: (context, state) =>
          PlaceholderPageWidget(title: S.of(context).personKargo),
    ),
  ],
);
