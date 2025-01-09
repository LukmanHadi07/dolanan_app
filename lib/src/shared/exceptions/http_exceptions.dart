// ignore_for_file: public_member_api_docs, sor
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/domain/models/response.dart';
import 'package:equatable/equatable.dart';

class AppExceptions implements Exception {
  final String message;
  final int statusCode;
  final String identifier;
  AppExceptions({
    required this.message,
    required this.statusCode,
    required this.identifier,
  });

  @override
  String toString() =>
      'AppExceptions(meesage: $message, statusCode: $statusCode, identifier: $identifier)';
}

class CacheFailureException extends Equatable implements AppExceptions {
  @override
  String get identifier => 'cache failure exceptions';

  @override
  String get message => 'unable to save ';

  @override
  int get statusCode => 100;

  @override
  List<Object?> get props => [message, statusCode, identifier];
}

extension HttpExceptionsExtentions on AppExceptions {
  Left<AppExceptions, Response> get toLeft =>
      Left<AppExceptions, Response>(this);
}
