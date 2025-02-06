// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage storage;

  AuthLocalDataSource({
    required this.storage,
  });

  // Key untuk menyimpan token
  static const String _tokenKey = 'access_token';
  static const String _isLogginKey = 'is_login';

  // Simpan token ke storage
  Future<void> saveToken(String token) async {
    try {
      await storage.write(key: _tokenKey, value: token);
    } catch (e) {
      throw Exception('Gagal menyimpan token: $e');
    }
  }

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    try {
      await storage.write(key: _isLogginKey, value: isLoggedIn.toString());
    } catch (e) {
      throw Exception('Gagal menyimpan token: $e');
    }
  }

  Future<bool> getLoginStatus() async {
    try {
      final value = await storage.read(key: _isLogginKey);
      return value == 'true';
    } catch (e) {
      throw Exception('Gagal mengambil token: $e');
    }
  }

  Future<void> deleteLoginStatus() async {
    try {
      await storage.delete(key: _isLogginKey);
    } catch (e) {
      throw Exception('Gagal menghapus status login: $e');
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
