// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dulinan/src/shared/data/remote/network_service.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/domain/models/user/user_model.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

abstract class AuthDataSource {
  Future<Either<AppExceptions, User>> loginUser({required User user});
  Future<Either<AppExceptions, User>> registerUser({required User user});
}

class AuthUserRemoteDataSource implements AuthDataSource {
  final NetworkService networkService;
  AuthUserRemoteDataSource({
    required this.networkService,
  });

  @override
  Future<Either<AppExceptions, User>> loginUser({
    required User user,
  }) async {
    try {
      final eitherType = await networkService.post(
        '/auth/login',
        data: user.toJson(),
      );

      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          // Validasi response data
          if (response.data == null) {
            return Left(
              AppExceptions(
                message: 'Invalid response from server',
                statusCode: 1,
                identifier:
                    'LoginUserRemoteDataSource.loginUser() - Null response data',
              ),
            );
          }

          final user = User.fromJson(response.data);

          // Update headers dengan token baru
          networkService.updateHeaders({
            'Authorization': 'Bearer ${user.accessToken}',
          });

          return Right(user);
        },
      );
    } catch (e) {
      return Left(
        AppExceptions(
          message:
              'Failed to login. Please check your credentials and try again.',
          statusCode: 1,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser()',
        ),
      );
    }
  }

  @override
  Future<Either<AppExceptions, User>> registerUser({required User user}) async {
    try {
      final eitherType = await networkService.post(
        '/auth/register',
        data: user.toJson(),
      );

      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          // Validasi response data
          if (response.data == null) {
            return Left(
              AppExceptions(
                message: 'Invalid response from server',
                statusCode: 1,
                identifier:
                    'LoginUserRemoteDataSource.registerUser() - Null response data',
              ),
            );
          }

          return Right(User.fromJson(response.data));
        },
      );
    } catch (e) {
      return Left(
        AppExceptions(
          message: 'Failed to register. Please try again later.',
          statusCode: 1,
          identifier:
              '${e.toString()}\nLoginUserRemoteDataSource.registerUser()',
        ),
      );
    }
  }
}
