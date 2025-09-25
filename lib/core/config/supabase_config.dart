import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static late SupabaseClient _client;
  
  static SupabaseClient get client => _client;
  
  static Future<void> initialize() async {
    // Cargar variables de entorno
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
    );
    
    _client = Supabase.instance.client;
  }
  
  static bool get isAuthenticated => _client.auth.currentUser != null;
  static User? get currentUser => _client.auth.currentUser;
}