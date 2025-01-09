import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/domain/models/user/user_model.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

abstract class AuthenticationRepository {
  Future<Either<AppExceptions, User>> loginUser({required User user});
}
