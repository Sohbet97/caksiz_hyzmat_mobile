import 'package:go_router/go_router.dart';
import 'package:mobile/features/splasch/presentation/splash_screen.dart';

import '../../features/home/presentation/home_page.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const home = '/home';
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
      builder: (context, state) =>
          const HomePage(title: 'Flutter Demo Home Page'),
    ),
  ],
);
