import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static late SupabaseClient _client;

  // Obtener el cliente Supabase
  static SupabaseClient get client => _client;

  // Inicializar Supabase
  static Future<void> initialize() async {
    // Cargar variables de entorno desde .env
    await dotenv.load(fileName: ".env");

    final supabaseUrl = dotenv.env['SUPABASE_URL'];
    final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

    if (supabaseUrl == null || supabaseAnonKey == null) {
      throw Exception(
        'Supabase URL and Anon Key must be provided in .env file'
      );
    }

    // Inicializar Supabase
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      debug: true, // true para desarrollo, false en producción
    );

    _client = Supabase.instance.client;
  }

  // Saber si el usuario está autenticado
  static bool get isAuthenticated => _client.auth.currentUser != null;

  // Obtener usuario actual
  static User? get currentUser => _client.auth.currentUser;
}
