import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/view_models/insumos_vm.dart';


class InsumosListScreen extends ConsumerWidget {
  const InsumosListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncInsumos = ref.watch(insumosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Insumos Aplicados')),

      body: asyncInsumos.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, i) {
            final item = items[i];
            return ListTile(
              title: Text('Ubicación: ${item.ubicacionId}'),
              subtitle: Text('Aplicador: ${item.aplicadorPerfilId}'),
              trailing: Text(item.fecha.toIso8601String()),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),

      /// ✅ Botón flotante insertado correctamente
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => Navigator.pushNamed(context, '/insumos_form'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
