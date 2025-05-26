import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/services/auth_service.dart';

final loginViewModelProvider = Provider((ref) => LoginViewModel());

class LoginViewModel {
  final AuthService _authService = AuthService();

  Future<void> login(String email, String password) async {
    await _authService.signIn(email, password);
  }

  Future<void> register(String email, String password) async {
    await _authService.signUp(email, password);
  }

  Future<void> logout() async {
    await _authService.signOut();
  }

  bool isLoggedIn() {
    return _authService.currentUser != null;
  }
}
