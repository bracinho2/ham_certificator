import 'package:flutter/material.dart';
import 'package:ham_certificator/core/services/firebase/remote_storage_service_interface.dart';

import '../../../core/enums/ham_certificator_storage_collections.dart';
import '../../../events/model/event_model.dart';
import '../states/home_page_state.dart';

class HomePageController extends ValueNotifier<HomePageState> {
  HomePageController(this._remoteStorage) : super(HomePageLoadingState());

  final RemoteStorage _remoteStorage;

  Future<void> init() async {
    await _fetch();
  }

  Future<void> _fetch() async {
    await _remoteStorage
        .getAllFromCollection(
            collectionPath: HamCertificatorStorageCollectionsENUM.events.value)
        .then(
          (events) => value = HomePageSuccessState(
            events: events.map((map) => EventModel.fromMap(map)).toList(),
          ),
        );
  }
}
