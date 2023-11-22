import 'package:get_it/get_it.dart';
import 'package:ham_certificator/home_page/presenter/facade/home_page_facade.dart';

import '../events/controller/event_controller.dart';
import '../main.dart';
import '../persons/controller/person_controller.dart';

void homePageInjections() {
  getIt.registerLazySingleton(
    () => HomePageFacade(
      eventController: GetIt.I.get<EventController>(),
      personController: GetIt.I.get<PersonController>(),
    ),
  );
}
