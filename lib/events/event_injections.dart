import 'package:get_it/get_it.dart';
import 'package:ham_certificator/events/view/pages/controller/event_page_controller.dart';

import '../core/services/firebase/remote_storage_service_interface.dart';
import '../main.dart';

void eventInjections() {
  getIt.registerLazySingleton(
    () => EventPageController(
      GetIt.I.get<RemoteStorage>(),
    ),
  );
}
