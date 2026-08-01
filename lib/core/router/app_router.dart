import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/brands/presentation/brands_screen.dart';
import 'package:mobile/features/category/models/category_model.dart';
import 'package:mobile/features/category/presentation/category_detail_screen.dart';
import 'package:mobile/features/home/presentation/home_screen.dart';
import 'package:mobile/features/schools/bloc/school_detail_bloc.dart';
import 'package:mobile/features/schools/data/models/school_model.dart';
import 'package:mobile/features/schools/data/repositories/schools_repository.dart';
import 'package:mobile/features/schools/presentation/school_detail_screen.dart';
import 'package:mobile/features/schools/presentation/schools_screen.dart';
import 'package:mobile/features/products/presentation/product_search_screen.dart';
import 'package:mobile/features/splasch/presentation/splash_screen.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const categoryDetail = '/categoryDetail';
  static const schools = '/schools';
  static const schoolDetails = '/schoolDetailScreen';
  static const productSearchScreen = '/productSearch';
  static const brandsScreen = '/brands';
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
  ],
);
