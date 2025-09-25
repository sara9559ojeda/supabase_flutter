import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Bienvenido'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () => controller.signOut()),
        ],
      ),
      body: FutureBuilder(
        future: controller.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.green));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Usuario no encontrado'));
          }

          final user = snapshot.data!;
          return Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 12, offset: const Offset(0, 6)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Bienvenido, ${user.name ?? user.email}',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.eco, color: Colors.green),
                      const SizedBox(width: 8),
                      Text('Meta diaria de CO₂: ${user.dailyCarbonGoal ?? 0} kg',
                          style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}