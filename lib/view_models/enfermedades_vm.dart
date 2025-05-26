import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/models/enfermedad_detectada.dart';
import 'package:frescales_app/services/supabase_service.dart';

final enfermedadesProvider = FutureProvider<List<EnfermedadDetectada>>((ref) async {
  final data = await SupabaseService().getAll('enfermedades_detectadas');
  return data.map((e) => EnfermedadDetectada.fromMap(e)).toList();
});
