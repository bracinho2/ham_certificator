import 'package:get_it/get_it.dart';
import '../core/services/firebase/remote_storage_service_interface.dart';
import '../main.dart';
import 'controller/participation_controller.dart';

void certificatesInjections() {
  getIt.registerLazySingleton(
    () => ParticipationController(GetIt.I.get<RemoteStorage>()),
  );
}
