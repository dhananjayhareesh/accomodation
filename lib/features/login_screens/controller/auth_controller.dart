import 'package:accomodation_admin/features/login_screens/repository/auth_repo.dart';
import 'package:accomodation_admin/local_storage/shared_pref.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String username, String password, String userType) async {
    try {
      isLoading.value = true;

      final payload = {
        "userName": username,
        "password": password,
        "userType": userType,
      };

      final response = await AuthenticationRepo.login(payload);

      // ✅ check API success
      if (response['meta']?['statusCode'] == 200) {
        final token = response['data']?['token'];

        if (token != null) {
          // ✅ store token and login status
          await MySharedPref.setAuthToken(token);
          await MySharedPref.setLoggedInStatus(true);

          Get.snackbar(
              "Success", response['meta']?['displayMessage'] ?? "Logged in");
        } else {
          Get.snackbar("Error", "No token received from server");
        }
      } else {
        Get.snackbar(
            "Error", response['meta']?['displayMessage'] ?? "Login failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
