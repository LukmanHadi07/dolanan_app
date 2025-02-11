import 'package:dulinan/src/features/user/data/models/user_response.dart';

import 'package:dulinan/src/shared/domain/models/either.dart';

import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

// interfaces AuthenticationRepository berupa abstract class
abstract class AuthenticationRepository {
  // method login dengan parameter email dan password
  // either left dan right untuk menghandle response success atau error
  Future<Either<AppExceptions, UserResponse>> login(
      String email, String password);

  // method isloggedIn , method yang mengecek apakah sudah login atau belum
  Future<bool> isLoggedIn();

  // method register dengan parameter name, email, dan password
  // either left dan right untuk menghandle response success atau error
  // menggunakan Future<Either<AppExceptions, UserResponse>>
  // untuk menghandle response success atau error
  Future<Either<AppExceptions, UserResponse>> register(
      String name, String email, String password);

  Future<Either<AppExceptions, UserResponse>> refreshToken(String accessToken);
}
