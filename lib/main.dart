import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'app/data/supabase/supabase_config.dart';
import 'app/pages/login_page.dart';
import 'app/pages/home_page.dart';
import 'app/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar dotenv y Supabase
  await SupabaseConfig.initialize();

  // Inicializar AuthController
  Get.put(AuthController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Huella de Carbono',
      theme: ThemeData(primarySwatch: Colors.green),
      // Rutas nombradas
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
      // Página inicial según si está autenticado
      home: SupabaseConfig.isAuthenticated ? HomePage() : LoginPage(),
    );
  }
}
