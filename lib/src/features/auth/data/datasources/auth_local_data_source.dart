// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage storage;
  AuthLocalDataSource({
    required this.storage,
  });

  Future<void> saveToken(String token) async {
    await storage.write(key: 'access_token', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }
}
