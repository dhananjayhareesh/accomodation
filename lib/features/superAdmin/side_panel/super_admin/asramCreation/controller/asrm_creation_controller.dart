import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/asramCreation/model/asram_list_model.dart';
import 'package:get/get.dart';
import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/asramCreation/repository/asram_crtn_repo.dart';

class AsrmCreationController extends GetxController {
  var isLoading = false.obs;
  var asramList = <Datum>[].obs;

  Future<void> createAsram({
    required String name,
    required String location,
  }) async {
    try {
      isLoading.value = true;
      final payload = {"name": name, "location": location};
      await AsramRepo.create(payload);
      Get.snackbar("Success", "Asram created successfully");
      await fetchAsramList();
    } catch (e) {
      Get.snackbar("Error", "Error creating asram: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAsramList() async {
    try {
      isLoading.value = true;
      final response = await AsramRepo.getList();

      print("📦 Asram list response: $response"); // 👈 Debug print

      if (response["data"] != null) {
        final parsedList = List<Datum>.from(
          (response["data"] as List).map((x) => Datum.fromJson(x)),
        );
        asramList.value = parsedList;
      } else {
        asramList.clear();
      }
    } catch (e) {
      print("❌ Error fetching list: $e");
      Get.snackbar("Error", "Failed to fetch list: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
