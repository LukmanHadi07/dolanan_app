// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import 'package:dulinan/src/core/storage/secure_storage.dart';
import 'package:dulinan/src/features/auth/domain/repositories/auth_repository.dart';

class InterceptorDulinan extends Interceptor {
  final SecureStorage storageToken;
  final AuthenticationRepository? authenticationRepository;

  InterceptorDulinan(
    this.storageToken,
    this.authenticationRepository,
  );

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await storageToken.getToken();
    String? tokenExpiryStr = await storageToken.getTokenExpiry();

    if (token != null && tokenExpiryStr != null) {
      final expiryTime = DateTime.tryParse(tokenExpiryStr);
      final now = DateTime.now();

      if (expiryTime != null && expiryTime.difference(now).inMinutes < 15) {
        final newTokenResponse =
            await authenticationRepository!.refreshToken(token);

        await newTokenResponse.fold(
          (error) {
            handler.reject(DioException(
              requestOptions: options,
              response: Response(
                requestOptions: options,
                statusCode: 401,
                statusMessage: "Token Expired",
              ),
            ));
          },
          (newUserResponse) async {
            final newToken = newUserResponse.accessToken;
            final newExpiry = newUserResponse.expiresAt;

            if (newToken != null && newExpiry != null) {
              await storageToken.saveToken(newToken);
              await storageToken.saveTokenExpiry(newExpiry);
              token = newToken; // Gunakan token yang baru diperbarui
            }
          },
        );
      }

      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await storageToken.deleteToken();
    }
    return handler.next(err);
  }
}
