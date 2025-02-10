import 'package:dulinan/src/core/storage/secure_storage.dart';
import 'package:dulinan/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:dulinan/src/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:dulinan/src/features/auth/domain/repositories/auth_repository.dart';

import 'package:dulinan/src/shared/data/remote/remote.dart';
import 'package:dulinan/src/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Provider untuk FlutterSecureStorage
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// Provider untuk AuthRemoteDataSource
final authRemoteDataSourceProvider =
    Provider.family<AuthDataSource, DioNetworkService>(
  (_, networkService) =>
      AuthUserRemoteDataSource(networkService: networkService),
);

// Provider untuk AuthenticationRepository
final authRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  final DioNetworkService networkService = ref.watch(networkServiceProvider);
  final AuthDataSource dataSource =
      ref.watch(authRemoteDataSourceProvider(networkService));
  final storage = ref.watch(secureStorageProvider);

  return AuthenticationRepositoryImpl(
    authDataSource: dataSource,
    storage: storage,
  );
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
