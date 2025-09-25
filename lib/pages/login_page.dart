import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController controller = Get.put(AuthController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.eco, size: 100, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                'Eco Tracker',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 40),
              _inputField('Correo', emailController, false),
              const SizedBox(height: 16),
              _inputField('Contraseña', passwordController, true),
              const SizedBox(height: 16),
              _inputField('Nombre (Registro)', nameController, false),
              const SizedBox(height: 30),
              Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 80),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.signIn(emailController.text, passwordController.text),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Iniciar sesión', style: TextStyle(fontSize: 16)),
                  )),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => controller.signUp(
                    emailController.text, passwordController.text, nameController.text),
                child: const Text('Registrarse', style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller, bool obscure) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}
