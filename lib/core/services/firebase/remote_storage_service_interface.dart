abstract class RemoteStorage {
  Future<List<Map<String, dynamic>>> getAllFromCollection({
    required String collectionPath,
  });

  Future<List<Map<String, dynamic>>> getAllFromSubcollection({
    required String collectionPath,
    required String documentUID,
    required String subcollectionPath,
  });

  Future<List<Map<String, dynamic>>> getAllFromCollectionWithSubcollection({
    required String collectionPath,
    required String subcollectionPath,
  });

  Future<Map<String, dynamic>?> getByID({
    required String id,
    required String collectionPath,
  });

  Future<List<Map<String, dynamic>>> getByFilters({
    required String collectionPath,
    required String manufacturer,
    required String model,
    required String year,
  });

  Future<Map<String, dynamic>> searchResult({
    required String collectionPath,
    required String name,
    required String value,
  });

  Future<bool> addItem({
    required Map<String, dynamic> map,
    required String collectionPath,
  });

  Future<bool> updateItem({
    required Map<String, dynamic> map,
    required String collectionPath,
  });
  Future<bool> removeItem({
    required String uid,
    required String collectionPath,
  });

  Future<Map<String, dynamic>> login({
    required Map<String, dynamic> map,
    required String collectionPath,
  });

  Future<bool> removeAllItems({
    required String collectionPath,
  });

  Future<bool> removeSubCollectionAllItems({
    required String documentUID,
    required String collectionPath,
    required String subcollectionPath,
  });

  Future<bool> addItemIntoSubCollection({
    required String collectionPath,
    required String documentUID,
    required String subcollectionPath,
    required Map<String, dynamic> map,
  });
}
