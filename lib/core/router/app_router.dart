import 'package:go_router/go_router.dart';
import 'package:mobile/features/category/models/category_model.dart';
import 'package:mobile/features/category/presentation/category_detail_screen.dart';
import 'package:mobile/features/home/presentation/home_screen.dart';
import 'package:mobile/features/products/presentation/product_search_screen.dart';
import 'package:mobile/features/splasch/presentation/splash_screen.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const categoryDetail = '/categoryDetail';
  static const productSearchScreen = '/productSearch';
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

    // category Detail
    GoRoute(
      path: AppRoutes.categoryDetail,
      builder: (context, state) {
        final model = state.extra as CategoryModel;
        return CategoryDetailScreen(model: model);
      },
    ),

    // product search screen
    GoRoute(
      path: AppRoutes.productSearchScreen,
      builder: (context, state) => const ProductSearchScreen(),
    ),
  ],
);
