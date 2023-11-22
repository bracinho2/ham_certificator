import 'package:flutter/material.dart';

import '../../core/enums/event_type_enum.dart';
import '../../core/services/firebase/remote_storage_service_interface.dart';
import '../model/event_model.dart';
import '../view/states/event_states.dart';

class EventController extends ValueNotifier<EventState> {
  EventController(this.firebaseRemoteStorage) : super(EventLoadingState());

  final RemoteStorage firebaseRemoteStorage;

  void init() async {
    await getEvents();
    //await createEvent();
  }

  Future<void> getEvents() async {
    final results = await firebaseRemoteStorage.getAllFromCollection(
        collectionPath: 'events');

    final events = results.map((e) => EventModel.fromMap(e)).toList();

    value = EventSuccessState(events);
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
    );

    await firebaseRemoteStorage.addItem(
      map: event.toMap(),
      collectionPath: 'events',
    );
  }
}
