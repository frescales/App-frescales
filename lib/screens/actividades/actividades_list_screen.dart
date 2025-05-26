import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/view_models/actividades_vm.dart';
import 'package:frescales_app/models/actividad_planificada.dart';

class ActividadesListScreen extends ConsumerWidget {
  const ActividadesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actividades = ref.watch(actividadesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Actividades Planificadas')),
      body: actividades.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, i) {
            ActividadPlanificada a = items[i];
            return ListTile(
              title: Text(a.descripcion),
              subtitle: Text('Asignado a: ${a.perfilAsignadoId}'),
              trailing: Text(a.fechaProgramada.toIso8601String()),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
  backgroundColor: Colors.green,
  onPressed: () => Navigator.pushNamed(context, '/actividades_form'),
  child: const Icon(Icons.add),
),

    );
  }
}
