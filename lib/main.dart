import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'apps/core/i18n/strings.g.dart';
import 'apps/core/router/app_router.dart';
import 'apps/core/themes/app_theme.dart';

void main() {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Draw edge-to-edge so the app body fills the whole device screen
  // (behind the status bar and navigation bar).
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Keep the native splash on screen until the first Flutter frame is ready
  // (the SplashScreen calls `FlutterNativeSplash.remove()`).
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(TranslationProvider(child: const DoctorHuntApp()));
}

class DoctorHuntApp extends StatelessWidget {
  const DoctorHuntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: t.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // slang owns the locale: TranslationProvider rebuilds the whole tree on
      // change, and `onLocaleChanged` flips text direction with it.
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      routerConfig: AppRouter.router,
    );
  }
}
