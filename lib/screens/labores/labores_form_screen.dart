import 'package:flutter/material.dart';
import 'package:frescales_app/services/supabase_service.dart';
import 'package:frescales_app/utils/catalog_loader.dart';
import 'package:frescales_app/widgets/date_picker_field.dart';
import 'package:frescales_app/widgets/submit_button.dart';
import 'package:uuid/uuid.dart';

class LaboresFormScreen extends StatefulWidget {
  const LaboresFormScreen({super.key});

  @override
  State<LaboresFormScreen> createState() => _LaboresFormScreenState();
}

class _LaboresFormScreenState extends State<LaboresFormScreen> {
  final _fechaController = TextEditingController();
  final _observacionesController = TextEditingController();

  String? tipoLaborId;
  String? ubicacionId;
  String? perfilId;

  List<Map<String, dynamic>> tiposLabores = [];
  List<Map<String, dynamic>> ubicaciones = [];
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
    final resTipos = await cargarCatalogo('tipos_labores');
    final resUbicaciones = await cargarCatalogo('ubicaciones');
    final resPerfiles = await cargarCatalogo('perfiles', filtros: {'rol': 'obrero'});
    setState(() {
      tiposLabores = resTipos;
      ubicaciones = resUbicaciones;
      perfiles = resPerfiles;
    });
  }

  Future<void> guardar() async {
    if (_fechaController.text.isEmpty || tipoLaborId == null || ubicacionId == null || perfilId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    setState(() => loading = true);

    await supabase.insert('labores', {
      'id': uuid.v4(),
      'fecha': _fechaController.text,
      'tipo_labor_id': tipoLaborId,
      'ubicacion_id': ubicacionId,
      'perfil_id': perfilId,
      'observaciones': _observacionesController.text,
    });

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Labor')),
      body: tiposLabores.isEmpty || ubicaciones.isEmpty || perfiles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  DatePickerField(label: 'Fecha', controller: _fechaController),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: tipoLaborId,
                    decoration: const InputDecoration(labelText: 'Tipo de Labor'),
                    items: tiposLabores.map((l) => DropdownMenuItem<String>(
                      value: l['id'] as String,
                      child: Text(l['nombre'] as String),
                    )).toList(),
                    onChanged: (v) => setState(() => tipoLaborId = v),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: ubicacionId,
                    decoration: const InputDecoration(labelText: 'Ubicación'),
                    items: ubicaciones.map((u) => DropdownMenuItem<String>(
                      value: u['id'] as String,
                      child: Text(u['nombre'] as String),
                    )).toList(),
                    onChanged: (v) => setState(() => ubicacionId = v),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: perfilId,
                    decoration: const InputDecoration(labelText: 'Realizado por'),
                    items: perfiles.map((p) => DropdownMenuItem<String>(
                      value: p['id'] as String,
                      child: Text(p['nombre'] as String),
                    )).toList(),
                    onChanged: (v) => setState(() => perfilId = v),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _observacionesController,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Observaciones'),
                  ),
                  const SizedBox(height: 24),
                  SubmitButton(text: 'Guardar Labor', onPressed: guardar, loading: loading),
                ],
              ),
            ),
    );
  }
}
