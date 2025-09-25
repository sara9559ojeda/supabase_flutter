import 'package:get/get.dart';
import '../data/supabase/supabase_config.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  /// LOGIN
  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await SupabaseConfig.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        Get.offAllNamed('/home'); // Ir a HomePage
      } else {
        Get.snackbar('Error', 'Usuario o contraseña incorrectos');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// REGISTRO
  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await SupabaseConfig.client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        Get.snackbar('Éxito', 'Usuario creado correctamente');
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Error', 'No se pudo crear el usuario');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// LOGOUT
  Future<void> signOut() async {
    await SupabaseConfig.client.auth.signOut();
    Get.offAllNamed('/login');
  }

  /// GETTER: email del usuario actual
  String get currentUserEmail => SupabaseConfig.currentUser?.email ?? 'Usuario';
}
