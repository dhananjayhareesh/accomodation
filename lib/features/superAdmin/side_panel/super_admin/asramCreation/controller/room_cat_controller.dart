// controllers/room_category_controller.dart

import 'dart:developer';

import 'package:accomodation_admin/components/custom_widgets/dialog_and_toast/custom_snackbar.dart';
import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/asramCreation/repository/room_cat_repo.dart';
import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/model/asrrm_cat_list_model.dart';
import 'package:get/get.dart';
// Import your custom toast utility

class RoomCategoryController extends GetxController {
  // Observables for loading states
  final isLoadingAsrams = true.obs;
  final isCreatingCategory = false.obs;

  // Observable list to hold Asram data
  final asramList = <AsramData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAsrams();
  }

  // Fetch Asrams from the API
  // Fetch Asrams from the API
  Future<void> fetchAsrams() async {
    try {
      isLoadingAsrams.value = true;
      final response = await RoomCategoryRepo.getAsrams();

      // DEBUG: Print the raw response from the repository
      log("API RAW RESPONSE: $response");

      final parsed = AsramListModel.fromJson(response);

      // DEBUG: Print the parsed data list
      log("PARSED ASRAMS COUNT: ${parsed.data?.length}");

      if (parsed.meta?.status == "success" && parsed.data != null) {
        asramList.assignAll(parsed.data!);
        log("SUCCESS: Asram list updated in controller.");
      } else {
        log("FAILURE: Condition not met. Status: ${parsed.meta?.status}, Data is null: ${parsed.data == null}");
        CustomFlutterToast.successToast(
            msg: parsed.meta?.displayMessage ?? "Failed to load asrams");
      }
    } catch (e, stackTrace) {
      // DEBUG: Print any errors that occur
      log("ERROR fetching asrams: ${e.toString()}");
      log("STACK TRACE: $stackTrace");
      CustomFlutterToast.successToast(
          msg: "Error fetching asrams: ${e.toString()}");
    } finally {
      isLoadingAsrams.value = false;
    }
  }

  // Create a new Room Category via API
  Future<bool> createRoomCategory({
    required String name,
    required String asramId,
    required String asramName,
    required String allotee,
    required String donor,
    required String general,
    required String staff,
  }) async {
    try {
      isCreatingCategory.value = true;
      Map<String, dynamic> payload = {
        "name": name,
        "asramId": asramId, // Send the ID to the backend
        "asram": asramName, // For local display until list is refreshed
        "allotee": allotee,
        "donor": donor,
        "general": general,
        "staff": staff,
      };

      // NOTE: Adjust the payload keys above to match what your API expects.

      final response = await RoomCategoryRepo.createRoomCategory(payload);

      // Assuming a simple success response structure. Adjust as needed.
      if (response['meta']?['status'] == 'success') {
        CustomFlutterToast.successToast(
            msg: response['meta']['displayMessage'] ??
                "Category created successfully");
        // You might want to refresh the main category list here
        return true;
      } else {
        CustomFlutterToast.successToast(
            msg: response['meta']?['displayMessage'] ??
                "Failed to create category");
        return false;
      }
    } catch (e) {
      CustomFlutterToast.successToast(
          msg: "Error creating category: ${e.toString()}");
      return false;
    } finally {
      isCreatingCategory.value = false;
    }
  }
}
