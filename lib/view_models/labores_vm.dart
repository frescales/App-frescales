import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frescales_app/models/labor.dart';
import 'package:frescales_app/services/supabase_service.dart';

final laboresProvider = FutureProvider<List<Labor>>((ref) async {
  final data = await SupabaseService().getAll('labores');
  return data.map((e) => Labor.fromMap(e)).toList();
});
