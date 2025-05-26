import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/models/insumo_aplicado.dart';
import 'package:frescales_app/services/supabase_service.dart';

final insumosProvider = FutureProvider<List<InsumoAplicado>>((ref) async {
  final data = await SupabaseService().getAll('insumos_aplicados');
  return data.map((e) => InsumoAplicado.fromMap(e)).toList();
});
