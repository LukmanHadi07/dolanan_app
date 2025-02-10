import 'package:dio/dio.dart';
import 'package:dulinan/src/core/storage/secure_storage.dart';

class InterceptorDulinan extends Interceptor {
  final SecureStorage storageToken;

  InterceptorDulinan(this.storageToken);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await storageToken.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token mungkin expired, kamu bisa menangani refresh token di sini
      // Contoh: lakukan refresh token atau hapus token dari storage
      await storageToken.deleteToken();
    }
    return handler.next(err);
  }
}
