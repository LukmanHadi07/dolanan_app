// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dulinan/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:dulinan/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:dulinan/src/shared/domain/models/user/user_model.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

import '../../../../shared/domain/models/either.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final LoginUserDataSource dataSource;
  AuthenticationRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<AppExceptions, User>> loginUser({required User user}) =>
      dataSource.loginUser(user: user);
}
