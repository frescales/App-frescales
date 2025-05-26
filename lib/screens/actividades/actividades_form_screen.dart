import 'package:flutter/material.dart';
import 'package:frescales_app/widgets/date_picker_field.dart';
import 'package:frescales_app/widgets/submit_button.dart';
import 'package:frescales_app/utils/catalog_loader.dart';
import 'package:frescales_app/services/supabase_service.dart';
import 'package:uuid/uuid.dart';

class ActividadesFormScreen extends StatefulWidget {
  const ActividadesFormScreen({super.key});

  @override
  State<ActividadesFormScreen> createState() => _ActividadesFormScreenState();
}

class _ActividadesFormScreenState extends State<ActividadesFormScreen> {
  final _fechaController = TextEditingController();
  final _descripcionController = TextEditingController();

  String? tipoActividadId;
  String? perfilAsignadoId;
  String estado = 'pendiente';

  List<Map<String, dynamic>> tiposLabores = [];
  List<Map<String, dynamic>> perfiles = [];

  final supabase = SupabaseService();
  final uuid = const Uuid();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    cargarCatalogos();
  }

  Future<void> cargarCatalogos() async {
    final resLabores = await cargarCatalogo('tipos_labores');
    final resPerfiles = await cargarCatalogo('perfiles', filtros: {'rol': 'obrero'});

    setState(() {
      tiposLabores = resLabores;
      perfiles = resPerfiles;
    });
  }

  Future<void> guardar() async {
    if (_fechaController.text.isEmpty ||
        tipoActividadId == null ||
        perfilAsignadoId == null ||
        _descripcionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    setState(() => loading = true);

    await supabase.insert('actividades_planificadas', {
      'id': uuid.v4(),
      'fecha_programada': _fechaController.text,
      'tipo_labor_id': tipoActividadId,
      'descripcion': _descripcionController.text,
      'perfil_id': perfilAsignadoId, // <-- usa el nombre correcto
      'estado': estado,
    });

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Actividad Planificada')),
      body: tiposLabores.isEmpty || perfiles.isEmpty
          ? Center(
              child: tiposLabores.isEmpty
                  ? const Text('No hay labores disponibles. Agrega al menos una en el catálogo.')
                  : const Text('No hay perfiles disponibles.'),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  DatePickerField(label: 'Fecha Programada', controller: _fechaController),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _descripcionController,
                    maxLines: 2,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: tipoActividadId,
                    decoration: const InputDecoration(labelText: 'Tipo de Labor'),
                    items: tiposLabores.map((t) => DropdownMenuItem<String>(
                      value: t['id'] as String,
                      child: Text(t['nombre'] as String),
                    )).toList(),
                    onChanged: (v) => setState(() => tipoActividadId = v),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: perfilAsignadoId,
                    decoration: const InputDecoration(labelText: 'Asignado a'),
                    items: perfiles.map((p) => DropdownMenuItem<String>(
                      value: p['id'] as String,
                      child: Text(p['nombre'] as String),
                    )).toList(),
                    onChanged: (v) => setState(() => perfilAsignadoId = v),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: estado,
                    decoration: const InputDecoration(labelText: 'Estado'),
                    items: const [
                      DropdownMenuItem(value: 'pendiente', child: Text('Pendiente')),
                      DropdownMenuItem(value: 'completado', child: Text('Completado')),
                    ],
                    onChanged: (v) => setState(() => estado = v ?? 'pendiente'),
                  ),
                  const SizedBox(height: 24),
                  SubmitButton(text: 'Guardar Actividad', onPressed: guardar, loading: loading),
                ],
              ),
            ),
    );
  }
}
