import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';
import 'services/firebase/firebase_remote_storage_service.dart';
import 'services/firebase/remote_storage_service_interface.dart';
import 'services/google_sheet/google_sheet.dart';
import 'services/google_sheet/remote_sheet.dart';

void coreInjections() {
  getIt.registerLazySingleton<RemoteStorage>(
      () => FirebaseRemoteStorage(FirebaseFirestore.instance));
  getIt.registerLazySingleton<RemoteSheet>(() => GoogleSheetClient());
}
