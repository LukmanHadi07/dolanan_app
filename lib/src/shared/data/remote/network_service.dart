import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/domain/models/response.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

abstract class NetworkService {
  String get baseUrl;

  Map<String, Object> get headers;

  void updateHeaders(Map<String, dynamic> data);

  Future<Either<AppExceptions, Response>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<AppExceptions, Response>> post(
    String endpoint, {
    Map<String, dynamic>? data,
  });
}
