import 'package:flutter/material.dart';
import 'package:frescales_app/services/supabase_service.dart';
import 'package:frescales_app/widgets/date_picker_field.dart';
import 'package:frescales_app/widgets/submit_button.dart';
import 'package:frescales_app/utils/catalog_loader.dart';
import 'package:uuid/uuid.dart';
import 'package:geolocator/geolocator.dart';

class ProduccionFormScreen extends StatefulWidget {
  const ProduccionFormScreen({super.key});

  @override
  State<ProduccionFormScreen> createState() => _ProduccionFormScreenState();
}

class _ProduccionFormScreenState extends State<ProduccionFormScreen> {
  final _fechaController = TextEditingController();
  final _cantidadController = TextEditingController();
  final _observacionesController = TextEditingController();

  String? productoId;
  String? unidadId;
  String? ubicacionId;
  double? latitud;
  double? longitud;

  List<Map<String, dynamic>> productos = [];
  List<Map<String, dynamic>> unidades = [];
  List<Map<String, dynamic>> ubicaciones = [];

  final supabase = SupabaseService();
  final uuid = const Uuid();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    cargarCatalogos();
    obtenerUbicacion();
  }

  Future<void> cargarCatalogos() async {
    final resProductos = await cargarCatalogo('productos');
    final resUnidades = await cargarCatalogo('unidades');
    final resUbicaciones = await cargarCatalogo('ubicaciones');

    setState(() {
      productos = resProductos;
      unidades = resUnidades;
      ubicaciones = resUbicaciones;
    });
  }

  Future<void> obtenerUbicacion() async {
    final perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      latitud = pos.latitude;
      longitud = pos.longitude;
    });
  }

  Future<void> guardar() async {
    if (_fechaController.text.isEmpty ||
        _cantidadController.text.isEmpty ||
        productoId == null ||
        unidadId == null ||
        ubicacionId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    setState(() => loading = true);

    await supabase.insert('produccion', {
      'id': uuid.v4(),
      'fecha': _fechaController.text,
      'producto_id': productoId,
      'unidad_id': unidadId,
      'ubicacion_id': ubicacionId,
      'cantidad': double.tryParse(_cantidadController.text) ?? 0,
      'observaciones': _observacionesController.text,
    });

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Registro de Producción')),
      body: productos.isEmpty || unidades.isEmpty || ubicaciones.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  DatePickerField(label: 'Fecha', controller: _fechaController),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _cantidadController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Cantidad'),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: productoId,
                    decoration: const InputDecoration(labelText: 'Producto'),
                    items: productos.map<DropdownMenuItem<String>>((p) {
                      return DropdownMenuItem<String>(
                        value: p['id'] as String,
                        child: Text(p['nombre']),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => productoId = val),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: unidadId,
                    decoration: const InputDecoration(labelText: 'Unidad'),
                    items: unidades.map<DropdownMenuItem<String>>((u) {
                      return DropdownMenuItem<String>(
                        value: u['id'] as String,
                        child: Text(u['nombre']),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => unidadId = val),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: ubicacionId,
                    decoration: const InputDecoration(labelText: 'Ubicación'),
                    items: ubicaciones.map<DropdownMenuItem<String>>((u) {
                      return DropdownMenuItem<String>(
                        value: u['id'] as String,
                        child: Text(u['nombre']),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => ubicacionId = val),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _observacionesController,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Observaciones'),
                  ),
                  const SizedBox(height: 24),
                  SubmitButton(text: 'Guardar Producción', onPressed: guardar, loading: loading),
                  const SizedBox(height: 8),
                  if (latitud != null && longitud != null)
                    Text('Ubicación: $latitud, $longitud', style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
    );
  }
}
