import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/models/perfil.dart';
import 'package:frescales_app/services/supabase_service.dart';

final perfilProvider = FutureProvider.family<Perfil?, String>((ref, userId) async {
  final data = await SupabaseService().getFiltered('perfiles', {'user_id': userId});
  if (data.isEmpty) return null;
  return Perfil.fromMap(data.first);
});
