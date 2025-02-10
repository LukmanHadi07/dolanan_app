import 'package:dulinan/src/features/user/domain/entities/user.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

abstract class UserRepository {
  Future<Either<AppExceptions, User>> fetchUser();
}
