import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'core/pages/splash_page.dart';
import 'home_page/presenter/facade/home_page_facade.dart';
import 'home_page/presenter/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: const Locale(
        'pt',
      ),
      debugShowCheckedModeBanner: false,
      title: 'HamCertificator',
      //scaffoldMessengerKey: SnackBarManager.snackKey,
      theme: ThemeData(),
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
      routes: const [
        // GoRoute(
        //   path: 'pokemons',
        //   builder: (context, state) => PokemonPage(
        //     store: context.read(),
        //   ),
        // ),
      ],
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(
        facade: GetIt.I.get<HomePageFacade>(),
      ),
      routes: const [
        // GoRoute(
        //   path: 'pdf_preview',
        //   name: 'pdf_preview',
        //   builder: (context, state) {
        //     return const PDFPreviewWidget();
        //   },
        // ),
      ],
    ),
  ],
);
