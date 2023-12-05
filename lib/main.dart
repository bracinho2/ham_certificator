import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app_widget.dart';
import 'core/core_injections.dart';
import 'firebase_options.dart';

import 'events/event_injections.dart';
import 'home_page/home_page_injections.dart';
import 'i18n/config/available_language_controller.dart';
import 'participations/participation_injections.dart';
import 'persons/person_injections.dart';

final getIt = GetIt.instance;

void main() async {
  //Iniciar Firebase;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  personInjections();
  coreInjections();
  //setupInjection();
  homePageInjections();
  eventInjections();
  certificatesInjections();

  getIt.registerLazySingleton(
    () => LanguageController(),
  );

  runApp(
    MyApp(
      languageController: GetIt.I.get<LanguageController>(),
    ),
  );
}
