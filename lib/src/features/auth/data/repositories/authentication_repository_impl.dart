import 'package:dulinan/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:dulinan/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:dulinan/src/features/user/data/models/user_response.dart';

import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthDataSource authDataSource;
  final FlutterSecureStorage storage;

  static const String tokenKey = 'access_token';
  static const String userKey = 'user_data';

  AuthenticationRepositoryImpl({
    required this.authDataSource,
    required this.storage,
  });

  @override
  Future<Either<AppExceptions, UserResponse>> login(
      String email, String password) async {
    final resp = await authDataSource.loginUser(email, password);

    return resp.fold(
      (error) => Left(error),
      (userResponse) async {
        await storage.write(key: tokenKey, value: userResponse.accessToken);
        return Right(userResponse);
      },
    );
  }

  @override
  Future<Either<AppExceptions, UserResponse>> register(
      String name, String email, String password) async {
    final resp = await authDataSource.registerUser(name, email, password);
    return resp.fold((error) {
      return Left(error);
    }, (userResponse) async {
      await storage.write(key: tokenKey, value: userResponse.accessToken);
      return Right(userResponse);
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'access_token');
    return token != null && token.isNotEmpty;
  }

  // @override
  // Future<Either<AppExceptions, UserResponse>> register(
  //     String name, String email, String password) async {
  //   final result = await authDataSource.registerUser(name, email, password);

  //   return result.fold(
  //     (error) => Left(error),
  //     (userResponse) async {
  //       // Save token if registration automatically logs in user
  //       if (userResponse.accessToken != null &&
  //           userResponse.accessToken!.isNotEmpty) {
  //         await storage.write(key: tokenKey, value: userResponse.accessToken);
  //       }
  //       return Right(userResponse);
  //     },
  //   );
  // }

  // @override
  // Future<Either<AppExceptions, User>> getCurrentUser(String accessToken) async {
  //   return await authDataSource.getUser(accessToken);
  // }

  // // Additional methods for token management
  // Future<String?> getStoredToken() async {
  //   return await storage.read(key: tokenKey);
  // }

  // Future<bool> hasToken() async {
  //   final token = await storage.read(key: tokenKey);
  //   return token != null && token.isNotEmpty;
  // }

  // Future<void> deleteToken() async {
  //   await storage.delete(key: tokenKey);
  // }

  // Future<void> logout() async {
  //   await storage.deleteAll();
  // }

  // // Method to check if user is authenticated
  // Future<bool> isAuthenticated() async {
  //   final token = await getStoredToken();
  //   if (token == null || token.isEmpty) {
  //     return false;
  //   }

  //   final userResult = await getCurrentUser(token);
  //   return userResult.fold(
  //     (error) => false,
  //     (user) => true,
  //   );
  // }
}
