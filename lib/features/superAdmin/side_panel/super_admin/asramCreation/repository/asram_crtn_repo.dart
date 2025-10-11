import 'dart:convert';
import 'package:accomodation_admin/services/api_constants.dart';
import 'package:accomodation_admin/services/network_adapter.dart';

class AsramRepo {
  static Future<Map<String, dynamic>> create(
      Map<String, dynamic> payload) async {
    late Map<String, dynamic> response;

    await BaseClient.shared.safeApiCall(
      ApiConstants.asramCreate,
      RequestType.post,
      includeAuth: true,
      data: jsonEncode(payload),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "client": "OMS",
      },
      onSuccess: (s) {
        // ensure we parse string to Map
        if (s.rawResponse is String) {
          response = jsonDecode(s.rawResponse);
        } else if (s.rawResponse is Map<String, dynamic>) {
          response = s.rawResponse;
        } else {
          throw Exception("Unexpected response format");
        }
      },
      onError: (s) {
        s.fold((ld) => throw ld, (r) => throw r);
      },
    );
    return response;
  }

  /// ✅ GET List of Asrams (Fixed parsing)
  static Future<Map<String, dynamic>> getList() async {
    late Map<String, dynamic> response;

    await BaseClient.shared.safeApiCall(
      ApiConstants.asramList,
      RequestType.get,
      includeAuth: true,
      headers: {
        "Accept": "application/json",
        "client": "OMS",
      },
      onSuccess: (s) {
        // Fix: parse string JSON response
        if (s.rawResponse is String) {
          response = jsonDecode(s.rawResponse);
        } else if (s.rawResponse is Map<String, dynamic>) {
          response = s.rawResponse;
        } else {
          throw Exception("Unexpected response format");
        }
      },
      onError: (s) {
        s.fold((ld) => throw ld, (r) => throw r);
      },
    );

    return response;
  }
}
