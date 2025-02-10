import 'package:dulinan/src/core/storage/secure_storage.dart';

import 'package:dulinan/src/features/user/data/datasources/user_remote_data_sources.dart';
import 'package:dulinan/src/features/user/domain/entities/user.dart';
import 'package:dulinan/src/shared/data/remote/remote.dart';
import 'package:dulinan/src/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter/foundation.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_providers.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  final _storage = SecureStorage();
  @override
  FutureOr<User?> build() async {
    debugPrint("DEBUG: Memulai fetchUser setelah reload");
    return await fetchUser();
  }

  Future<User?> fetchUser() async {
    final token = await _storage.getToken();
    debugPrint('DEBUG: Token saat reload = $token');

    if (token == null) {
      debugPrint('DEBUG: Token tidak ditemukan, user == null');
      return null;
    }

    final networkService = ref.watch(networkServiceProvider);
    final userDataSource =
        ref.watch(userRemoteDataSourceProvider(networkService));

    final result = await userDataSource.fetchUser();
    return result.fold((failure) {
      debugPrint('DEBUG: Gagal mengambil user: ${failure.message}');
      return null;
    }, (user) {
      debugPrint('DEBUG: Berhasil mengambil user: ${user.name}');
      return user;
    });
  }
}

final userRemoteDataSourceProvider =
    Provider.family<UserDataSource, DioNetworkService>(
  (_, networkService) => UserRemoteDataSources(networkService: networkService),
);
