import 'package:dulinan/src/core/storage/secure_storage.dart';
import 'package:dulinan/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:dulinan/src/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:dulinan/src/features/auth/domain/repositories/auth_repository.dart';

import 'package:dulinan/src/shared/data/remote/remote.dart';
import 'package:dulinan/src/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider untuk FlutterSecureStorage
final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage();
});

// Provider untuk AuthRemoteDataSource
final authRemoteDataSourceProvider =
    Provider.family<AuthDataSource, DioNetworkService>(
  (_, networkService) =>
      AuthUserRemoteDataSource(networkService: networkService),
);

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  final networkService = ref.watch(networkServiceProvider);

  return AuthUserRemoteDataSource(networkService: networkService);
});

final authRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  final authDataSource = ref.watch(authDataSourceProvider);
  final storage = SecureStorage();
  return AuthenticationRepositoryImpl(
      authDataSource: authDataSource, storage: storage);
});

final authProvider = StateProvider<String?>((ref) {
  return null;
});

// ngeload token saaat app displashscreen
Future<void> loadToken(WidgetRef ref) async {
  final storage = SecureStorage();
  final token = await storage.getToken();
  ref.read(authProvider.notifier).state = token;
  debugPrint('DEBUG: Token berhasil dimuat saat reload: $token');
}
