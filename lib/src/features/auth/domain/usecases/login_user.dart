// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dulinan/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:dulinan/src/shared/domain/models/either.dart';
import 'package:dulinan/src/shared/domain/models/user/user_model.dart';
import 'package:dulinan/src/shared/exceptions/http_exceptions.dart';

class LoginUser {
  final AuthenticationRepository authenticationRepository;
  LoginUser({
    required this.authenticationRepository,
  });

  Future<Either<AppExceptions, User>> excute({required User user}) async {
    return await authenticationRepository.loginUser(user: user);
  }
}
