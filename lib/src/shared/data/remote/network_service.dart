import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/domain/models/response.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

// method abstract class NetworkService untuk dioNetworkService
abstract class NetworkService {
  // method untuk mengembalikan base url
  String get baseUrl;

  // method untuk mengembalikan headers
  Map<String, Object> get headers;

  // method untuk memperbarui headers
  void updateHeaders(Map<String, dynamic> data);

  // method untuk mengambil data
  Future<Either<AppExceptions, Response>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  // method untuk mengirim data
  Future<Either<AppExceptions, Response>> post(
    String endpoint, {
    Map<String, dynamic>? data,
  });
}
