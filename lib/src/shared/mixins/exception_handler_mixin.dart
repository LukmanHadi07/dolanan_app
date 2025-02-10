import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dulinan/src/shared/data/remote/network_service.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/domain/models/response.dart' as response;
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

// method untuk mengandle exception atau error dari api
mixin ExceptionHandlerMixin on NetworkService {
  Future<Either<AppExceptions, response.Response>>
      handleException<T extends Object>(
          Future<Response<dynamic>> Function() handler,
          {String endpoint = ''}) async {
    try {
      final res = await handler();
      return Right(response.Response(
        statusCode: res.statusCode ?? 200,
        statusMessage: res.statusMessage,
        data: res.data,
      ));
    } catch (e) {
      String message = '';
      String identifier = '';
      int statusCode = 0;
      switch (e.runtimeType) {
        case SocketException _:
          e as SocketException;
          message = 'Unable to connect to the server';
          statusCode = 0;
          identifier = 'socket_exception ${e.message}\n at $endpoint';
          break;
        case DioException _:
          e as DioException;
          message = e.response?.data?['message'] ?? 'Internal Error occurred';
          statusCode = 1;
          identifier = 'DioException ${e.message} \nat  $endpoint';
          break;
        default:
          message = 'Unknown error occurred';
          statusCode = 2;
          identifier = 'Unknown error ${e.toString()}\n at $endpoint';
      }
      return Left(AppExceptions(
        message: message,
        statusCode: statusCode,
        identifier: identifier,
      ));
    }
  }
}
