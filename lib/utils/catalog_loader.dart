import 'package:supabase_flutter/supabase_flutter.dart';

final _client = Supabase.instance.client;

Future<List<Map<String, dynamic>>> cargarCatalogo(
  String tabla, {
  Map<String, dynamic>? filtros,
}) async {
  try {
    var query = _client.from(tabla).select();
    filtros?.forEach((key, value) {
      query = query.eq(key, value);
    });
    final data = await query;
    print('Catálogo $tabla: $data');
    return List<Map<String, dynamic>>.from(data);
  } catch (e) {
    print('Error cargando catálogo $tabla: $e');
    return [];
  }
}