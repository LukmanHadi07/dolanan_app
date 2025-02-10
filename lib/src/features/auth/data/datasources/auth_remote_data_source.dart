// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dulinan/src/core/storage/secure_storage.dart';

import 'package:dulinan/src/features/user/data/models/user_response.dart';
import 'package:dulinan/src/features/user/domain/entities/user.dart';

import 'package:dulinan/src/shared/data/remote/remote.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';
import 'package:flutter/foundation.dart';

abstract class AuthDataSource {
  Future<Either<AppExceptions, UserResponse>> loginUser(
      String email, String password);
  Future<Either<AppExceptions, UserResponse>> registerUser(
      String name, String email, String password);
  Future<Either<AppExceptions, User>> getUser(String accessToken);
}

class AuthUserRemoteDataSource implements AuthDataSource {
  final SecureStorage storage;
  final DioNetworkService networkService;

  AuthUserRemoteDataSource({
    storage,
    required this.networkService,
  }) : storage = storage ?? SecureStorage();

  @override
  Future<Either<AppExceptions, UserResponse>> loginUser(
      String email, String password) async {
    try {
      final eitherType = await networkService.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          if (response.data == null) {
            return Left(AppExceptions(
              message: 'Invalid response from server',
              statusCode: 1,
              identifier:
                  'LoginUserRemoteDataSource.loginUser() - Null response data',
            ));
          }

          // Ambil token dari response
          final String accessToken = response.data['access_token'];

          // Simpan token ke SecureStorage
          await storage.saveToken(accessToken);
          // Cek apakah token tersimpan dengan benar
          final savedToken = await storage.getToken();
          debugPrint("DEBUG: Access Token yang tersimpan = $savedToken");

          final user = UserResponse(
            accessToken: accessToken,
            data: User.fromJson(response.data['data']),
          );

          // Update header dengan token yang baru
          networkService.updateHeaders({
            'Authorization': 'Bearer $accessToken',
          });

          return Right(user);
        },
      );
    } catch (e) {
      return Left(AppExceptions(
        message:
            'Failed to login. Please check your credentials and try again.',
        statusCode: 1,
        identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser()',
      ));
    }
  }

  @override
  Future<Either<AppExceptions, UserResponse>> registerUser(
      String name, String email, String password) async {
    try {
      final eitherType = await networkService.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          if (response.data == null) {
            return Left(AppExceptions(
              message: 'Invalid response from server',
              statusCode: 1,
              identifier:
                  'LoginUserRemoteDataSource.registerUser() - Null response data',
            ));
          }

          return Right(UserResponse.fromJson(response.data));
        },
      );
    } catch (e) {
      return Left(AppExceptions(
        message: 'Failed to register. Please try again later.',
        statusCode: 1,
        identifier: '${e.toString()}\nLoginUserRemoteDataSource.registerUser()',
      ));
    }
  }

  @override
  Future<Either<AppExceptions, User>> getUser(String accessToken) async {
    try {
      final response = await networkService.get(
        '/auth/me',
        queryParameters: {
          'access_token': accessToken,
        },
      );

      return response.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          if (response.data == null) {
            return Left(AppExceptions(
              message: 'Invalid response from server',
              statusCode: 1,
              identifier:
                  'LoginUserRemoteDataSource.getUser() - Null response data',
            ));
          }
          return Right(User.fromJson(response.data));
        },
      );
    } catch (e) {
      return Left(AppExceptions(
        message: 'Failed to get user data. Please try again later.',
        statusCode: 1,
        identifier: '${e.toString()}\nLoginUserRemoteDataSource.getUser()',
      ));
    }
  }
}
