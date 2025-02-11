// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dulinan/src/core/storage/secure_storage.dart';

import 'package:dulinan/src/features/user/data/models/user_response.dart';
import 'package:dulinan/src/features/user/domain/entities/user.dart';

import 'package:dulinan/src/shared/data/remote/remote.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';
import 'package:flutter/foundation.dart';

// abstract class AuthDataSource untuk AuthremoteDataSource ini adalah interface yang mempunyai bentuk absctract classs
abstract class AuthDataSource {
  // mempunyai metho loginUser untuk authremotedatasource
  Future<Either<AppExceptions, UserResponse>> loginUser(
      String email, String password);

  // mempunyai method registerUser untuk authremotedatasource
  Future<Either<AppExceptions, UserResponse>> registerUser(
      String name, String email, String password);

  Future<Either<AppExceptions, UserResponse>> refreshToken(String accessToken);
}

// class AuthUserRemoteDataSource mengimplementasikan AuthDataSource
class AuthUserRemoteDataSource implements AuthDataSource {
  // object storage dari class secureStorage untuk menyimpan data sensitifi dari user
  final SecureStorage storage;
  // object networkService dari class DioNetworkService untuk menghandle request api
  final DioNetworkService networkService;

  // constructor
  AuthUserRemoteDataSource({
    storage,
    required this.networkService,
  }) : storage = storage ?? SecureStorage();

// method loginUser implementasi dari AuthDataSource
// mempunyai fungsi login untuk User di app
// Either untuk menghandle  response
// AppExceptions untuk menghandle exception
// UserResponse adalah response dari api user
// mempunyai parameter email dan password untuk login
  @override
  Future<Either<AppExceptions, UserResponse>> loginUser(
      String email, String password) async {
    try {
      // mengirim request dengan metode api post ke endpoint login
      final eitherType = await networkService.post(
        '/auth/login',
        data: {
          // mengirim parameter email dan password
          'email': email,
          'password': password,
        },
      );

      // response kalau left(error) dia akan menampilkan error
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          if (response.data == null) {
            // kalau responsenya successs namun datanya null maka munculkan error
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

          // kalau response success akan menampilkan data,
          return Right(user);
        },
      );
    } catch (e) {
      // kalau  serverError akan menampilkan error
      return Left(AppExceptions(
        message:
            'Failed to login. Please check your credentials and try again.',
        statusCode: 1,
        identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser()',
      ));
    }
  }

  // method registerUser implementasi dari AuthDataSource
  // mempunyai fungsi register untuk User di app
  // Either untuk menghandle  response
  // AppExceptions untuk menghandle exception
  // UserResponse adalah response dari api user
  // mempunyai parameter name, email, dan password
  @override
  Future<Either<AppExceptions, UserResponse>> registerUser(
      String name, String email, String password) async {
    try {
      // mengirim request dengan metode api post ke endpoint register
      final eitherType = await networkService.post(
        '/auth/register',
        // mengirim parameter name, email, dan password
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      // response kalau left(error) dia akan menampilkan error
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          // kalau responsenya successs namun datanya null maka munculkan error
          if (response.data == null) {
            return Left(AppExceptions(
              message: 'Invalid response from server',
              statusCode: 1,
              identifier:
                  'LoginUserRemoteDataSource.registerUser() - Null response data',
            ));
          }

          // kalau response success akan menampilkan data
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
  Future<Either<AppExceptions, UserResponse>> refreshToken(
      String accessToken) async {
    try {
      final eitherType = await networkService.post('/auth/refresh', data: {
        'access_token': accessToken,
      });

      return eitherType.fold((exception) {
        return Left(exception);
      }, (userResponse) async {
        if (userResponse.data == null) {
          return Left(AppExceptions(
            message: 'Invalid response from server',
            statusCode: 1,
            identifier:
                'LoginUserRemoteDataSource.loginUser() - Null response data',
          ));
        }

        // Ambil token dari response
        final String accessToken = userResponse.data['access_token'];

        // Simpan token ke SecureStorage
        await storage.saveToken(accessToken);
        // Cek apakah token tersimpan dengan benar
        final savedToken = await storage.getToken();
        debugPrint("DEBUG: Access Token yang tersimpan = $savedToken");

        final user = UserResponse(
          accessToken: accessToken,
          data: User.fromJson(userResponse.data['data']),
        );

        // Update header dengan token yang baru
        networkService.updateHeaders({
          'Authorization': 'Bearer $accessToken',
        });

        return Right(user);
      });
    } catch (e) {
      // kalau  serverError akan menampilkan error
      return Left(AppExceptions(
        message:
            'Failed to login. Please check your credentials and try again.',
        statusCode: 1,
        identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser()',
      ));
    }
  }

  // @override
  // Future<Either<AppExceptions, User>> getUser(String accessToken) async {
  //   try {
  //     final response = await networkService.get(
  //       '/auth/me',
  //       queryParameters: {
  //         'access_token': accessToken,
  //       },
  //     );

  //     return response.fold(
  //       (exception) {
  //         return Left(exception);
  //       },
  //       (response) {
  //         if (response.data == null) {
  //           return Left(AppExceptions(
  //             message: 'Invalid response from server',
  //             statusCode: 1,
  //             identifier:
  //                 'LoginUserRemoteDataSource.getUser() - Null response data',
  //           ));
  //         }
  //         return Right(User.fromJson(response.data));
  //       },
  //     );
  //   } catch (e) {
  //     return Left(AppExceptions(
  //       message: 'Failed to get user data. Please try again later.',
  //       statusCode: 1,
  //       identifier: '${e.toString()}\nLoginUserRemoteDataSource.getUser()',
  //     ));
  //   }
  // }
}
