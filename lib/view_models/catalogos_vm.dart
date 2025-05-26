import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/services/supabase_service.dart';

final catalogosProvider = Provider<CatalogosVM>((ref) => CatalogosVM());

class CatalogosVM {
  final SupabaseService _service = SupabaseService();

  Future<List<Map<String, dynamic>>> getCatalogo(String tabla) async {
    return await _service.getAll(tabla);
  }
}
