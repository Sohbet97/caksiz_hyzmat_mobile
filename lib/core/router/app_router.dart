import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/banners/model/banner_model.dart';
import 'package:mobile/features/banners/presentation/banner_detail_screen.dart';
import 'package:mobile/features/brands/presentation/brands_screen.dart';
import 'package:mobile/features/category/models/category_model.dart';
import 'package:mobile/features/category/presentation/category_detail_screen.dart';
import 'package:mobile/features/favorite/presentation/favorites_screen.dart';
import 'package:mobile/features/home/presentation/home_screen.dart';
import 'package:mobile/features/orders/presentation/orders_screen.dart';
import 'package:mobile/features/reviews/presentation/reviews_screen.dart';
import 'package:mobile/features/schools/bloc/school_detail_bloc.dart';
import 'package:mobile/features/schools/data/models/school_model.dart';
import 'package:mobile/features/schools/data/repositories/schools_repository.dart';
import 'package:mobile/features/schools/presentation/school_detail_screen.dart';
import 'package:mobile/features/schools/presentation/schools_screen.dart';
import 'package:mobile/features/products/presentation/product_search_screen.dart';
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
  static const categoryDetail = '/categoryDetail';
  static const schools = '/schools';
  static const schoolDetails = '/schoolDetailScreen';
  static const productSearchScreen = '/productSearch';
  static const brandsScreen = '/brands';
  static const reviews = '/reviews';
  static const bannerDetail = '/bannerDetail';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    // splash screen
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),

    // home screen
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

    // category Detail
    GoRoute(
      path: AppRoutes.categoryDetail,
      builder: (context, state) {
        final model = state.extra as CategoryModel;
        return CategoryDetailScreen(model: model);
      },
    ),

    // schools screen
    GoRoute(
      path: AppRoutes.schools,
      builder: (context, state) => const SchoolsScreen(),
    ),

    // schoolsDetailScreen
    GoRoute(
      path: AppRoutes.schoolDetails,
      builder: (context, state) {
        final model = state.extra as SchoolModel;
        return BlocProvider(
          create: (context) => SchoolDetailBloc(
            schoolsRepository: context.read<SchoolsRepository>(),
          )..add(GetSchoolDetailEvent(schoolId: model.id)),
          child: SchoolDetailScreen(schoolModel: model),
        );
      },
    ),
    // product search screen
    GoRoute(
      path: AppRoutes.productSearchScreen,
      builder: (context, state) => const ProductSearchScreen(),
    ),

    // brands screen
    GoRoute(
      path: AppRoutes.brandsScreen,
      builder: (context, state) => const BrandsScreen(),
    ),

    // favorites
    GoRoute(
      path: AppRoutes.favorites,
      builder: (context, state) => const FavoritesScreen(),
    ),

    GoRoute(
      path: AppRoutes.reviews,
      builder: (context, state) => const ReviewsScreen(),
    ),

    GoRoute(
      path: AppRoutes.orders,
      builder: (context, state) => const OrdersScreen(),
    ),
    // banner detail screen
    GoRoute(
      path: AppRoutes.bannerDetail,
      builder: (context, state) {
        final banner = state.extra as BannerModel;
        return BannerDetailScreen(banner: banner);
      },
    ),
  ],
);
