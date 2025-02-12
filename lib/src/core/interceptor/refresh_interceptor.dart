import 'package:dio/dio.dart';
import 'package:dulinan/src/configs/app_configs.dart';
import 'package:dulinan/src/core/storage/secure_storage.dart';

class RefreshTokenInterceptor extends Interceptor {
  final SecureStorage storage;
  final Dio refreshDio;
  bool _isRefreshing = false;
  String? _newToken;

  RefreshTokenInterceptor(this.storage)
      : refreshDio = Dio(BaseOptions(
          baseUrl: AppConfigs.baseUrl,
          headers: {
            'accept': 'application/json',
            'content-type': 'application/json',
          },
        ));

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await storage.getToken();
    final tokenExpiry = await storage.getTokenExpiry();

    if (token != null) {
      final expiryTime = DateTime.tryParse(tokenExpiry ?? '');
      final now = DateTime.now();

      if (expiryTime != null && expiryTime.difference(now).inMinutes < 15) {
        if (_isRefreshing) {
          await Future.delayed(const Duration(milliseconds: 500));
          options.headers['Authorization'] = 'Bearer $_newToken';
        } else {
          final newToken = await _refreshToken();
          if (newToken != null) {
            options.headers['Authorization'] = 'Bearer $newToken';
          }
        }
      } else {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final newToken = await _refreshToken();

      if (newToken != null) {
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        final retryResponse = await refreshDio.fetch(err.requestOptions);
        return handler.resolve(retryResponse);
      }
    }

    handler.next(err);
  }

  Future<String?> _refreshToken() async {
    if (_isRefreshing) return _newToken;

    _isRefreshing = true;
    final token = await storage.getToken();
    try {
      final response = await refreshDio.post('/auth/refresh', data: {
        'access_token': token,
      });

      if (response.statusCode == 200 && response.data != null) {
        _newToken = response.data['access_token'];
        final newExpiry = response.data['expires_at'];

        await storage.saveToken(_newToken!);
        await storage.saveTokenExpiry(newExpiry);

        _isRefreshing = false;
        return _newToken;
      }
    } catch (e) {
      await storage.deleteToken();
      _isRefreshing = false;
      return null;
    }
    _isRefreshing = false;
    return null;
  }
}
