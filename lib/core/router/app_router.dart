import 'package:go_router/go_router.dart';
import 'package:mobile/features/home/presentation/home_screen.dart';
import 'package:mobile/features/splasch/presentation/splash_screen.dart';
import 'package:mobile/features/settings/presentation/settings_page.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const settings = '/settings';
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
  ],
);
