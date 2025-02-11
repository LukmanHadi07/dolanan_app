import 'package:dulinan/src/core/storage/secure_storage.dart';
import 'package:dulinan/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:dulinan/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:dulinan/src/features/user/data/models/user_response.dart';

import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  // authDataSource untuk mengakses AuthRemoteDataSource
  final AuthDataSource authDataSource;

  // storage untuk mengakses SecureStorage yang menyimpan token dari user
  final SecureStorage storage;

  // static const String tokenKey = 'access_token';
  // static const String userKey = 'user_data';

  AuthenticationRepositoryImpl({
    required this.authDataSource,
    required this.storage,
  });

  // implementasi method login  dari AuthenticationRepository yang berasal dari AuthDataSource
  // either untuk menangani response yang success dan error
  // userResponse untuk menangani response yang success
  // mengirim parameter email dan password
  @override
  Future<Either<AppExceptions, UserResponse>> login(
      String email, String password) async {
    // mengirim request dengan metode api post ke endpoint login dari AuthDataSource
    final resp = await authDataSource.loginUser(email, password);

    // response kalau left(error) dia akan menampilkan error
    return resp.fold(
      (error) => Left(error),
      // jika response success, maka akan mengembalikan user
      (userResponse) async {
        // menyimpan user token ke storage agar user tidak perlu login lagi
        await storage.saveToken(userResponse.accessToken.toString());
        // await storage.write(key: tokenKey, value: userResponse.accessToken);
        return Right(userResponse);
      },
    );
  }

  @override
  Future<Either<AppExceptions, UserResponse>> refreshToken(
      String accessToken) async {
    final resp = await authDataSource.refreshToken(accessToken);
    return resp.fold(
      (error) => Left(error),
      (userResponse) async {
        await storage.saveToken(userResponse.accessToken.toString());
        return Right(userResponse);
      },
    );
  }

  // implementasi method register  dari AuthenticationRepository yang berasal dari AuthDataSource
  // either untuk menangani response yang success dan error
  // userResponse untuk menangani response yang success
  // mengirim parameter name, email, dan password
  @override
  Future<Either<AppExceptions, UserResponse>> register(
      String name, String email, String password) async {
    // mengirim request dengan metode api post ke endpoint register
    final resp = await authDataSource.registerUser(name, email, password);
    // response kalau left(error) dia akan menampilkan error
    return resp.fold((error) {
      return Left(error);
      // jika response success, maka akan mengembalikan user
    }, (userResponse) async {
      // menyimpan user token ke storage agar user tidak perlu login lagi
      await storage.saveToken(userResponse.accessToken.toString());
      // await storage.write(key: tokenKey, value: userResponse.accessToken);
      return Right(userResponse);
    });
  }

  // method mengecek apakah user sudah login atau belum dengan megecek token
  @override
  Future<bool> isLoggedIn() async {
    final token = await storage.getToken();
    // final token = await storage.read(key: 'access_token');
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
