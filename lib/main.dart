import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile/features/banners/bloc/banner_bloc.dart';
import 'package:mobile/features/banners/data/banners_repository.dart';
import 'package:mobile/features/brands/bloc/brand_bloc.dart';
import 'package:mobile/features/brands/data/brands_repository.dart';
import 'package:mobile/features/category/bloc/category_bloc.dart';
import 'package:mobile/features/category/data/category_repository.dart';
import 'package:mobile/features/favorite/bloc/favorite_bloc.dart';
import 'package:mobile/features/favorite/data/favorite_repository.dart';
import 'package:mobile/features/home/bloc/bottom_navigation_bloc.dart';
import 'package:mobile/features/products/data/product_repository.dart';
import 'package:mobile/features/reviews/bloc/reviews_bloc.dart';
import 'package:mobile/features/reviews/data/review_repository.dart';
import 'package:mobile/features/schools/bloc/schools_bloc.dart';
import 'package:mobile/features/schools/data/repositories/schools_repository.dart';

import 'core/bloc/main_bloc.dart';
import 'core/network/api_client.dart';
import 'core/network/interceptors/interceptors.dart';
import 'core/router/app_router.dart';
import 'core/services/push_notification_service.dart';
import 'core/storage/settings_storage.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final settingsStorage = SettingsStorage();
  final apiClient = ApiClient(settingsStorage: settingsStorage);

  final pushNotificationService = PushNotificationService(
    onToken: apiClient.registerPushToken,
  );
try {
    await pushNotificationService.initialize();
  } catch (e, stackTrace) {
    debugPrint('Push notification başlatma hatası: $e');
    debugPrint('$stackTrace');
  }

  runApp(
    MyApp(
      settingsStorage: settingsStorage,
      apiClient: apiClient,
      pushNotificationService: pushNotificationService,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsStorage,
    required this.apiClient,
    required this.pushNotificationService,
  });

  final SettingsStorage settingsStorage;
  final ApiClient apiClient;
  final PushNotificationService pushNotificationService;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // storage
        RepositoryProvider<SettingsStorage>.value(value: settingsStorage),

        // network dio
        RepositoryProvider<ApiClient>.value(value: apiClient),

        // push notification
        RepositoryProvider<PushNotificationService>.value(
          value: pushNotificationService,
        ),

        // schools
        RepositoryProvider(
          create: (context) => SchoolsRepository(dio: apiClient.dio),
        ),

        // category
        RepositoryProvider(
          create: (context) => CategoryRepository(dio: apiClient.dio),
        ),

        // brands
        RepositoryProvider(
          create: (context) => BrandsRepository(dio: apiClient.dio),
        ),

        // favorite
        RepositoryProvider(
          create: (context) =>
              FavoriteRepository(dio: apiClient.dio, storage: settingsStorage),
        ),

        // review
        RepositoryProvider(
          create: (context) =>
              ReviewRepository(dio: apiClient.dio, storage: settingsStorage),
        ),
        // banners
        RepositoryProvider(
          create: (context) => BannersRepository(dio: apiClient.dio),
        ),

        // products
        RepositoryProvider(
          create: (context) => ProductRepository(dio: apiClient.dio),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // main settings app
          BlocProvider<MainBloc>(
            create: (context) => MainBloc(context.read<SettingsStorage>()),
          ),

          // schools
          BlocProvider(
            create: (context) => SchoolsBloc(
              schoolsRepository: context.read<SchoolsRepository>(),
            ),
          ),

          // bottom navigation visible / invisible
          BlocProvider(create: (context) => BottomNavigationBloc()),

          // category bloc
          BlocProvider(
            create: (context) => CategoryBloc(
              categoryRepository: context.read<CategoryRepository>(),
            )..add(LoadCategoriesEvent()),
          ),

          // brands bloc
          BlocProvider(
            create: (context) =>
                BrandBloc(brandsRepository: context.read<BrandsRepository>()),
          ),

          // favorite bloc
          BlocProvider(
            create: (context) => FavoriteBloc(
              favoriteRepository: context.read<FavoriteRepository>(),
            )..add(const LoadFavorites()),
          ),

          // review bloc
          BlocProvider(
            create: (context) =>
                ReviewsBloc(reviewRepository: context.read<ReviewRepository>()),
          ),
          // banners bloc
          BlocProvider(
            create: (context) => BannerBloc(
              bannersRepository: context.read<BannersRepository>(),
            ),
          ),
        ],
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            return MaterialApp.router(
              scaffoldMessengerKey: scaffoldMessengerKey,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: state.themeMode,
              locale: state.locale,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              routerConfig: appRouter,
            );
          },
        ),
      ),
    );
  }
}
