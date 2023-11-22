import '../../core/services/firebase/remote_storage_service_interface.dart';
import '../../core/services/google_sheet/remote_sheet.dart';
import '../model/person_from_sheet_model.dart';

class PersonController {
  PersonController(
    this.remoteSheet,
    this.remoteStorage,
  );

  final RemoteSheet remoteSheet;
  final RemoteStorage remoteStorage;

  Future<void> init() async {
    //await addPersonToRemoteStorage();
    // await remoteStorage.removeSubCollectionAllItems(
    //     documentUID: 'H32VxH4evpq6XPdAw4FG',
    //     collectionPath: 'events',
    //     subcollectionPath: 'participations');
  }

  Future<void> addPersonToRemoteStorage() async {
    final sheetData = await _getPersonFromSheet();

    for (int i = 0; i < sheetData.length; i++) {
      var p = sheetData[i];
      remoteStorage.addItemIntoSubCollection(
        collectionPath: 'events',
        documentUID: 'aw4xNZMTxsadKi9gG3ip',
        subcollectionPath: 'participations',
        map: {
          'callsign': p.callsign,
          'name': p.name,
          'city': p.city,
          'state': p.state,
          'country': p.country,
        },
      );
      print('$i > ${p.name}');
    }
  }

  Future<List<PersonFromSheetModel>> _getPersonFromSheet() async {
    final result = await remoteSheet.getData();
    return result.map((map) => PersonFromSheetModel.fromMap(map)).toList();
  }
}
