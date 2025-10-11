// repositories/room_category_repo.dart

// Make sure these import paths match your project structure.
import 'package:accomodation_admin/services/api_constants.dart';
import 'package:accomodation_admin/services/network_adapter.dart';

/// Repository for handling all API calls related to Room Categories.
class RoomCategoryRepo {
  /// Method to fetch the list of Asrams from the API.
  static Future<Map<String, dynamic>> getAsrams() async {
    late Map<String, dynamic> response;

    await BaseClient.shared.safeApiCall(
      ApiConstants.asramList, // Your GET API endpoint for asrams
      RequestType.get,
      includeAuth: true,
      onSuccess: (s) {
        // This is the expected path for a successful API call.
        // We add a check to ensure the response data is not null.
        if (s?.rawResponse == null) {
          throw 'Success callback received null data from safeApiCall.';
        }
        response = s.rawResponse;
      },
      onError: (s) {
        // This block was being called incorrectly by safeApiCall in your case.
        // The defensive code below prevents a crash from a null error object.
        if (s == null) {
          throw 'safeApiCall triggered onError with a null object despite a 200 OK response. Please check your BaseClient implementation for bugs.';
        }

        // If 's' is not null, attempt to extract the error from it.
        try {
          s.fold(
              (leftError) => throw leftError, (rightError) => throw rightError);
        } catch (e) {
          throw 'Failed to parse error from safeApiCall. Original error: ${e.toString()}';
        }
      },
    );

    return response;
  }

  /// Method to create a new Room Category via the API.
  static Future<Map<String, dynamic>> createRoomCategory(
      Map<String, dynamic> payload) async {
    late Map<String, dynamic> response;

    await BaseClient.shared.safeApiCall(
      ApiConstants
          .roomCatCreate, // Your POST API endpoint for creating a category
      RequestType.post,
      includeAuth: true,
      data: payload,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      onSuccess: (s) {
        if (s?.rawResponse == null) {
          throw 'Success callback received null data from safeApiCall.';
        }
        response = s.rawResponse;
      },
      onError: (s) {
        if (s == null) {
          throw 'safeApiCall triggered onError with a null object. Please check your BaseClient implementation.';
        }
        // This assumes the error object 's' will be valid in a real error scenario.
        s.fold(
            (leftError) => throw leftError, (rightError) => throw rightError);
      },
    );

    return response;
  }
}
