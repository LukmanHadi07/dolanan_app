// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

class Response {
  final int statusCode;
  final String? statusMessage;
  final dynamic data;
  Response({
    required this.statusCode,
    this.statusMessage,
    required this.data,
  });

  @override
  String toString() =>
      'Response(statusCode: $statusCode, statusMessage: $statusMessage, data: $data)';
}

extension ResponseExtension on Response {
  Right<AppExceptions, Response> get toRight => Right(this);
}
