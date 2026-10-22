import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  const StorageService(this._client);

  final SupabaseClient _client;

  static const String _bucket = 'images';

  Future<String> uploadImage({
    required String localPath,
    required String folder,
  }) async {
    final bytes = await File(localPath).readAsBytes();
    final ext = _extension(localPath);
    final objectPath = '$folder/${DateTime.now().microsecondsSinceEpoch}.$ext';
    await _client.storage
        .from(_bucket)
        .uploadBinary(
          objectPath,
          bytes,
          fileOptions: FileOptions(contentType: _contentType(ext)),
        );
    return _client.storage.from(_bucket).getPublicUrl(objectPath);
  }

  Future<String?> uploadIfLocal(String? path, {required String folder}) async {
    if (path == null || path.isEmpty) return path;
    if (path.startsWith('http') || path.startsWith('assets/')) return path;
    return uploadImage(localPath: path, folder: folder);
  }

  String _extension(String path) {
    final dot = path.lastIndexOf('.');
    final raw = dot == -1 ? '' : path.substring(dot + 1).toLowerCase();
    return (raw == 'png' || raw == 'webp' || raw == 'jpeg') ? raw : 'jpg';
  }

  String _contentType(String ext) => switch (ext) {
    'png' => 'image/png',
    'webp' => 'image/webp',
    _ => 'image/jpeg',
  };
}
