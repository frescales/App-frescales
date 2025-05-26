import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/view_models/catalogos_vm.dart';

class UnidadesScreen extends ConsumerWidget {
  const UnidadesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogos = ref.read(catalogosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de Unidades')),
      body: FutureBuilder(
        future: catalogos.getCatalogo('unidades'),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) {
              final u = items[i];
              return ListTile(
                title: Text(u['nombre']),
                subtitle: Text('Símbolo: ${u['simbolo']}'),
              );
            },
          );
        },
      ),
    );
  }
}
