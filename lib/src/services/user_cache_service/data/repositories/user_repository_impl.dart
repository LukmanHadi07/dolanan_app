// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dulinan/src/services/user_cache_service/data/datasource/user_local_datasource.dart';
import 'package:dulinan/src/services/user_cache_service/domain/repositories/user_cache_repository.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/domain/models/user/user_model.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource dataSource;
  UserRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<AppExceptions, User>> fetchUser() {
    return dataSource.fetchUser();
  }

  final _storage = const FlutterSecureStorage();

  @override
  Future<bool> saveUser({required User user}) {
    return dataSource.saveUser(user: user);
  }

  @override
  Future<void> saveUserToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  Future<String?> getUserToken() async {
    return await _storage.read(key: 'access_token');
  }

  @override
  Future<bool> deleteUser() {
    return dataSource.deleteUser();
  }

  @override
  Future<bool> hasUser() {
    return dataSource.hasUser();
  }
}
