import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../core/theme/app_theme.dart';
import '../core/constants/app_constants.dart';
import 'router/app_router.dart';

class InventoryApp extends ConsumerWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const InventoryApp({
    super.key,
    this.savedThemeMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    
    return AdaptiveTheme(
      light: AppTheme.lightTheme(),
      dark: AppTheme.darkTheme(),
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp.router(
        title: AppConstants.appName,
        theme: theme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('es', 'ES'),
          Locale('fr', 'FR'),
          Locale('de', 'DE'),
          Locale('it', 'IT'),
          Locale('pt', 'BR'),
          Locale('ru', 'RU'),
          Locale('zh', 'CN'),
          Locale('ja', 'JP'),
          Locale('ar', 'SA'),
        ],
        builder: (context, child) {
          // Limit text scale factor to prevent UI breaking
          final mediaQuery = MediaQuery.of(context);
          final currentTextScaleFactor = mediaQuery.textScaler.scale(1.0);
          final constrainedTextScaleFactor = currentTextScaleFactor.clamp(0.8, 1.3);
          
          return MediaQuery(
            data: mediaQuery.copyWith(
              textScaler: TextScaler.linear(constrainedTextScaleFactor),
            ),
            child: child!,
          );
        },
      ),
    );
  }
}

// App router provider
final appRouterProvider = Provider<GoRouter>((ref) {
  return AppRouter.router(ref);
});