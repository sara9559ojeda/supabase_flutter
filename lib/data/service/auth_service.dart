import 'package:supabase_flutter/supabase_flutter.dart';
import '/models/user_model.dart'; 

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> signUp(String email, String password, String name) async {
    final response = await _client.auth.signUp(email: email, password: password);
    if (response.user == null) throw Exception('Registro fallido');

    await _client.from('profiles').insert({
      'id': response.user!.id,
      'email': email,
      'name': name,
    });
  }

  Future<void> signIn(String email, String password) async {
    final response = await _client.auth.signInWithPassword(email: email, password: password);
    if (response.user == null) throw Exception('Login fallido');
  }

  Future<void> signOut() async => await _client.auth.signOut();

  Future<UserModel?> getCurrentUser() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final data = await _client.from('profiles').select().eq('id', user.id).single();
    return UserModel.fromJson(data);
  }
}
