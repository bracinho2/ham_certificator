import 'package:get_it/get_it.dart';
import 'package:ham_certificator/core/services/firebase/remote_storage_service_interface.dart';
import 'package:ham_certificator/home_page/presenter/controller/home_page_controller.dart';

import '../main.dart';

void homePageInjections() {
  getIt.registerLazySingleton(
    () => HomePageController(GetIt.I.get<RemoteStorage>()),
  );
}
