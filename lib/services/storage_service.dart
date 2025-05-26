import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final SupabaseClient client = Supabase.instance.client;

  Future<String> uploadFile({
    required String bucket,
    required String filePath,
    required Uint8List fileBytes,
    String contentType = 'image/jpeg',
  }) async {
    await client.storage.from(bucket).uploadBinary(
          filePath,
          fileBytes,
          fileOptions: FileOptions(contentType: contentType),
        );

    final publicUrl = client.storage.from(bucket).getPublicUrl(filePath);
    return publicUrl;
  }

  Future<void> deleteFile({
    required String bucket,
    required String filePath,
  }) async {
    await client.storage.from(bucket).remove([filePath]);
  }
}
