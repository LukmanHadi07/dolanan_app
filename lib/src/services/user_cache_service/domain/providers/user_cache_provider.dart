import 'package:dulinan/src/services/user_cache_service/data/datasource/user_local_datasource.dart';
import 'package:dulinan/src/services/user_cache_service/data/repositories/user_repository_impl.dart';
import 'package:dulinan/src/services/user_cache_service/domain/repositories/user_cache_repository.dart';
import 'package:dulinan/src/shared/data/local/storage_service.dart';
import 'package:dulinan/src/shared/domain/providers/shared_preferences_storage_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataSourceProvider = Provider.family<UserDataSource, StorageService>(
  (_, networkService) => UserLocalDatasource(storageService: networkService),
);

final userLocalRepositoryProvider = Provider<UserRepository>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final dataSource = ref.watch(userDataSourceProvider(storageService));
  final repository = UserRepositoryImpl(dataSource: dataSource);
  return repository;
});
