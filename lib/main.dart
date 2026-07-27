import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/bloc/main_bloc.dart';
import 'core/network/api_client.dart';
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
  await pushNotificationService.initialize();

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
      ],
      child: MultiBlocProvider(
        providers: [
          // main settings app
          BlocProvider<MainBloc>(
            create: (context) => MainBloc(context.read<SettingsStorage>()),
          ),
        ],
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            return MaterialApp.router(
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
