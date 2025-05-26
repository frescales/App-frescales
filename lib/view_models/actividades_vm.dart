import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/models/actividad_planificada.dart';
import 'package:frescales_app/services/supabase_service.dart';

final actividadesProvider = FutureProvider<List<ActividadPlanificada>>((ref) async {
  final data = await SupabaseService().getAll('actividades_planificadas');
  return data.map((e) => ActividadPlanificada.fromMap(e)).toList();
});
