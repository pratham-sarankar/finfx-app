// Flutter imports:
import 'package:finfx/features/brokers/presentation/providers/mt4_provider.dart';
import 'package:finfx/features/brokers/presentation/providers/mt5_provider.dart';
import 'package:finfx/features/brokers/data/services/platform_credentials_service.dart';
import 'package:finfx/features/bot/presentation/providers/signals_provider.dart';
import 'package:finfx/features/user_trades/presentation/providers/user_signals_provider.dart';
import 'package:finfx/features/subscriptions/presentation/providers/subscriptions_provider.dart';
import 'package:finfx/features/subscriptions/presentation/providers/bot_packages_provider.dart';
import 'package:finfx/features/subscriptions/data/services/bot_packages_service.dart';
import 'package:finfx/themes/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:deriv_chart/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:finfx/features/onboarding/data/repositories/kyc_repository_impl.dart';
import 'package:finfx/features/onboarding/presentation/providers/kyc_provider.dart';
import 'package:finfx/features/onboarding/presentation/splash/splash_screen.dart';
import 'package:finfx/features/home/presentation/providers/bot_provider.dart';
import 'package:finfx/features/user_trades/data/repositories/user_signals_repository_impl.dart';
import 'package:finfx/features/user_trades/data/services/user_signals_service.dart';
import 'firebase_options.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/auth_storage_service.dart';
import 'package:finfx/features/profile/presentation/providers/profile_provider.dart';
import 'package:finfx/features/profile/data/repositories/profile_repository_impl.dart';
import 'features/bot/data/services/bot_subscription_service.dart';
import 'features/bot/presentation/providers/bot_details_provider.dart';
import 'repositories/signal_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ThemeSwitcher(
      child: MultiProvider(
        providers: [
          Provider<AuthStorageService>(
            create: (_) => AuthStorageService(),
          ),
          Provider<ApiService>(
            create: (context) {
              const debugApiUrl = String.fromEnvironment('DEBUG_API_URL');
              const productionApiUrl =
                  String.fromEnvironment('PRODUCTION_API_URL');
              return ApiService(
                baseUrl: kDebugMode ? debugApiUrl : productionApiUrl,
                authStorage: context.read<AuthStorageService>(),
              );
            },
          ),
          Provider<PlatformCredentialsService>(
            create: (context) {
              return PlatformCredentialsService(
                apiService: context.read<ApiService>(),
              );
            },
          ),
          Provider<SignalRepository>(
            create: (context) {
              return SignalRepository(
                apiService: context.read<ApiService>(),
              );
            },
          ),
          Provider<BotSubscriptionService>(
            create: (context) {
              return BotSubscriptionService(
                apiService: context.read<ApiService>(),
              );
            },
          ),
          Provider<BotPackagesService>(
            create: (context) {
              return BotPackagesService(
                apiService: context.read<ApiService>(),
              );
            },
          ),
          Provider<AuthService>(
            create: (context) => AuthService(
              context.read<ApiService>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) {
              return ProfileProvider(
                ProfileRepositoryImpl(context.read<ApiService>()),
              );
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return MT5Provider(
                platformCredentialsService:
                    context.read<PlatformCredentialsService>(),
                authStorage: context.read<AuthStorageService>(),
                profileProvider: context.read<ProfileProvider>(),
              );
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return MT4Provider(
                platformCredentialsService:
                    context.read<PlatformCredentialsService>(),
                authStorage: context.read<AuthStorageService>(),
                profileProvider: context.read<ProfileProvider>(),
              );
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return SignalsProvider(
                signalRepository: context.read<SignalRepository>(),
              );
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return KYCProvider(KYCRepositoryImpl(context.read<ApiService>()));
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return BotProvider(
                context.read<ApiService>(),
              );
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return BotDetailsProvider(
                subscriptionService: context.read<BotSubscriptionService>(),
                apiService: context.read<ApiService>(),
              );
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return UserSignalsProvider(
                userSignalsRepository: UserSignalsRepositoryImpl(
                  userSignalsService: UserSignalsService(
                    apiService: context.read<ApiService>(),
                  ),
                ),
              );
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return SubscriptionsProvider(
                context.read<ApiService>(),
              );
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return BotPackagesProvider(
                botPackagesService: context.read<BotPackagesService>(),
              );
            },
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

/// Global theme switcher using ValueNotifier
class ThemeSwitcher extends StatefulWidget {
  final Widget child;
  static final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier(ThemeMode.dark);
  const ThemeSwitcher({super.key, required this.child});

  static ThemeMode get themeMode => themeModeNotifier.value;
  static setThemeMode(ThemeMode mode) => themeModeNotifier.value = mode;

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeSwitcher.themeModeNotifier,
      builder: (context, mode, _) {
        return InheritedThemeSwitcher(
          themeMode: mode,
          child: widget.child,
        );
      },
    );
  }
}

class InheritedThemeSwitcher extends InheritedWidget {
  final ThemeMode themeMode;
  const InheritedThemeSwitcher(
      {required this.themeMode, required Widget child, Key? key})
      : super(key: key, child: child);
  static InheritedThemeSwitcher? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedThemeSwitcher>();
  @override
  bool updateShouldNotify(covariant InheritedThemeSwitcher oldWidget) =>
      oldWidget.themeMode != themeMode;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode =
        InheritedThemeSwitcher.of(context)?.themeMode ?? ThemeMode.system;
    return MaterialApp(
      theme: MaterialTheme(TextTheme()).light(),
      darkTheme: MaterialTheme(TextTheme()).dark(),
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        ChartLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
      ],
      home: const Splash(),
    );
  }
}
