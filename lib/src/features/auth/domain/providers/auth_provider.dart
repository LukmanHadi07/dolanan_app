import 'package:dulinan/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:dulinan/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:dulinan/src/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:dulinan/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:dulinan/src/shared/data/remote/network_service.dart';
import 'package:dulinan/src/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final authRemoteDataSourceProvider =
    Provider.family<AuthDataSource, NetworkService>(
  (_, networkService) =>
      AuthUserRemoteDataSource(networkService: networkService),
);

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSource(storage: ref.watch(secureStorageProvider));
});

final authRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  final NetworkService networkService = ref.watch(networkServiceProvider);
  final AuthDataSource dataSource =
      ref.watch(authRemoteDataSourceProvider(networkService));
  final AuthLocalDataSource localDataSource =
      ref.watch(authLocalDataSourceProvider);

  return AuthenticationRepositoryImpl(
    dataSource: dataSource,
    localDataSource: localDataSource,
  );
});
