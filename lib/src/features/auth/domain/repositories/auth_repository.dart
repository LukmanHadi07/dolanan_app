import 'package:dulinan/src/features/user/data/models/user_response.dart';

import 'package:dulinan/src/shared/domain/models/either.dart';

import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

abstract class AuthenticationRepository {
  Future<Either<AppExceptions, UserResponse>> login(
      String email, String password);
  Future<bool> isLoggedIn();

  Future<Either<AppExceptions, UserResponse>> register(
      String name, String email, String password);
}
