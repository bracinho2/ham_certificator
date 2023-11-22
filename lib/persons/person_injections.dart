import 'package:get_it/get_it.dart';
import '../core/services/firebase/remote_storage_service_interface.dart';
import '../core/services/google_sheet/remote_sheet.dart';
import '../main.dart';
import 'controller/person_controller.dart';

void personInjections() {
  getIt.registerLazySingleton(
    () => PersonController(
        GetIt.I.get<RemoteSheet>(), GetIt.I.get<RemoteStorage>()),
  );
}
