abstract class RemoteSheet {
  Future<List<Map<String, dynamic>>> getData();
  Future<bool> sendData({required Map<String, dynamic> data});
}
