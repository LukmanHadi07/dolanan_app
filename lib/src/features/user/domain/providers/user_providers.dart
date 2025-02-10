import 'package:dulinan/src/features/user/data/datasources/user_remote_data_sources.dart';
import 'package:dulinan/src/features/user/domain/entities/user.dart';
import 'package:dulinan/src/shared/data/remote/remote.dart';
import 'package:dulinan/src/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_providers.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  final _storage = const FlutterSecureStorage();
  @override
  FutureOr<User?> build() async {
    return await fetchUser();
  }

  Future<User?> fetchUser() async {
    final networkService = ref.watch(networkServiceProvider);
    final userDataSource =
        ref.watch(userRemoteDataSourceProvider(networkService));

    final token = await _storage.read(key: 'access_token');
    if (token == null) return null;

    final result = await userDataSource.fetchUser();
    return result.fold((failure) => null, (user) async {
      await _storage.write(key: 'access_token', value: token);
      return user;
    });
  }
}

final userRemoteDataSourceProvider =
    Provider.family<UserDataSource, DioNetworkService>(
  (_, networkService) => UserRemoteDataSources(networkService: networkService),
);
