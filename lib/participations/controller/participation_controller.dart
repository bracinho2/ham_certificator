import 'package:flutter/foundation.dart';

import '../../core/services/firebase/remote_storage_service_interface.dart';
import '../model/participation_model.dart';
import '../view/states/participation_state.dart';

class ParticipationController extends ValueNotifier<ParticipationState> {
  ParticipationController(this.remoteStorage)
      : super(ParticipationLoadingState());

  final RemoteStorage remoteStorage;

  void getParticipations({
    required String eventUID,
  }) async {
    final result = await remoteStorage.getAllFromSubcollection(
        collectionPath: 'events',
        documentUID: eventUID,
        subcollectionPath: 'participations');
    final participations =
        result.map((map) => ParticipationModel.fromMap(map)).toList();

    participations.sort(
      (a, b) => a.name.compareTo(b.name),
    );

    value = ParticipationSuccessState(
      participations: participations,
    );
  }
}
