import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/view_models/login_vm.dart';
import 'package:frescales_app/screens/main_menu_screen.dart';
import 'package:frescales_app/widgets/input_text_field.dart';
import 'package:frescales_app/widgets/submit_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool loading = false;

  Future<void> login() async {
    setState(() => loading = true);
    try {
      await ref.read(loginViewModelProvider).login(
        _emailController.text,
        _passwordController.text,
      );
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainMenuScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio de sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            InputTextField(label: 'Email', controller: _emailController),
            const SizedBox(height: 16),
            InputTextField(label: 'Contraseña', controller: _passwordController, obscureText: true),
            const SizedBox(height: 24),
            SubmitButton(text: 'Ingresar', onPressed: login, loading: loading),
          ],
        ),
      ),
    );
  }
}
