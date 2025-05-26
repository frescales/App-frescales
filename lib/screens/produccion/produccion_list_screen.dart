import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/view_models/produccion_vm.dart';
import 'package:frescales_app/models/produccion.dart';

class ProduccionListScreen extends ConsumerWidget {
  const ProduccionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final produccionAsync = ref.watch(produccionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Producción')),
      
      body: produccionAsync.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, i) {
            Produccion p = items[i];
            return ListTile(
              title: Text('Producto ID: ${p.productoId}'),
              subtitle: Text('Cantidad: ${p.cantidad} ${p.unidadId}'),
              trailing: Text(p.fecha.toIso8601String()),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),

      /// ✅ Aquí agregas el botón flotante
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/produccion_form');
        },
      ),
    );
  }
}
