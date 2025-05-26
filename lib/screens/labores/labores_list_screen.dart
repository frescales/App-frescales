import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/view_models/labores_vm.dart';
import 'package:frescales_app/models/labor.dart';

class LaboresListScreen extends ConsumerWidget {
  const LaboresListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncLabores = ref.watch(laboresProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Labores')),
      body: asyncLabores.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, i) {
            Labor l = items[i];
            return ListTile(
              title: Text('Tipo: ${l.tipoLaborId}'),
              subtitle: Text('Ubicación: ${l.ubicacionId}'),
              trailing: Text(l.fecha.toIso8601String()),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
  backgroundColor: Colors.green,
  onPressed: () => Navigator.pushNamed(context, '/labores_form'),
  child: const Icon(Icons.add),
),

    );
  }
}
