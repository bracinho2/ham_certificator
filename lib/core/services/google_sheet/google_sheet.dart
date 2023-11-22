import 'dart:convert';
import 'dart:developer';
import 'package:ham_certificator/core/services/google_sheet/remote_sheet.dart';

import 'package:http/http.dart' as http;

class GoogleSheetClient implements RemoteSheet {
  final urlBase = Uri.parse(
      'https://script.google.com/macros/s/AKfycbz-dPlE1Sw_wnI-YFLVDQLaezMdBnI4x1MsAAbLCQdNJu0v508Dwhy2qPTTHkEzQX79_Q/exec');

  @override
  Future<List<Map<String, dynamic>>> getData() async {
    try {
      final response = await http.post(
        urlBase,
        body: jsonKey,
      );

      if (response.statusCode == 200) {
        final values =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));

        return values;
      } else if (response.statusCode == 302) {
        var forward = response.headers['location'];

        await http.get(Uri.parse(forward!)).then((response) {
          final values =
              List<Map<String, dynamic>>.from(jsonDecode(response.body));

          return values;
        });
      }
      final values = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      return values;
    } catch (e) {
      log(e.toString());
      log(StackTrace.current.toString());
      return [];
    }
  }

  @override
  sendData({required Map<String, dynamic> data}) {
    throw UnimplementedError();
  }
}

final jsonKey = jsonEncode({
  "folder": "1pHaN8Dz_e7o7JuBFHJX8Y31alFMTWvPkgOgYyPMlaWk",
  "sheet": "certificados",
  "password": "password",
  "action": "read_certificates"
});
