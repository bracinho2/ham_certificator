import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:guarani/guarani.dart';
import 'package:ham_certificator/admin/view/admin_login_page.dart';
import 'package:ham_certificator/events/view/pages/event_page.dart';
import 'package:ham_certificator/home_page/presenter/controller/home_page_controller.dart';
import 'package:localization/localization.dart';
import 'core/pages/splash_page.dart';

import 'home_page/presenter/pages/home_page.dart';
import 'i18n/config/available_language_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.languageController,
  });

  final LanguageController languageController;

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    return ValueListenableBuilder(
      valueListenable: languageController,
      builder: (context, language, _) {
        return MaterialApp.router(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            LocalJsonLocalization.delegate,
            MapLocalization.delegate,
          ],

          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale!.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          locale: language.locale,
          supportedLocales: const [
            Locale('pt', 'BR'),
            Locale('es', 'PY'),
            Locale('es', 'AR'),
          ],

          debugShowCheckedModeBanner: false,
          title: 'HamCertificator',
          //scaffoldMessengerKey: SnackBarManager.snackKey,
          theme: ThemeData(
            extensions: [
              guaraniStyles,
            ],
          ),
          routerConfig: _router,
        );
      },
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, _) => const SplashPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, _) => HomePage(
        controller: GetIt.I.get<HomePageController>(),
      ),
      routes: [
        GoRoute(
          path: 'event/:uid',
          builder: (context, state) =>
              EventPage(uid: state.pathParameters['uid']!),
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, _) => const AdminLoginPage(),
    ),
  ],
);
