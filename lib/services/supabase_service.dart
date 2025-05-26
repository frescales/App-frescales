import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final data = await client.from(table).select();
    return List<Map<String, dynamic>>.from(data);
  }

  Future<List<Map<String, dynamic>>> getFiltered(String table, Map<String, dynamic> filters) async {
    var query = client.from(table).select();
    filters.forEach((key, value) {
      query = query.eq(key, value);
    });
    final data = await query;
    return List<Map<String, dynamic>>.from(data);
  }

  Future<Map<String, dynamic>> insert(String table, Map<String, dynamic> values) async {
    final data = await client.from(table).insert(values).select().single();
    return data;
  }

  Future<Map<String, dynamic>> update(String table, Map<String, dynamic> values, String id) async {
    final data = await client.from(table).update(values).eq('id', id).select().single();
    return data;
  }

  Future<void> delete(String table, String id) async {
    await client.from(table).delete().eq('id', id);
  }

  /// ✅ Nuevo método para subir imágenes
  Future<void> uploadImage(String path, Uint8List bytes) async {
    final response = await client.storage.from('frescales-storage').uploadBinary(
      path,
      bytes,
      fileOptions: const FileOptions(
        upsert: true,
        contentType: 'image/jpeg',
      ),
    );

    if (response.isEmpty) {
      throw Exception('Error al subir la imagen');
    }
  }
}
