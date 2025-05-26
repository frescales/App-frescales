import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/services/auth_service.dart';
import 'package:frescales_app/view_models/perfil_vm.dart';
import 'package:frescales_app/view_models/main_menu_vm.dart';
import 'package:frescales_app/screens/login_screen.dart';

class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = AuthService().currentUser;

    if (user == null) {
      return const LoginScreen();
    }

    final perfilAsync = ref.watch(perfilProvider(user.id));

    return perfilAsync.when(
      data: (perfil) {
        if (perfil == null) {
          return const Scaffold(
            body: Center(child: Text('Perfil no configurado')),
          );
        }

        final menuItems =
            ref.read(mainMenuViewModelProvider).getMenuItems(perfil.rol);

        return Scaffold(
          appBar: AppBar(
            title: Text('Menú - ${perfil.rol}'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await AuthService().signOut();
                  if (context.mounted) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                  }
                },
              )
            ],
          ),
          body: ListView(
            children: menuItems
                .map((item) => ListTile(
                      title: Text(item.title),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushNamed(context, item.route);
                      },
                    ))
                .toList(),
          ),
        );
      },
      loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(
          body: Center(child: Text('Error: ${err.toString()}'))),
    );
  }
}
