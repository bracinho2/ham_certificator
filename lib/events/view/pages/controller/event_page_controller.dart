import 'package:flutter/material.dart';

import '../../../../core/enums/event_type_enum.dart';
import '../../../../core/services/firebase/remote_storage_service_interface.dart';
import '../../../model/event_model.dart';
import '../state/event_state_page.dart';

class EventPageController extends ValueNotifier<EventPageState> {
  EventPageController(
    this.firebaseRemoteStorage,
  ) : super(EventPageLoadingState());

  final RemoteStorage firebaseRemoteStorage;

  Future<void> getEvent({
    required String uid,
  }) async {
    final result =
        await firebaseRemoteStorage.getByID(id: uid, collectionPath: 'events');
    final event = EventModel.fromMap(result);
    value = EventPageSuccessState(event: event);
  }

  Future<void> createEvent() async {
    final event = EventModel(
      uid: '',
      name: 'VI Encontro de Radioamadores de Sulina',
      description:
          'Um encontro anual de Veraneio dos Radioamadores Brasileiros',
      owner: 'PY5TH & Família',
      location: 'Sulina - Paraná - Brasil',
      type: EventTypeEnum.party,
      startAt: DateTime.fromMillisecondsSinceEpoch(1706313600000),
      endAt: DateTime.fromMillisecondsSinceEpoch(1706400000000),
      city: 'Sulina',
      state: 'Paraná',
      country: 'Brasil',
      imageUrl: '',
      hasAvailableCertificates: false,
      hasPageDetails: false,
      price: '',
      language: 'Português',
      contact: '',
      hasCertification: true,
    );

    await firebaseRemoteStorage.addItem(
      map: event.toMap(),
      collectionPath: 'events',
    );
  }
}
