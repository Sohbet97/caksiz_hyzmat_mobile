import 'package:go_router/go_router.dart';
import 'package:mobile/features/home/presentation/home_screen.dart';
import 'package:mobile/features/splasch/presentation/splash_screen.dart';

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
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
