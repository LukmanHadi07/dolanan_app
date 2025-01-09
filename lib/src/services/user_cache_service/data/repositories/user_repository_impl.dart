// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dulinan/src/services/user_cache_service/data/datasource/user_local_datasource.dart';
import 'package:dulinan/src/services/user_cache_service/domain/repositories/user_cache_repository.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/domain/models/user/user_model.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource dataSource;
  UserRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<AppExceptions, User>> fetchUser() {
    return dataSource.fetchUser();
  }

  @override
  Future<bool> saveUser({required User user}) {
    return dataSource.saveUser(user: user);
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
