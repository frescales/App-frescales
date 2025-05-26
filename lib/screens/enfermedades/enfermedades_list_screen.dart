import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/view_models/enfermedades_vm.dart';
import 'package:frescales_app/models/enfermedad_detectada.dart';

class EnfermedadesListScreen extends ConsumerWidget {
  const EnfermedadesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncEnfermedades = ref.watch(enfermedadesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Enfermedades Detectadas')),
      body: asyncEnfermedades.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, i) {
            EnfermedadDetectada e = items[i];
            return ListTile(
              title: Text('Enfermedad: ${e.enfermedadId}'),
              subtitle: Text('Severidad: ${e.severidad}'),
              trailing: Text(e.fecha.toIso8601String()),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
  backgroundColor: Colors.green,
  onPressed: () => Navigator.pushNamed(context, '/enfermedades_form'),
  child: const Icon(Icons.add),
),

    );
  }
}
