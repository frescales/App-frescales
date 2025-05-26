import 'package:flutter/material.dart';
import 'package:frescales_app/widgets/date_picker_field.dart';
import 'package:frescales_app/widgets/submit_button.dart';
import 'package:frescales_app/services/supabase_service.dart';
import 'package:uuid/uuid.dart';

class InsumosFormScreen extends StatefulWidget {
  const InsumosFormScreen({super.key});

  @override
  State<InsumosFormScreen> createState() => _InsumosFormScreenState();
}

class _InsumosFormScreenState extends State<InsumosFormScreen> {
  final supabase = SupabaseService();
  final uuid = const Uuid();

  final _fechaController = TextEditingController(
      text: DateTime.now().toString().split(' ')[0]);

  final List<Map<String, dynamic>> insumosUsados = [];
  List<Map<String, dynamic>> catalogoInsumos = [];
  List<Map<String, dynamic>> catalogoUbicaciones = [];
  String? ubicacionId;

  @override
  void initState() {
    super.initState();
    cargarCatalogo();
    cargarUbicaciones();
  }

  Future<void> cargarCatalogo() async {
    catalogoInsumos = await supabase.getAll('insumos');
    setState(() {});
  }

  Future<void> cargarUbicaciones() async {
    catalogoUbicaciones = await supabase.getAll('ubicaciones');
    setState(() {});
  }

  void agregarInsumo() {
    insumosUsados.add({
      'insumo_id': null,
      'cantidad': 0.0,
      'precio_unitario': 0.0,
      'unidad': '',
      'costo_total': 0.0,
    });
    setState(() {});
  }

  void actualizarInsumo(int index, String campo, dynamic valor) {
    final insumo = insumosUsados[index];
    if (campo == 'insumo_id') {
      final encontrado = catalogoInsumos.firstWhere((e) => e['id'] == valor);
      insumo['unidad'] = encontrado['unidad_id'];
      insumo['precio_unitario'] = double.tryParse(encontrado['precio_unitario'].toString()) ?? 0.0;
      insumo['insumo_id'] = valor;
    } else {
      insumo[campo] = valor;
    }

    insumo['costo_total'] = (insumo['cantidad'] ?? 0) * (insumo['precio_unitario'] ?? 0);
    setState(() {});
  }

  double get totalAplicacion {
    return insumosUsados.fold(0.0, (suma, e) => suma + (e['costo_total'] ?? 0));
  }

  Future<void> guardar() async {
    final aplicacionId = uuid.v4();

    try {
      await supabase.insert('insumos_aplicados', {
        'id': aplicacionId,
        'fecha': _fechaController.text,
        'ubicacion_id': ubicacionId, // <-- Guardar ubicación
      });

      for (final insumo in insumosUsados) {
        await supabase.insert('detalle_insumos_aplicados', {
          'id': uuid.v4(),
          'aplicacion_id': aplicacionId,
          'insumo_id': insumo['insumo_id'],
          'cantidad': insumo['cantidad'],
          'unidad_id': insumo['unidad'],
          'precio_unitario_usado': insumo['precio_unitario'],
          'costo_total': insumo['costo_total'],
        });
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Aplicación guardada con éxito')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('Error al guardar: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error al guardar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aplicación de Insumo')),
      body: catalogoInsumos.isEmpty || catalogoUbicaciones.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  DatePickerField(label: 'Fecha', controller: _fechaController),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: ubicacionId,
                    decoration: const InputDecoration(labelText: 'Ubicación'),
                    items: catalogoUbicaciones.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem<String>(
                        value: e['id'].toString(),
                        child: Text(e['nombre']),
                      );
                    }).toList(),
                    onChanged: (v) => setState(() => ubicacionId = v),
                    validator: (v) => v == null ? 'Selecciona una ubicación' : null,
                  ),
                  const SizedBox(height: 24),
                  ...insumosUsados.asMap().entries.map((entry) {
                    final index = entry.key;
                    final insumo = entry.value;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownButtonFormField<String>(
                              value: insumo['insumo_id']?.toString(),
                              decoration: const InputDecoration(labelText: 'Insumo'),
                              items: catalogoInsumos.map<DropdownMenuItem<String>>((e) {
                                return DropdownMenuItem<String>(
                                  value: e['id'].toString(),
                                  child: Text(e['nombre']),
                                );
                              }).toList(),
                              onChanged: (v) => actualizarInsumo(index, 'insumo_id', v),
                            ),
                            const SizedBox(height: 12),
                            Text('Unidad: ${insumo['unidad'] ?? ''}'),
                            const SizedBox(height: 8),
                            TextFormField(
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              initialValue: insumo['cantidad'].toString(),
                              decoration: const InputDecoration(labelText: 'Cantidad'),
                              onChanged: (v) => actualizarInsumo(index, 'cantidad', double.tryParse(v) ?? 0.0),
                            ),
                            const SizedBox(height: 8),
                            Text('💵 Precio unitario: \$${insumo['precio_unitario'].toStringAsFixed(2)}'),
                            Text('🧾 Costo total: \$${insumo['costo_total'].toStringAsFixed(2)}'),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Agregar otro insumo'),
                    onPressed: agregarInsumo,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '🧾 Total Aplicación: \$${totalAplicacion.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  SubmitButton(text: 'Guardar Aplicación', onPressed: guardar),
                ],
              ),
            ),
    );
  }
}
