import 'package:get_it/get_it.dart';

import '../core/services/firebase/remote_storage_service_interface.dart';
import '../main.dart';
import 'controller/event_controller.dart';

void eventInjections() {
  getIt.registerLazySingleton(
      () => EventController(GetIt.I.get<RemoteStorage>()));
}
