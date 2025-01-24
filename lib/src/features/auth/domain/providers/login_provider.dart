import 'package:dulinan/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:dulinan/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:dulinan/src/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:dulinan/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:dulinan/src/shared/data/remote/network_service.dart';
import 'package:dulinan/src/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final authDataSourceProvider =
    Provider.family<LoginUserDataSource, NetworkService>((_, networkService) =>
        LoginUserRemoteDataSource(networkService: networkService));

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final authLoalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSource(storage: ref.watch(secureStorageProvider));
});

final authRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) {
    final NetworkService networkService = ref.watch(networkServiceProvider);
    final LoginUserDataSource dataSource =
        ref.watch(authDataSourceProvider(networkService));
    final AuthLocalDataSource localDataSource =
        ref.watch(authLoalDataSourceProvider);
    return AuthenticationRepositoryImpl(
        dataSource: dataSource, localDataSource: localDataSource);
  },
);
