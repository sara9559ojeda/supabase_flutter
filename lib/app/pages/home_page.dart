import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class HomePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final userEmail = authController.isLoading.value
        ? 'Cargando...'
        : authController.currentUserEmail;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authController.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          '¡Hola, $userEmail!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
