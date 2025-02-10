import 'package:dio/dio.dart';
import 'package:dulinan/src/configs/app_configs.dart';
import 'package:dulinan/src/configs/interceptor.dart';
import 'package:dulinan/src/shared/data/remote/network_service.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/domain/models/response.dart' as response;
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';
import 'package:dulinan/src/shared/mixins/exception_handler_mixin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  // constructor untuk dio
  DioNetworkService(this.dio, {FlutterSecureStorage? storage})
      // jika storage tidak null, maka secureStorage = storage
      : secureStorage = storage ?? const FlutterSecureStorage() {
    // mengatur base options
    dio.options = dioBaseOptions;
    // menambahkan interceptor untuk dio
    dio.interceptors.add(AuthInterceptor(secureStorage: secureStorage));

    if (kDebugMode) {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  // method untuk mengembalikan base options
  BaseOptions get dioBaseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
      );

  // method untuk mengembalikan base url
  @override
  String get baseUrl => AppConfigs.baseUrl;

  // method untuk mengembalikan header
  @override
  Map<String, Object> get headers => {
        'accept': 'application/json',
        'content-type': 'application/json',
      };

  // method untuk memperbarui header
  @override
  Map<String, dynamic>? updateHeaders(Map<String, dynamic> data) {
    // mengambil header sebelumnya
    final header = {...data, ...headers};
    // memperbarui header
    dio.options.headers = header;
    return header;
  }

  // method untuk mengirim data dengan request post
  @override
  Future<Either<AppExceptions, response.Response>> post(String endpoint,
      {Map<String, dynamic>? data}) {
    // memanggil method handleException
    final res = handleException(
      () => dio.post(
        // endpoint url
        endpoint,
        // parameter yang akan dikirim
        data: data,
      ),
      // endpoint url
      endpoint: endpoint,
    );
    // kembalikan response
    return res;
  }

  // method untuk mengambil data dengan request get
  @override
  Future<Either<AppExceptions, response.Response>> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) {
    // memanggil method handleException
    final res = handleException(
      () => dio.get(
        // endpoint url
        endpoint,
        // parameter yang akan dikirim
        queryParameters: queryParameters,
      ),
      // endpoint url
      endpoint: endpoint,
    );
    // kembalikan response
    return res;
  }
}
