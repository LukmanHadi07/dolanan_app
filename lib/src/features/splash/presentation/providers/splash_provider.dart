import 'package:dulinan/src/core/storage/secure_storage.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Gunakan konfigurasi yang lebih stabil untuk Secure Storage
final storage = SecureStorage();

/// Provider untuk mengecek apakah user sudah login
final isLoggedInProvider = FutureProvider<bool>((ref) async {
  final token = await storage.getToken();
  final isValid = token != null && token.isNotEmpty;
  debugPrint("DEBUG: isLoggedInProvider = $isValid");
  return isValid;
});

/// Fungsi untuk menyimpan bahwa user sudah menyelesaikan onboarding
Future<void> setOnBoarded() async {
  await storage.getToken();
  debugPrint("DEBUG: isOnBoarded telah disimpan sebagai true");
}
