import 'package:get/get.dart';
import '../data/service/auth_service.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final AuthService _service = AuthService();

  final isLoading = false.obs;
  final isLoggedIn = false.obs;

  Future<void> signUp(String email, String password, String name) async {
    try {
      isLoading.value = true;
      await _service.signUp(email, password, name);
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error registro', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      await _service.signIn(email, password);
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error login', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await _service.signOut();
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }

  Future<UserModel?> getCurrentUser() => _service.getCurrentUser();
}
