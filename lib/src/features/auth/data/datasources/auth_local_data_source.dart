// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage storage;

  AuthLocalDataSource({
    required this.storage,
  });

  // Key untuk menyimpan token
  static const String _tokenKey = 'access_token';

  // Simpan token ke storage
  Future<void> saveToken(String token) async {
    try {
      await storage.write(key: _tokenKey, value: token);
    } catch (e) {
      throw Exception('Gagal menyimpan token: $e');
    }
  }

  // Ambil token dari storage
  Future<String?> getToken() async {
    try {
      return await storage.read(key: _tokenKey);
    } catch (e) {
      throw Exception('Gagal mengambil token: $e');
    }
  }

  // Hapus token dari storage (misalnya, saat logout)
  Future<void> deleteToken() async {
    try {
      await storage.delete(key: _tokenKey);
    } catch (e) {
      throw Exception('Gagal menghapus token: $e');
    }
  }

  // Hapus semua data dari storage (opsional)
  Future<void> clearStorage() async {
    try {
      await storage.deleteAll();
    } catch (e) {
      throw Exception('Gagal menghapus semua data: $e');
    }
  }
}
