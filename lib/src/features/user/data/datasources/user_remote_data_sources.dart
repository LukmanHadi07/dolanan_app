// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dulinan/src/core/storage/secure_storage.dart';
import 'package:dulinan/src/features/user/domain/entities/user.dart';
import 'package:dulinan/src/shared/data/remote/remote.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

abstract class UserDataSource {
  Future<Either<AppExceptions, User>> fetchUser();
}

class UserRemoteDataSources extends UserDataSource {
  final SecureStorage storage;
  final DioNetworkService networkService;

  UserRemoteDataSources({
    storage,
    required this.networkService,
  }) : storage = storage ?? SecureStorage();

  @override
  Future<Either<AppExceptions, User>> fetchUser() async {
    try {
      final token = await storage.getToken();
      if (token == null) {
        return Left(AppExceptions(
          message: 'No token found',
          statusCode: 401,
          identifier: 'UserRemoteDataSources.fetchUser() - No token',
        ));
      }

      final resp = await networkService.get(
        '/auth/me',
        queryParameters: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      return resp.fold((exception) {
        return Left(exception);
      }, (userResponse) {
        if (userResponse.data == null) {
          return Left(AppExceptions(
            message: 'Invalid response from server',
            statusCode: 400,
            identifier:
                'UserRemoteDataSources.fetchUser() - Null response data',
          ));
        }

        final user = User.fromJson(userResponse.data);
        return Right(user);
      });
    } catch (e) {
      return Left(AppExceptions(
        message: 'Failed to fetch user',
        statusCode: 500,
        identifier: 'UserRemoteDataSources.fetchUser() - $e',
      ));
    }
  }
}
