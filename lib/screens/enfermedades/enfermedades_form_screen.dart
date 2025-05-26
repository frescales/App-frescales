import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:frescales_app/services/supabase_service.dart';
import 'package:frescales_app/widgets/submit_button.dart';
import 'package:frescales_app/widgets/date_picker_field.dart';
import 'package:frescales_app/widgets/image_picker_widget.dart';
import 'package:frescales_app/utils/catalog_loader.dart';
import 'package:uuid/uuid.dart';

class EnfermedadesFormScreen extends StatefulWidget {
  const EnfermedadesFormScreen({super.key});

  @override
  State<EnfermedadesFormScreen> createState() => _EnfermedadesFormScreenState();
}

class _EnfermedadesFormScreenState extends State<EnfermedadesFormScreen> {
  final _fechaController = TextEditingController();
  final _observacionesController = TextEditingController();
  String? enfermedadId;
  String? ubicacionId;
  String? severidad; // Cambiado a String

  Uint8List? foto;
  bool loading = false;

  final supabase = SupabaseService();
  final uuid = const Uuid();

  List<Map<String, dynamic>> enfermedades = [];
  List<Map<String, dynamic>> ubicaciones = [];

  // Agrega aquí los valores de tu enum
  final severidades = ['leve', 'moderada', 'alta'];

  @override
  void initState() {
    super.initState();
    cargarCatalogos();
  }

  Future<void> cargarCatalogos() async {
    final resEnfermedades = await cargarCatalogo('catalogo_enfermedades');
    final resUbicaciones = await cargarCatalogo('ubicaciones');
    setState(() {
      enfermedades = resEnfermedades;
      ubicaciones = resUbicaciones;
    });
  }

  Future<void> guardar() async {
    if (_fechaController.text.isEmpty ||
        enfermedadId == null ||
        ubicacionId == null ||
        severidad == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    setState(() => loading = true);

    final id = uuid.v4();

    await supabase.insert('enfermedades_detectadas', {
      'id': id,
      'fecha': _fechaController.text,
      'enfermedad_id': enfermedadId,
      'severidad': severidad, // Ahora es string
      'ubicacion_id': ubicacionId,
      'observaciones': _observacionesController.text,
    });

    if (foto != null) {
      final path = 'enfermedades/$id.jpg';

      await supabase.uploadImage(path, foto!);

      await supabase.insert('fotos_enfermedad', {
        'id': uuid.v4(),
        'enfermedad_detectada_id': id,
        'url': path,
      });
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Enfermedad Detectada')),
      body: enfermedades.isEmpty || ubicaciones.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  DatePickerField(label: 'Fecha', controller: _fechaController),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: enfermedadId,
                    decoration: const InputDecoration(labelText: 'Enfermedad'),
                    items: enfermedades.map((e) => DropdownMenuItem<String>(
                      value: e['id'] as String,
                      child: Text(e['nombre'] as String),
                    )).toList(),
                    onChanged: (v) => setState(() => enfermedadId = v),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: severidad,
                    decoration: const InputDecoration(labelText: 'Severidad'),
                    items: severidades
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) => setState(() => severidad = v),
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
                  TextField(
                    controller: _observacionesController,
                    maxLines: 2,
                    decoration: const InputDecoration(labelText: 'Observaciones'),
                  ),
                  const SizedBox(height: 16),
                  ImagePickerWidget(onImagePicked: (img) => setState(() => foto = img)),
                  const SizedBox(height: 24),
                  SubmitButton(text: 'Guardar Enfermedad', onPressed: guardar, loading: loading),
                ],
              ),
            ),
    );
  }
}
