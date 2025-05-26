import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/models/produccion.dart';
import 'package:frescales_app/services/supabase_service.dart';

final produccionProvider = FutureProvider<List<Produccion>>((ref) async {
  final data = await SupabaseService().getAll('produccion');
  return data.map((e) => Produccion.fromMap(e)).toList();
});
