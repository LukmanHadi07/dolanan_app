import 'package:dulinan/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Gunakan konfigurasi yang lebih stabil untuk Secure Storage
const storage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
);

/// Provider untuk mengecek apakah user sudah login
final isLoggedInProvider = FutureProvider<bool>((ref) async {
  final token = await storage.read(key: 'access_token');
  final isValid = token != null && token.isNotEmpty;
  debugPrint("DEBUG: isLoggedInProvider = $isValid");
  return isValid;
});

/// Fungsi untuk menyimpan bahwa user sudah menyelesaikan onboarding
Future<void> setOnBoarded() async {
  await storage.write(key: 'isOnBoarded', value: 'true');
  debugPrint("DEBUG: isOnBoarded telah disimpan sebagai true");
}
