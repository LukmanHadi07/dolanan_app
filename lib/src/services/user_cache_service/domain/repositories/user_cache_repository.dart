import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/domain/models/user/user_model.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

abstract class UserRepository {
  Future<Either<AppExceptions, User>> fetchUser();
  Future<bool> saveUser({required User user});
  Future<void> saveUserToken(String token);
  Future<String?> getUserToken();
  Future<bool> deleteUser();
  Future<bool> hasUser();
}
