import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient client = Supabase.instance.client;

  Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth.signInWithPassword(email: email, password: password);
  }

  Future<AuthResponse> signUp(String email, String password) async {
    final response =
        await client.auth.signUp(email: email, password: password);

    final user = response.user;

    if (user != null) {
      await client.from('perfiles').insert({
        'user_id': user.id,
        'nombre': email.split('@')[0], // nombre por defecto
        'rol': 'Obrero', // rol por defecto
      });
    }

    return response;
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }

  User? get currentUser => client.auth.currentUser;
}
