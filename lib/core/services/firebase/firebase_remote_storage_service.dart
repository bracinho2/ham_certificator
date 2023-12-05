import 'package:cloud_firestore/cloud_firestore.dart';

import 'remote_storage_service_interface.dart';

class FirebaseRemoteStorage implements RemoteStorage {
  final FirebaseFirestore _firestore;

  FirebaseRemoteStorage(this._firestore);

  @override
  Future<bool> addItem(
      {required Map<String, dynamic> map,
      required String collectionPath}) async {
    map.remove('uid');
    await _firestore.collection(collectionPath).add(map);

    return true;
  }

  @override
  Future<bool> removeItem(
      {required String uid, required String collectionPath}) async {
    await _firestore.collection(collectionPath).doc(uid).update({
      "active": false,
    });

    return true;
  }

  @override
  Future<bool> updateItem(
      {required Map<String, dynamic> map,
      required String collectionPath}) async {
    final uid = map['uid'];
    map.remove('uid');
    await _firestore.collection(collectionPath).doc(uid).update(map);

    return true;
  }

  @override
  Future<Map<String, dynamic>> getByID({
    required String id,
    required String collectionPath,
  }) async {
    final response = await _firestore.collection(collectionPath).doc(id).get();
    final map = {
      'uid': response.reference.id,
      ...?response.data(),
    };

    return map;
  }

  @override
  Future<List<Map<String, dynamic>>> getByFilters({
    required String collectionPath,
    required String manufacturer,
    required String model,
    required String year,
  }) async {
    final response = await _firestore
        .collection(collectionPath)
        .where('manufacturer', isEqualTo: manufacturer)
        .where('model', isEqualTo: model)
        .where('year', isEqualTo: year)
        .get();

    final lista = response.docs.map((doc) {
      final map = {
        'uid': doc.reference.id,
        ...doc.data(),
      };

      return map;
    }).toList();

    return lista;
  }

  @override
  Future<Map<String, dynamic>> searchResult(
      {required String collectionPath,
      required String name,
      required String value}) async {
    final response = await _firestore
        .collection(collectionPath)
        .where(name, isEqualTo: value)
        .where('manufacturer', isEqualTo: 'toyota')
        .get();
    final map = {
      'uid': response.docs.first.id,
      ...response.docs.first.data(),
    };

    return map;
  }

  @override
  Future<Map<String, dynamic>> login(
      {required Map<String, dynamic> map,
      required String collectionPath}) async {
    final response = await _firestore
        .collection(collectionPath)
        .where('email', isEqualTo: map['email'])
        .where('password', isEqualTo: map['password'])
        .limit(1)
        .get();

    final user = response.docs
        .map((doc) => {
              'uid': doc.reference.id,
              ...doc.data(),
            })
        .first;

    return user;
  }

  @override
  Future<bool> removeSubCollectionAllItems({
    required String documentUID,
    required String collectionPath,
    required String subcollectionPath,
  }) async {
    final subcollection = await _firestore
        .collection(collectionPath)
        .doc(documentUID)
        .collection(subcollectionPath)
        .get();

    for (final doc in subcollection.docs) {
      doc.reference.delete();
    }

    return true;
  }

  @override
  Future<bool> removeAllItems({
    required String collectionPath,
  }) async {
    final collection =
        await FirebaseFirestore.instance.collection(collectionPath).get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }

    batch.commit();
    return true;
  }

  @override
  Future<bool> addItemIntoSubCollection({
    required String collectionPath,
    required String documentUID,
    required String subcollectionPath,
    required Map<String, dynamic> map,
  }) async {
    map.remove('uid');
    await _firestore
        .collection(collectionPath)
        .doc(documentUID)
        .collection(subcollectionPath)
        .add(map);

    return true;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllFromCollectionWithSubcollection({
    required String collectionPath,
    required String subcollectionPath,
  }) async {
    final response = await _firestore.collection(collectionPath).get();

    final lista = response.docs.map((doc) async {
      final participations =
          await doc.reference.collection(subcollectionPath).get();

      final map = {
        'uid': doc.reference.id,
        ...doc.data(),
        'participations': participations.docs
            .map((doc) => {
                  ...doc.data(),
                })
            .toList(),
      };

      return map;
    }).toList();

    return Future.wait(lista);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllFromCollection({
    required String collectionPath,
  }) async {
    final response = await _firestore.collection(collectionPath).get();

    final list = response.docs
        .map((doc) => {
              'uid': doc.reference.id,
              ...doc.data(),
            })
        .toList();

    return list;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllFromSubcollection({
    required String collectionPath,
    required String documentUID,
    required String subcollectionPath,
  }) async {
    final response = await _firestore
        .collection(collectionPath)
        .doc(documentUID)
        .collection(subcollectionPath)
        .get();
    final list = response.docs
        .map((doc) => {
              'uid': doc.reference.id,
              ...doc.data(),
            })
        .toList();

    return list;
  }
}
