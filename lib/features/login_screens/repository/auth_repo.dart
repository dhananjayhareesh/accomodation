import 'dart:convert';

import 'package:accomodation_admin/services/api_constants.dart';
import 'package:accomodation_admin/services/network_adapter.dart';

class AuthenticationRepo {
  static Future<Map<String, dynamic>> login(
      Map<String, dynamic> payload) async {
    late Map<String, dynamic> response;

    await BaseClient.shared.safeApiCall(
      ApiConstants.suLogin,
      RequestType.post,
      includeAuth: false,
      data: jsonEncode(payload),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "client": "OMS",
      },
      onSuccess: (s) {
        response = s.rawResponse;
      },
      onError: (s) {
        s.fold((ld) {
          throw ld;
        }, (r) {
          throw r;
        });
      },
    );

    return response;
  }
}
